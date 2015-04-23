//
//  PYHUDView+Singleton.m
//  PYUIKit
//
//  Created by Push Chen on 3/13/13.
//  Copyright (c) 2013 PushLab. All rights reserved.
//

/*
 LGPL V3 Lisence
 This file is part of cleandns.
 
 PYControllers is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 PYData is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with cleandns.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 LISENCE FOR IPY
 COPYRIGHT (c) 2013, Push Chen.
 ALL RIGHTS RESERVED.
 
 REDISTRIBUTION AND USE IN SOURCE AND BINARY
 FORMS, WITH OR WITHOUT MODIFICATION, ARE
 PERMITTED PROVIDED THAT THE FOLLOWING CONDITIONS
 ARE MET:
 
 YOU USE IT, AND YOU JUST USE IT!.
 WHY NOT USE THIS LIBRARY IN YOUR CODE TO MAKE
 THE DEVELOPMENT HAPPIER!
 ENJOY YOUR LIFE AND BE FAR AWAY FROM BUGS.
 */

#import "PYHUDView+Singleton.h"

static PYHUDView                        *_gQTHudView;

@implementation PYHUDView (Singleton)

// Internal
- (void)_cleanAutoHidingTimer
{
    if ( _autoHidingTimer != nil ) {
        [_autoHidingTimer invalidate];
        _autoHidingTimer = nil;
    }
}

- (void)_startAutoHidingTimer:(CGFloat)duration
{
    _autoHidingTimer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                        target:self
                                                      selector:@selector(_autoHidingTimerHandler:)
                                                      userInfo:nil
                                                       repeats:NO];
}

- (void)_autoHidingTimerHandler:(NSTimer *)timer
{
    [PYHUDView hideHUDView];
}

- (void)_clearAllData
{
    _title = nil;
    _message = nil;
    _isShowIndicator = NO;
    
    if ( _titleLabel != nil ) {
        _titleLabel.text = @"";
        [_titleLabel removeFromSuperview];
    }
    if ( _messageLabel != nil ) {
        _messageLabel.text = @"";
        [_messageLabel removeFromSuperview];
    }
    if ( _indicatorView != nil ) {
        [_indicatorView removeFromSuperview];
    }
    // Release the customized view
    if ( _customizedView != nil ) {
        [_customizedView removeFromSuperview];
        _customizedView = nil;
    }
    
    [self removeFromSuperview];
}

