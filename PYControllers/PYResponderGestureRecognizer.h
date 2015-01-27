//
//  PYResponderGestureRecognizer.h
//  PYUIKit
//
//  Created by Push Chen on 8/16/13.
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
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <PYCore/PYStopWatch.h>

typedef NS_OPTIONS(int32_t, PYResponderEvent) {
    PYResponderEventTap                 = 0x0001,
    PYResponderEventPress               = 0x0002,
    PYResponderEventPan                 = 0x0004,
    PYResponderEventSwipe               = 0x0008,
    PYResponderEventPinch               = 0x0010,
    PYResponderEventRotate              = 0x0020,
    PYResponderEventNeedPredirect       = (PYResponderEventTap | PYResponderEventPress |
                                           PYResponderEventPan | PYResponderEventSwipe |
                                           PYResponderEventPinch | PYResponderEventRotate),
    PYResponderEventSupportDragging     = (PYResponderEventPan | PYResponderEventSwipe |
                                           PYResponderEventPinch | PYResponderEventRotate),
    PYResponderEventSingleDragging      = (PYResponderEventPan | PYResponderEventSwipe),
    PYResponderEventMultipleTouches     = (PYResponderEventPress | PYResponderEventPinch |
                                           PYResponderEventRotate),
    PYResponderEventDoubleDragging      = (PYResponderEventPinch | PYResponderEventRotate),
    
    // The following 4 events are default event, you can not disable them or
    // set and restraint.
    PYResponderEventTouchBegin          = 0x0040,
    PYResponderEventTouchMove           = 0x0080,
    PYResponderEventTouchEnd            = 0x0100,
    PYResponderEventTouchCancel         = 0x0200
};

typedef NS_OPTIONS(int32_t, PYResponderRestraint) {
    // Sub action default
    PYResponderRestraintDisable             = 0x00000000,
    // Sub action for tap
    PYResponderRestraintSingleTap           = 0x00000001,   // Default
    PYResponderRestraintDoubleTap           = 0x00000002,
    PYResponderRestraintTripleTap           = 0x00000004,
    // Sub action for press
    PYResponderRestraintOneFingerPress      = 0x00000010,   // Default
    PYResponderRestraintTwoFingersPress     = 0x00000020,
    PYResponderRestraintThreeFingersPress   = 0x00000040,
    // Sub action for pen
    PYResponderRestraintPanFreedom          = 0x00000F00,   // Default
    PYResponderRestraintPanHorizontal       = (0x00000100 | 0x00000200),
    PYResponderRestraintPanVerticalis       = (0x00000400 | 0x00000800),
    // Sub action for swipe
    PYResponderRestraintSwipeLeft           = 0x00001000,
    PYResponderRestraintSwipeRight          = 0x00002000,
    PYResponderRestraintSwipeTop            = 0x00004000,
    PYResponderRestraintSwipeBottom         = 0x00008000,
    PYResponderRestraintSwipeHorizontal     = (PYResponderRestraintSwipeLeft |
                                               PYResponderRestraintSwipeRight),
    PYResponderRestraintSwipeVerticalis     = (PYResponderRestraintSwipeTop |
                                               PYResponderRestraintSwipeBottom),
    // Sub action for Pinch
    PYResponderRestraintPinchDefault        = 0x00010000,   // Default
    PYResponderRestraintRotateDefault       = 0x00020000,   // Default
};

#ifdef __COPY_TOUCHES__
#define __GET_TOUCHES(touchSet)             [(touchSet) copy]
#else
#define __GET_TOUCHES(touchSet)             (touchSet)
#endif

// Event for the target.
@interface PYViewEvent : NSObject

@property (nonatomic, assign)   UIGestureRecognizerState    gestureState;
@property (nonatomic, assign)   PYResponderEvent            eventId;
@property (nonatomic, strong)   NSSet                       *touches;
@property (nonatomic, strong)   UIEvent                     *sysEvent;
@property (nonatomic, assign)   CGFloat                     pinchRate;
@property (nonatomic, assign)   CGFloat                     rotateDeltaArc;
@property (nonatomic, assign)   CGSize                      preciseDistance;
@property (nonatomic, assign)   CGSize                      movingDeltaDistance;
@property (nonatomic, assign)   CGPoint                     movingSpeed;
@property (nonatomic, assign)   PYResponderRestraint        swipeSide;
@property (nonatomic, assign)   BOOL                        hasMoved;

@end

@protocol PYResponderGestureRecognizerDelegate <UIGestureRecognizerDelegate>

@optional
- (void)invokeTargetForEvent:(PYResponderEvent)event info:(PYViewEvent *)info;

@end

@interface PYResponderGestureRecognizer : UIGestureRecognizer
{
    PYResponderEvent                    _possibleAction;

    CGPoint                             _firstTouchPoint;
    CGPoint                             _lastMovePoint;
    
    CGFloat                             _pinchDistance;
    CGFloat                             _rotateArc;

    unsigned int                        _tapCount;
    PYStopWatch                         *_tapTimestamp;
    NSTimer                             *_lagEventTimer;
    PYStopWatch                         *_speedTicker;
    CGPoint                             _movingSpeed;
    CGSize                              _lastMoveDistrance;
    int                                 _swipeSide;
    
    // Actions
    PYResponderEvent                    _responderAction;
    PYResponderRestraint                _responderRestraint;
    
    // Event
    PYViewEvent                         *_eventInfo;
}

// The delegate override the super defination.
@property (nonatomic, assign)   IBOutlet id<PYResponderGestureRecognizerDelegate>    delegate;

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

// Current Event Info
@property (nonatomic, readonly) PYViewEvent         *eventInfo;
@property (nonatomic, readonly) CGPoint             movingSpeed;

// Set the responder's supported event's restraint.
// the responder view will detect the event and try to find the target/action
// the event will occurred with the specified restraint.
- (void)setEvent:(PYResponderEvent)event withRestraint:(PYResponderRestraint)restraint;

@end

// @littlepush
// littlepush@gmail.com
// PYLab
