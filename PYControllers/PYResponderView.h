//
//  PYResponderView.h
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

#import "PYView.h"
#import "PYResponderGestureRecognizer.h"

@interface PYResponderView : PYView <PYResponderGestureRecognizerDelegate>
{
@private
    // Action Status
    NSSet                               *_beginTouchSet;
    UIEvent                             *_beginEvent;
    
@protected
    // Gesture
    PYResponderGestureRecognizer        *_responderGesture;
    
@private
    // Call back
    NSMutableArray                      *_eventTargetsActions[10];
    BOOL                                _nextResponderReceivedBeginEvent;
}

// Set the responder's supported event's restraint.
// the responder view will detect the event and try to find the target/action
// the event will occurred with the specified restraint.
- (void)setEvent:(PYResponderEvent)event withRestraint:(PYResponderRestraint)restraint;

// Deaccelerate distance / speed formular
+ (CGFloat)distanceToMoveWithInitSpeed:(CGFloat)speed stepRate:(CGFloat)step timePieces:(NSUInteger)piece;
+ (CGFloat)initSpeedWithAllMovingDistance:(CGFloat)distance stepRate:(CGFloat)step timePieces:(NSUInteger)piece;

@property (nonatomic, readonly) CGPoint             firstTouchPoint;
@property (nonatomic, readonly) CGPoint             lastMovePoint;

// Action Status
@property (nonatomic, readonly) BOOL                canTap;
@property (nonatomic, readonly) BOOL                canPress;
@property (nonatomic, readonly) BOOL                canPen;
@property (nonatomic, readonly) BOOL                canSwipe;
@property (nonatomic, readonly) BOOL                canPinch;

// Subaction status
@property (nonatomic, readonly) NSUInteger          tapCount;
@property (nonatomic, readonly) NSUInteger          pressFingers;
@property (nonatomic, readonly) NSUInteger          penDirections;
@property (nonatomic, readonly) NSUInteger          swipeDirections;

// Action Call back
- (void)addTarget:(id)target action:(SEL)action forResponderEvent:(PYResponderEvent)event;
- (void)removeTarget:(id)target action:(SEL)action forResponderEvent:(PYResponderEvent)event;

@end

// @littlepush
// littlepush@gmail.com
// PYLab
