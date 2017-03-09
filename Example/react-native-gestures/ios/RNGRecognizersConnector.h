//
// Created by Sergey Ilyevsky on 09/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@class RNGGesturesIdsProvider;

typedef enum {
    RNGRecognizersConnector_gestureId_pinch,
    RNGRecognizersConnector_gestureId_tap,
    RNGRecognizersConnector_gestureId_pan
} RNGRecognizersConnector_gestureId;

@interface RNGRecognizersConnector : NSObject

-(instancetype) __unavailable init;
- (instancetype)initWithGesturesIdsProvider:(RNGGesturesIdsProvider *)gesturesIdsProvider view:(UIView *)view;

- (void)setEventBlock:(RCTBubblingEventBlock)block forGestureId:(RNGRecognizersConnector_gestureId)gestureId;
- (RCTBubblingEventBlock)eventBlockForGestureId:(RNGRecognizersConnector_gestureId)gestureId;

@end