- (void)_showHUDView
{
    // Kernel Method
    // Create the window
    if ( _containerWindow == nil ) {
        _containerWindow = [UIApplication sharedApplication].keyWindow;
        if ( _containerWindow == nil ) return;
    }
    [self setUserInteractionEnabled:!_isEnableUserInactive];
    //[_containerWindow setUserInteractionEnabled:!_isEnableUserInactive];
    
    [self setAlpha:0];
    if ( self.superview == nil ) {
        [_containerWindow addSubview:self];
    }
    
    [self.superview bringSubviewToFront:self];
    
    // Resize the frame
    if ( _customizedView != nil ) {
        CGRect _customizeFrame = _customizedView.bounds;
        [self addSubview:_customizedView];
        [self setFrame:[self _calculateHUDFrame:_customizeFrame.size]];
        [_customizedView setCenter:_contentView.center];
    } else {
        CGSize _frameSize = CGSizeZero;
        UIView *_headView = nil;
        if ( _isShowIndicator == YES ) {
            _frameSize = CGSizeMake(36.f, 36.f);
            if ( _indicatorView == nil ) {
                _indicatorView =
                [[UIActivityIndicatorView alloc]
                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            }
            [self addSubview:_indicatorView];
            [_indicatorView startAnimating];
            _headView = _indicatorView;
        }
        if ( [_title length] > 0 ) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000    // 7.0
            CGSize _titleSize = [_title sizeWithAttributes:@{NSFontAttributeName:_titleLabel.font}];
#else
            CGSize _titleSize = [_title sizeWithFont:_titleLabel.font];
#endif
            if ( _titleSize.width > _maxWidth )  {
                // max: half of the screen
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000    // 7.0
                _titleSize = [_title boundingRectWithSize:CGSizeMake(_maxWidth, 120.f)
                                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                                           NSStringDrawingTruncatesLastVisibleLine)
                                               attributes:@{NSFontAttributeName:_titleLabel.font}
                                                  context:nil].size;
#else
                _titleSize = [_title sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(_maxWidth, 120.f)];
#endif
            };
            _frameSize = _titleSize;
            
            [_titleLabel setText:_title];
            [self addSubview:_titleLabel];
            _headView = _titleLabel;
        }
        CGSize _contentSize = _frameSize;
        CGSize _msgSize = CGSizeMake(0, 0);
        if ( [_message length] > 0 ) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000    // 7.0
            _msgSize = [_message sizeWithAttributes:@{NSFontAttributeName:_messageLabel.font}];
#else
            _msgSize = [_message sizeWithFont:_messageLabel.font];
#endif
            if ( _msgSize.width > _maxWidth ) {
                // no more than 300
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000    // 7.0
                _msgSize = [_message boundingRectWithSize:CGSizeMake(_maxWidth, (_msgSize.width / _maxWidth + 1) * _msgSize.height)
                                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                                           NSStringDrawingTruncatesLastVisibleLine)
                                               attributes:@{NSFontAttributeName:_messageLabel.font}
                                                  context:nil].size;
#else
                _msgSize = [_message sizeWithFont:_messageLabel.font
                                constrainedToSize:CGSizeMake
                            (_maxWidth, (_msgSize.width / _maxWidth + 1) * _msgSize.height)];
#endif
            }
            _contentSize.width = MAX(_contentSize.width, _msgSize.width);
            if ( _headView != nil )
                _contentSize.height += 20.f;    // padding between head and body
            _contentSize.height += _msgSize.height;
            
            [_messageLabel setText:_message];
            [self addSubview:_messageLabel];
        }
        
        CGRect _selfFrame = [self _calculateHUDFrame:_contentSize];
        CGFloat _top = (_selfFrame.size.height - _contentSize.height) / 2;
        if ( _headView != nil ) {
            CGRect _f = CGRectMake((_selfFrame.size.width - _frameSize.width) / 2,
                                   _top, _frameSize.width, _frameSize.height);
            [_headView setFrame:_f];
            _top += (_frameSize.height + 20.f);
        }
        if ( _messageLabel != nil ) {
            CGRect _f = CGRectMake((_selfFrame.size.width - _msgSize.width) / 2,
                                   _top, _msgSize.width, _msgSize.height);
            [_messageLabel setFrame:_f];
        }
        
        // Resize my frame
        [self setFrame:[self _calculateHUDFrame:_contentSize]];
    }
    
    // Display
    dispatch_async( dispatch_get_main_queue(), ^{
        [_containerWindow makeKeyAndVisible];
        [UIView animateWithDuration:[PYHUDView displayAnimationDuration] animations:^{
            [self setAlpha:1.f];
        }];
    });
}

- (CGRect)_calculateHUDFrame:(CGSize)contentSize
{
    CGFloat _width = contentSize.width < _maxWidth ? _maxWidth : contentSize.width;
    CGFloat _height = (contentSize.height >= _width) ? contentSize.height :
    (
     _width / contentSize.height >= (4 / 3) ? (_width / 4 * 3) : contentSize.height
     );
    CGRect _frame = CGRectInset(CGRectMake(0, 0, _width, _height), -5, -5);
    _frame.origin.x = ([UIScreen mainScreen].applicationFrame.size.width - _frame.size.width) / 2;
    _frame.origin.y = ([UIScreen mainScreen].applicationFrame.size.height - _frame.size.height) / 2;
    return _frame;
}

// Singleton
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if ( _gQTHudView == nil ) {
            _gQTHudView = [super allocWithZone:zone];
        }
    }
    return _gQTHudView;
}

+ (PYHUDView *)sharedHUDView
{
    @synchronized(self) {
        if ( _gQTHudView == nil ) {
            _gQTHudView = [[PYHUDView alloc] init];
        }
    }
    return _gQTHudView;
}

@end

// @littlepush
// littlepush@gmail.com
// PYLab
