//
//  PYLabelLayer.m
//  PYUIKit
//
//  Created by Push Chen on 7/29/13.
//  Copyright (c) 2013 Push Lab. All rights reserved.
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

#import "PYLabelLayer.h"
#import <PYCore/PYCore.h>

static UIFont       *_gPYLabelFont = nil;
static UIColor      *_gPYLabelColor = nil;

@interface PYLabelLayer ()
{
    NSString                                        *_text;
    UIColor                                         *_textColor;
    UIFont                                          *_textFont;
    CGSize                                          _textShadowOffset;
    UIColor                                         *_textShadowColor;
    CGFloat                                         _textShadowRadius;
    CGFloat                                         _textBorderWidth;
    UIColor                                         *_textBorderColor;
    
    BOOL                                            _multipleLine;
    NSTextAlignment                                 _textAlignment;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 // 6.1
    NSLineBreakMode                                 _lineBreakMode;
#else
    UILineBreakMode                                 _lineBreakMode;
#endif
    CGFloat                                         _paddingLeft;
    CGFloat                                         _paddingRight;
    CGFloat                                         _paddingTop;
    CGFloat                                         _paddingBottom;
}
@end

@implementation PYLabelLayer

+ (void)initialize
{
    _gPYLabelFont = [UIFont systemFontOfSize:14];
    _gPYLabelColor = [UIColor blackColor];
}

