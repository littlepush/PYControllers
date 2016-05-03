//
//  PYButton.m
//  PYUIKit
//
//  Created by Push Chen on 10/10/14.
//  Copyright (c) 2014 Push Lab. All rights reserved.
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

#import "PYButton.h"

@interface PYButton ()
{
    UIColor *_cachedBackgroundColor[5];
    UIFont *_cachedFont[5];
}
@end

@implementation PYButton

- (UIColor *)backgroundColorForState:(UIControlState)state
{
    if ( _cachedBackgroundColor[state] == nil ) return self.backgroundColor;
    return _cachedBackgroundColor[state];
}

- (UIFont *)titleFontForState:(UIControlState)state
{
    if ( _cachedFont[state] == nil ) return self.titleLabel.font;
    return _cachedFont[state];
}

- (void)initializeTargetBind
{
    [self addTarget:self action:@selector(actionOnTouchDown:)
   forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(actionOnTouchUp:)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(actionOnTouchUp:)
   forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(actionOnTouchUp:)
   forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(actionOnTouchUp:)
   forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(actionOnTouchUp:)
   forControlEvents:UIControlEventTouchCancel];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self ) {
        [self initializeTargetBind];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if ( self ) {
        [self initializeTargetBind];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        [self initializeTargetBind];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    // Override
    [super setBackgroundColor:backgroundColor];
    _cachedBackgroundColor[UIControlStateNormal] = backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    _cachedBackgroundColor[state] = backgroundColor;
    if ( state == self.state ) {
        [super setBackgroundColor:backgroundColor];
    }
}

- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state
{
    _cachedFont[state] = font;
    if ( state == self.state ) {
        [self.titleLabel setFont:font];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if ( selected ) {
        if ( _cachedBackgroundColor[UIControlStateSelected] != nil ) {
            [super setBackgroundColor:_cachedBackgroundColor[UIControlStateSelected]];
        }
        if ( _cachedFont[UIControlStateSelected] != nil ) {
            [self.titleLabel setFont:_cachedFont[UIControlStateSelected]];
        }
    } else {
        if ( _cachedBackgroundColor[UIControlStateNormal] != nil ) {
            [super setBackgroundColor:_cachedBackgroundColor[UIControlStateNormal]];
        }
        if ( _cachedFont[UIControlStateSelected] != nil ) {
            [self.titleLabel setFont:_cachedFont[UIControlStateNormal]];
        }
    }
}
- (void)actionOnTouchDown:(id)sender
{
    if ( _cachedBackgroundColor[UIControlStateHighlighted] != nil ) {
        [super setBackgroundColor:_cachedBackgroundColor[UIControlStateHighlighted]];
    }
    if ( _cachedFont[UIControlStateHighlighted] != nil ) {
        [self.titleLabel setFont:_cachedFont[UIControlStateHighlighted]];
    }
}

- (void)actionOnTouchUp:(id)sender
{
    if ( self.enabled && self.selected ) {
        if ( _cachedBackgroundColor[UIControlStateSelected] != nil ) {
            [super setBackgroundColor:_cachedBackgroundColor[UIControlStateSelected]];
        }
        if ( _cachedFont[UIControlStateSelected] != nil ) {
            [self.titleLabel setFont:_cachedFont[UIControlStateSelected]];
        }
    } else if ( self.enabled == NO ) {
        if ( _cachedBackgroundColor[UIControlStateDisabled] != nil ) {
            [super setBackgroundColor:_cachedBackgroundColor[UIControlStateDisabled]];
        }
        if ( _cachedFont[UIControlStateDisabled] != nil ) {
            [self.titleLabel setFont:_cachedFont[UIControlStateDisabled]];
        }
    } else {
        if ( _cachedBackgroundColor[UIControlStateNormal] != nil ) {
            [super setBackgroundColor:_cachedBackgroundColor[UIControlStateNormal]];
        }
        if ( _cachedFont[UIControlStateNormal] != nil ) {
            [self.titleLabel setFont:_cachedFont[UIControlStateNormal]];
        }
    }
}

@end

// @littlepush
// littlepush@gmail.com
// PYLab
