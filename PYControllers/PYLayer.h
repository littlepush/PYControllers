//
//  PYLayer.h
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

#import <QuartzCore/QuartzCore.h>

@interface PYLayer : CALayer

// Make PYLayer to support debug, draw a random border with width 1.
+ (void)setDebugEnabled:(BOOL)enableDebug;
+ (BOOL)isDebugEnabled;

// Properties
@property (nonatomic, assign)   int         tag;

// After initialize the layer from super init function, invoke
// this message.
// On default, will set the content scale same as the main screen.
- (void)layerJustBeenCreated;

// The layer is created with other layer.
- (void)layerJustBeenCopyed;

// Will be add to/remove from super layer
- (void)willMoveToSuperLayer:(CALayer *)layer;

@end

// @littlepush
// littlepush@gmail.com
// PYLab