@synthesize text = _text;
- (void)setText:(NSString *)text
{
    _text = [text copy];
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
@synthesize textColor = _textColor;
- (void)setTextColor:(UIColor *)aColor
{
    _textColor = aColor;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
@synthesize textFont = _textFont;
- (void)setTextFont:(UIFont *)aFont
{
    _textFont = aFont;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
@synthesize textShadowColor = _textShadowColor;
@synthesize textShadowOffset = _textShadowOffset;
@synthesize textShadowRadius = _textShadowRadius;
- (void)setTextShadowColor:(UIColor *)aColor
{
    _textShadowColor = aColor;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setTextShadowOffset:(CGSize)offset
{
    _textShadowOffset = offset;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setTextShadowRadius:(CGFloat)radius
{
    _textShadowRadius = radius;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
@synthesize textBorderColor = _textBorderColor;
@synthesize textBorderWidth = _textBorderWidth;
- (void)setTextBorderColor:(UIColor *)aColor
{
    _textBorderColor = aColor;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setTextBorderWidth:(CGFloat)width
{
    _textBorderWidth = width;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}

@synthesize textAlignment = _textAlignment;
@synthesize lineBreakMode = _lineBreakMode;
@synthesize multipleLine = _multipleLine;
@synthesize paddingLeft = _paddingLeft;
@synthesize paddingRight = _paddingRight;
@synthesize paddingTop = _paddingTop;
@synthesize paddingBottom = _paddingBottom;
- (void)setTextAlignment:(NSTextAlignment)alignment
{
    _textAlignment = alignment;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 // 6.1
- (void)setLineBreakMode:(NSLineBreakMode)mode
#else
- (void)setLineBreakMode:(UILineBreakMode)mode
#endif
{
    _lineBreakMode = mode;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setMultipleLine:(BOOL)multipleLine
{
    _multipleLine = multipleLine;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setPaddingLeft:(CGFloat)padding
{
    _paddingLeft = padding;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setPaddingRight:(CGFloat)padding
{
    _paddingRight = padding;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setPaddingTop:(CGFloat)padding
{
    _paddingTop = padding;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}
- (void)setPaddingBottom:(CGFloat)padding
{
    _paddingBottom = padding;
    if ( self.superlayer ) {
        [self setNeedsDisplay];
    }
}

@dynamic paddingOfWidth;
- (CGFloat)paddingOfWidth
{
    return _paddingLeft + _paddingRight;
}
@dynamic paddingOfHeight;
- (CGFloat)paddingOfHeight
{
    return _paddingTop + _paddingBottom;
}

- (void)layerJustBeenCreated
{
    [super layerJustBeenCreated];
    [self setMasksToBounds:YES];
    self.paddingLeft = 0.f;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 // 6.1
    self.lineBreakMode = NSLineBreakByTruncatingTail;
#else
    self.lineBreakMode = UILineBreakModeTailTruncation;
#endif
}

- (void)layerJustBeenCopyed
{
    [super layerJustBeenCopyed];
    [self setMasksToBounds:YES];
    self.paddingLeft = 0.f;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 // 6.1
    self.lineBreakMode = NSLineBreakByTruncatingTail;
#else
    self.lineBreakMode = UILineBreakModeTailTruncation;
#endif
}

- (void)willMoveToSuperLayer:(CALayer *)layer
{
    if ( layer != nil ) {
        [self setNeedsDisplay];
    }
}

// The content drawing size.
- (CGSize)contentSizeInBounds:(CGSize)maxBounds
{
    NSStringDrawingOptions _op = NSStringDrawingUsesLineFragmentOrigin;
    if ( _multipleLine == NO ) _op = NSStringDrawingUsesFontLeading;
    CGSize _textSize = [_text boundingRectWithSize:CGSizeMake(maxBounds.width - _paddingLeft - _paddingRight,
                                                              maxBounds.height - _paddingTop - _paddingBottom)
                                           options:_op
                                        attributes:@{NSFontAttributeName: _textFont}
                                           context:nil].size;
    return _textSize;
}

// Fit the the label's size in bounds
- (void)fitSizeInBounds:(CGSize)maxBounds
{
    CGSize _s = [self contentSizeInBounds:maxBounds];
    _s.height += self.paddingOfHeight;
    _s.width += self.paddingOfWidth;
    [self setBounds:CGRectMake(0, 0, _s.width, _s.height)];
}

// Display
- (void)drawInContext:(CGContextRef)ctx
{
    if ( ctx == NULL ) return;
    if ( [_text length] == 0 ) return;
    
    // Calculate the text size.
    if ( _textFont == nil ) _textFont = _gPYLabelFont;
    if ( _textColor == nil ) _textColor = _gPYLabelColor;
    
    // Set shadow
    CGContextSetShadowWithColor
    (ctx, _textShadowOffset, _textShadowRadius,
     _textShadowColor.CGColor);

    //[self.textColor setFill];
    CGRect _bounds = self.bounds;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 70000 // 6.1
    CGSize _textSize = [self contentSizeInBounds:self.bounds.size];
#else
    CGSize _textSize = [_text sizeWithFont:_textFont];
#endif
    CGRect _textFrame = _bounds;
    _textFrame.origin.x += _paddingLeft;
    _textFrame.size.width -= (_paddingLeft + _paddingRight);
    _textFrame.origin.y = (_textFrame.size.height - _paddingTop - _paddingBottom - _textSize.height) / 2 + _paddingTop;
    _textFrame.size.height = _textSize.height;
    
    UIGraphicsPushContext(ctx);
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 // 6.1
    if ( SYSTEM_VERSION_LESS_THAN(@"7.0") ) {
        CGContextSetFillColorWithColor(ctx, _textColor.CGColor);
        if ( _textBorderWidth > 0.f && _textBorderColor != nil ) {
            CGContextSetStrokeColorWithColor(ctx, _textBorderColor.CGColor);
            CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
        } else {
            CGContextSetTextDrawingMode(ctx, kCGTextFill);
        }
        // Set shadow
        CGContextSetShadowWithColor
        (ctx, _textShadowOffset, _textShadowRadius,
         _textShadowColor.CGColor);
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        NSMutableParagraphStyle *_pgStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        // Set line break mode
        _pgStyle.lineBreakMode = _lineBreakMode;
        // Set text alignment
        _pgStyle.alignment = _textAlignment;
        [_text
         drawInRect:_textFrame
         withAttributes:@{
                          NSFontAttributeName:_textFont,
                          NSParagraphStyleAttributeName:_pgStyle
                          }];
#else
        [_text drawInRect:_textFrame
                 withFont:_textFont
            lineBreakMode:(NSLineBreakMode)_lineBreakMode
                alignment:_textAlignment];
#endif
    } else {
        NSMutableParagraphStyle *_style = [[NSMutableParagraphStyle alloc] init];
        [_style setAlignment:_textAlignment];
        if ( _multipleLine ) {
            [_style setLineBreakMode:NSLineBreakByCharWrapping];
        } else {
            [_style setLineBreakMode:_lineBreakMode];
        }
        NSMutableDictionary *_attributes = [NSMutableDictionary dictionary];
        [_attributes setObject:_style forKey:NSParagraphStyleAttributeName];
        [_attributes setObject:_textColor forKey:NSForegroundColorAttributeName];
        [_attributes setObject:_textFont forKey:NSFontAttributeName];
        if ( _textBorderWidth > 0.f && _textBorderColor != nil ) {
            [_attributes setObject:_textBorderColor forKey:NSStrokeColorAttributeName];
            [_attributes setObject:PYDoubleToObject(_textBorderWidth) forKey:NSStrokeWidthAttributeName];
        }
        if ( _textShadowColor != nil && !CGSizeEqualToSize(_textShadowOffset, CGSizeZero)) {
            NSShadow *_shadowObj = [NSShadow object];
            _shadowObj.shadowOffset = _textShadowOffset;
            _shadowObj.shadowBlurRadius = _textShadowRadius;
            _shadowObj.shadowColor = _textShadowColor;
            [_attributes setObject:_shadowObj forKey:NSShadowAttributeName];
        }
        [_text drawInRect:_textFrame withAttributes:_attributes];
    }
#else
    CGContextSetFillColorWithColor(ctx, _textColor.CGColor);
    if ( _textBorderWidth > 0.f && _textBorderColor != nil ) {
        CGContextSetStrokeColorWithColor(ctx, _textBorderColor.CGColor);
        CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
    } else {
        CGContextSetTextDrawingMode(ctx, kCGTextFill);
    }
    
    [_text drawInRect:_textFrame
             withFont:_textFont
        lineBreakMode:(NSLineBreakMode)_lineBreakMode
            alignment:_textAlignment];
#endif
    UIGraphicsPopContext();
}

@end

// @littlepush
// littlepush@gmail.com
// PYLab
