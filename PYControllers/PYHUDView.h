//
//  PYHUDView.h
//  PYUIKit
//
//  Created by Chen Push on 3/11/13.
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

#import "PYView.h"

/*
 Singleton:PYHUDView
 The HUD View is stand for: Head Up Display View.
 The view is used to show some message to the end-user but not to interrupt the user inactive.
 */
@interface PYHUDView : PYView
{
    BOOL                                _isEnableUserInactive;
    
    // Content
    NSString                            *_title;
    NSString                            *_message;
    BOOL                                _isShowIndicator;
    
    // Subviews
    PYView                              *_contentView;
    UIView                              *_customizedView;
    UILabel                             *_titleLabel;
    UILabel                             *_messageLabel;
    UIActivityIndicatorView             *_indicatorView;
    
    // Statues
    NSTimer                             *_autoHidingTimer;
    UIWindow                            *_containerWindow;
}

// Global setting for HUDView
+ (void)setIsEnableUserInactive:(BOOL)isEnable;
/* Style */
+ (void)setBackgroundAlpha:(CGFloat)alpha;
+ (void)setCornerRadius:(CGFloat)radius;
+ (void)setEnableDropShadow:(BOOL)isEnable;
+ (CGFloat)displayAnimationDuration;

// Actions for developers to use
/* Hide the hud view directly */
+ (void)hideHUDView;
/* Hide the hud view after the specified seconds */
+ (void)hideHUDViewAfter:(CGFloat)seconds;

/* Display the specified message until hide manually */
+ (void)displayMessage:(NSString *)message;
/* Display the message for the duration */
+ (void)displayMessage:(NSString *)message duration:(CGFloat)duration;

/* Display a customized view */
+ (void)displayCustomizedInfo:(UIView *)customizedView;
/* Display a customized view for the duration */
+ (void)displayCustomizedInfo:(UIView *)customizedView duration:(CGFloat)duration;

/* Display an indicate view with specified message */
+ (void)displayIndicateWithMessage:(NSString *)message;
/* Display an indicate view with specified message for the duration */
+ (void)displayIndicateWithMessage:(NSString *)message duration:(CGFloat)duration;

/* Display title + detail message */
+ (void)displayTitle:(NSString *)title withDetail:(NSString *)details;
/* Display title + detail message for the duration */
+ (void)displayTitle:(NSString *)title withDetail:(NSString *)details duration:(CGFloat)duration;

@end

// @littlepush
// littlepush@gmail.com
// PYLab
