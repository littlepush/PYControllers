//
//  PYLabel.m
//  PYUIKit
//
//  Created by Push Chen on 7/30/13.
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

#import "PYLabel.h"

@implementation PYLabel

+ (Class)layerClass
{
    return [PYLabelLayer class];
}

- (void)viewJustBeenCreated
{
    [super viewJustBeenCreated];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setUserInteractionEnabled:NO];
}

// Properties...
@dynamic layer;
- (PYLabelLayer *)layer
{
    return (PYLabelLayer *)[super layer];
}

@dynamic text;
- (NSString *)text
{
    return self.layer.text;
}
- (void)setText:(NSString *)text
{
    self.layer.text = text;
}

@dynamic textColor;
- (UIColor *)textColor
{
    return self.layer.textColor;
}
- (void)setTextColor:(UIColor *)textColor
{
    self.layer.textColor = textColor;
}

@dynamic textFont;
- (UIFont *)textFont
{
    return self.layer.textFont;
}
- (void)setTextFont:(UIFont *)textFont
{
    self.layer.textFont = textFont;
}

@dynamic textShadowOffset;
- (CGSize)textShadowOffset
{
    return self.layer.textShadowOffset;
}
- (void)setTextShadowOffset:(CGSize)textShadowOffset
{
    self.layer.textShadowOffset = textShadowOffset;
}

@dynamic textShadowColor;
- (UIColor *)textShadowColor
{
    return self.layer.textShadowColor;
}
- (void)setTextShadowColor:(UIColor *)textShadowColor
{
    self.layer.textShadowColor = textShadowColor;
}

@dynamic textShadowRadius;
- (CGFloat)textShadowRadius
{
    return self.layer.textShadowRadius;
}
- (void)setTextShadowRadius:(CGFloat)textShadowRadius
{
    self.layer.textShadowRadius = textShadowRadius;
}

@dynamic textBorderWidth;
- (CGFloat)textBorderWidth
{
    return self.layer.textBorderWidth;
}
- (void)setTextBorderWidth:(CGFloat)textBorderWidth
{
    self.layer.textBorderWidth = textBorderWidth;
}

@dynamic textBorderColor;
- (UIColor *)textBorderColor
{
    return self.layer.textBorderColor;
}
- (void)setTextBorderColor:(UIColor *)textBorderColor
{
    self.layer.textBorderColor = textBorderColor;
}

@dynamic multipleLine;
- (BOOL)multipleLine
{
    return self.layer.multipleLine;
}
- (void)setMultipleLine:(BOOL)multipleLine
{
    self.layer.multipleLine = multipleLine;
}

@dynamic textAlignment;
- (NSTextAlignment)textAlignment
{
    return self.layer.textAlignment;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    self.layer.textAlignment = textAlignment;
}

@dynamic lineBreakMode;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 //__IPHONE_6_1
- (NSLineBreakMode)lineBreakMode
#else
- (UILineBreakMode)lineBreakMode
#endif
{
    return self.layer.lineBreakMode;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 //__IPHONE_6_1
- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode
#else
- (void)setLineBreakMode:(UILineBreakMode)lineBreakMode
#endif
{
    self.layer.lineBreakMode = lineBreakMode;
}

@dynamic paddingLeft;
- (CGFloat)paddingLeft
{
    return self.layer.paddingLeft;
}
- (void)setPaddingLeft:(CGFloat)paddingLeft
{
    self.layer.paddingLeft = paddingLeft;
}

@dynamic paddingRight;
- (CGFloat)paddingRight
{
    return self.layer.paddingRight;
}
- (void)setPaddingRight:(CGFloat)paddingRight
{
    self.layer.paddingRight = paddingRight;
}

@dynamic paddingTop;
- (CGFloat)paddingTop
{
    return self.layer.paddingTop;
}
- (void)setPaddingTop:(CGFloat)paddingTop
{
    self.layer.paddingTop = paddingTop;
}

@dynamic paddingBottom;
- (CGFloat)paddingBottom
{
    return self.layer.paddingBottom;
}
- (void)setPaddingBottom:(CGFloat)paddingBottom
{
    self.layer.paddingBottom = paddingBottom;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if ( newSuperview == nil ) return;
    [self.layer setNeedsDisplay];
}

@dynamic paddingOfWidth;
- (CGFloat)paddingOfWidth
{
    return self.layer.paddingOfWidth;
}
@dynamic paddingOfHeight;
- (CGFloat)paddingOfHeight
{
    return self.layer.paddingOfHeight;
}

// The content drawing size.
- (CGSize)contentSizeInBounds:(CGSize)maxBounds
{
    return [self.layer contentSizeInBounds:maxBounds];
}

// Fit the the label's size in bounds
- (void)fitSizeInBounds:(CGSize)maxBounds
{
    //[self.layer fitSizeInBounds:maxBounds];
    CGSize _s = [self.layer contentSizeInBounds:maxBounds];
    _s.width += self.layer.paddingOfWidth;
    _s.height += self.layer.paddingOfHeight;
    [self setBounds:CGRectMake(0, 0, _s.width, _s.height)];
}

@end

// @littlepush
// littlepush@gmail.com
// PYLab
