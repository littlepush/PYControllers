//
//  PYInnerShadowLayer.m
//  PYUIKit
//
//  Created by Push Chen on 7/24/13.
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

#import "PYInnerShadowLayer.h"
#import <PYCore/PYCore.h>

@interface PYInnerShadowLayer ()
{
    PYPadding                           _shadowPadding;
    UIColor                             *_innerShadowColor;
    
    // Cached shadow path.
    CGFloat                             _maxPadding;
    UIBezierPath                        *_innerShadowPath;
    UIBezierPath                        *_outterBorderPath;
}
@end

@implementation PYInnerShadowLayer

- (void)dealloc
{
    _innerShadowPath = nil;
    _outterBorderPath = nil;
}

@synthesize shadowPadding = _shadowPadding;
- (void)setShadowPadding:(PYPadding)padding
{
    _shadowPadding = padding;
    [self _reCalculatePath];
}
@synthesize innerShadowColor = _innerShadowColor;
// Make the default shadow color to set the inner shadow color
- (void)setShadowColor:(CGColorRef)color
{
    _innerShadowColor = [UIColor colorWithCGColor:color];
}

// Set default color
- (void)layerJustBeenCreated
{
    [super layerJustBeenCreated];
    _innerShadowColor = [UIColor blackColor];
    [self setMasksToBounds:YES];
}
- (void)layerJustBeenCopyed
{
    [super layerJustBeenCopyed];
    _innerShadowColor = [UIColor blackColor];
    [self setMasksToBounds:YES];
}

- (void)_reCalculatePath
{
    // Re-calculate the bezier path
    
    // min no shadow rect size
    CGRect _noShadowRect = self.bounds;
    
    // resize the min space with shadow rect
    _maxPadding = MAX(
                      MAX(_shadowPadding.left, _shadowPadding.right),
                      MAX(_shadowPadding.top, _shadowPadding.bottom)
                      );
    _noShadowRect.origin.x -= PYABSF(_maxPadding - _shadowPadding.left);
    _noShadowRect.origin.y -= (PYABSF(_maxPadding - _shadowPadding.top) + 1);
    _noShadowRect.size.width += PYABSF(_maxPadding - _shadowPadding.left);
    _noShadowRect.size.width += PYABSF(_maxPadding - _shadowPadding.right);
    _noShadowRect.size.height += PYABSF(_maxPadding - _shadowPadding.top);
    _noShadowRect.size.height += (PYABSF(_maxPadding - _shadowPadding.bottom) + 1);
    
    // Create the no shadow path
    _innerShadowPath = [UIBezierPath
                        bezierPathWithRoundedRect:_noShadowRect
                        cornerRadius:self.superlayer.cornerRadius];
    _outterBorderPath = [UIBezierPath
                         bezierPathWithRoundedRect:CGRectInset(_noShadowRect, -_maxPadding, -_maxPadding)
                         cornerRadius:self.superlayer.cornerRadius];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self _reCalculatePath];
}

- (void)drawInContext:(CGContextRef)ctx
{
    if ( _innerShadowPath == nil || _outterBorderPath == nil ) return;
    
    CGContextAddPath(ctx, _innerShadowPath.CGPath);
    CGContextAddPath(ctx, _outterBorderPath.CGPath);

    CGContextSetShadowWithColor(ctx,
                                CGSizeMake(0, 0),
                                _maxPadding,
                                _innerShadowColor.CGColor);
    CGContextEOFillPath(ctx);
}

@end

// @littlepush
// littlepush@gmail.com
// PYLab
