//
//  PYLabelLayer.m
//  PYUIKit
//
//  Created by Push Chen on 7/29/13.
//  Copyright (c) 2013 Push Lab. All rights reserved.
//

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
    CGSize _textSize = [_text sizeWithAttributes:@{NSFontAttributeName:_textFont}];
#else
    CGSize _textSize = [_text sizeWithFont:_textFont];
#endif
    CGRect _textFrame = _bounds;
    _textFrame.origin.x += _paddingLeft;
    _textFrame.size.width -= (_paddingLeft + _paddingRight);
    if ( _multipleLine ) {
        _textSize.height = _textSize.height * (((int)_textSize.width / (int)_textFrame.size.width) + 1);
        if ( _textSize.height > _bounds.size.height )
            _textSize.height = _bounds.size.height;
    }
    _textFrame.origin.y = (_textFrame.size.height - _textSize.height) / 2;
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
