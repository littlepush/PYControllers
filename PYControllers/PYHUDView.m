//
//  PYHUDView.m
//  PYUIKit
//
//  Created by Push Chen on 3/11/13.
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

#import "PYHUDView.h"
#import "PYHUDView+Singleton.h"

@implementation PYHUDView

// Initialize
- (void)viewJustBeenCreated
{
    [super viewJustBeenCreated];
    _isEnableUserInactive = NO;
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    _contentView = [[PYView alloc] init];
    [_contentView setBackgroundColor:[UIColor blackColor]];
    [_contentView setAlpha:.5f];
    [_contentView.layer setCornerRadius:7.5f];
    [_contentView setAutoresizingMask:
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [_contentView setFrame:self.bounds];
    [self addSubview:_contentView];
    
    _maxWidth = 160.f;
    
    // Init the title label
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:17.f]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    // make the title label support multiple lines
    [_titleLabel setNumberOfLines:0];

    _messageLabel = [[UILabel alloc] init];
    [_messageLabel setFont:[UIFont systemFontOfSize:14.f]];
    [_messageLabel setTextColor:[UIColor whiteColor]];
    [_messageLabel setTextAlignment:NSTextAlignmentCenter];
    [_messageLabel setBackgroundColor:[UIColor clearColor]];
    [_messageLabel setNumberOfLines:0];
}
// Settings
+ (CGFloat)displayAnimationDuration
{
    // Singleton setting
    return .35f;
}

+ (void)setIsEnableUserInactive:(BOOL)isEnable
{
    @synchronized(self) {
        ((PYHUDView *)[PYHUDView sharedHUDView])->_isEnableUserInactive = isEnable;
    }
}

// UI
+ (void)setBackgroundAlpha:(CGFloat)alpha
{
    @synchronized(self) {
        [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView setAlpha:alpha];
    }
}

+ (void)setCornerRadius:(CGFloat)radius
{
    @synchronized(self) {
        [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView.layer setCornerRadius:radius];
    }
}

+ (void)setEnableDropShadow:(BOOL)isEnable
{
    @synchronized(self) {
        if ( isEnable ) {
            [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView.layer setShadowColor:[UIColor blackColor].CGColor];
            [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView.layer setShadowOffset:CGSizeMake(1, 1)];
            [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView.layer setShadowOpacity:5.f];
        } else {
            [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView.layer setShadowColor:nil];
            [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView.layer setShadowOffset:CGSizeZero];
            [((PYHUDView *)[PYHUDView sharedHUDView])->_contentView.layer setShadowOpacity:0.f];
        }
    }
}
+ (void)setBackgroundColor:(UIColor *)color
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView]->_contentView setBackgroundColor:color];
    }
}
+ (void)setTitleFont:(UIFont *)font
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView]->_titleLabel setFont:font];
    }
}
+ (void)setMessageFont:(UIFont *)font
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView]->_messageLabel setFont:font];
    }
}
+ (void)setTitleTextColor:(UIColor *)color
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView]->_titleLabel setTextColor:color];
    }
}
+ (void)setMessageTextColor:(UIColor *)color
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView]->_messageLabel setTextColor:color];
    }
}
+ (void)setMaxContentWidth:(CGFloat)width
{
    @synchronized(self) {
        [PYHUDView sharedHUDView]->_maxWidth = width;
    }
}


// Actions
+ (void)hideHUDView
{
    [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
    
    // Hide the hud view
    dispatch_async( dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:[PYHUDView displayAnimationDuration] animations:^{
            [[PYHUDView sharedHUDView] setAlpha:0];
        } completion:^(BOOL finished) {
            if ( ! finished ) return;
            @synchronized(self) {
                [[PYHUDView sharedHUDView] _clearAllData];
            }
        }];
    });
}

+ (void)hideHUDViewAfter:(CGFloat)seconds
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _startAutoHidingTimer:seconds];
    }
}

+ (void)displayMessage:(NSString *)message
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_message = message;
        [[PYHUDView sharedHUDView] _showHUDView];
    }
}

+ (void)displayMessage:(NSString *)message duration:(CGFloat)duration
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_message = message;
        [[PYHUDView sharedHUDView] _showHUDView];
        [[PYHUDView sharedHUDView] _startAutoHidingTimer:duration];
    }
}

+ (void)displayCustomizedInfo:(UIView *)customizedView
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_customizedView = customizedView;
        [[PYHUDView sharedHUDView] _showHUDView];
    }
}

+ (void)displayCustomizedInfo:(UIView *)customizedView duration:(CGFloat)duration
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_customizedView = customizedView;
        [[PYHUDView sharedHUDView] _showHUDView];
        [[PYHUDView sharedHUDView] _startAutoHidingTimer:duration];
    }
}

+ (void)displayIndicateWithMessage:(NSString *)message
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_isShowIndicator = YES;
        [PYHUDView sharedHUDView]->_message  = message;
        [[PYHUDView sharedHUDView] _showHUDView];
    }
}

+ (void)displayIndicateWithMessage:(NSString *)message duration:(CGFloat)duration
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_isShowIndicator = YES;
        [PYHUDView sharedHUDView]->_message  = message;
        [[PYHUDView sharedHUDView] _showHUDView];
        [[PYHUDView sharedHUDView] _startAutoHidingTimer:duration];
    }
}

+ (void)displayTitle:(NSString *)title withDetail:(NSString *)details
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_title = title;
        [PYHUDView sharedHUDView]->_message = details;
        [[PYHUDView sharedHUDView] _showHUDView];
    }
}

+ (void)displayTitle:(NSString *)title withDetail:(NSString *)details duration:(CGFloat)duration
{
    @synchronized(self) {
        [[PYHUDView sharedHUDView] _cleanAutoHidingTimer];
        [[PYHUDView sharedHUDView] _clearAllData];
        [PYHUDView sharedHUDView]->_title = title;
        [PYHUDView sharedHUDView]->_message = details;
        [[PYHUDView sharedHUDView] _showHUDView];
        [[PYHUDView sharedHUDView] _startAutoHidingTimer:duration];
    }
}

@end

// @littlepush
// littlepush@gmail.com
// PYLab
