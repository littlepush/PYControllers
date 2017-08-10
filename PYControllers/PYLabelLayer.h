//
//  PYLabelLayer.h
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

#import <UIKit/UIKit.h>
#import "PYStaticLayer.h"

@interface PYLabelLayer : PYLayer

// Properties like UILabel.
// But all this things will be used to draw text directly in layer.
@property (nonatomic, copy)     NSString            *text;
@property (nonatomic, strong)   UIColor             *textColor;
@property (nonatomic, strong)   UIFont              *textFont;
@property (nonatomic, assign)   CGSize              textShadowOffset;
@property (nonatomic, strong)   UIColor             *textShadowColor;
@property (nonatomic, assign)   CGFloat             textShadowRadius;
@property (nonatomic, assign)   CGFloat             textBorderWidth;
@property (nonatomic, strong)   UIColor             *textBorderColor;

@property (nonatomic, assign)   BOOL                multipleLine;
@property (nonatomic, assign)   NSTextAlignment     textAlignment;

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 60100 // 6.1
@property (nonatomic, assign)   NSLineBreakMode     lineBreakMode;
#else
@property (nonatomic, assign)   UILineBreakMode     lineBreakMode;
#endif

// Padding the left side.
@property (nonatomic, assign)   CGFloat             paddingLeft;
@property (nonatomic, assign)   CGFloat             paddingRight;
@property (nonatomic, assign)   CGFloat             paddingTop;
@property (nonatomic, assign)   CGFloat             paddingBottom;

@property (nonatomic, readonly) CGFloat             paddingOfWidth;
@property (nonatomic, readonly) CGFloat             paddingOfHeight;

// The content drawing size.
- (CGSize)contentSizeInBounds:(CGSize)maxBounds;

// Fit the the label's size in bounds
- (void)fitSizeInBounds:(CGSize)maxBounds;

@end

// @littlepush
// littlepush@gmail.com
// PYLab
