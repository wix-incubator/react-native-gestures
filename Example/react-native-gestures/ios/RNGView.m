//
//  RNGView.m
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 28/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNGView.h"
#import "RNGRecognizersConnector.h"

@implementation RNGView {
    RNGRecognizersConnector *_recognizersConnector;
}

- (instancetype)initWithGesturesIdsProvider:(RNGGesturesIdsProvider *)gesturesIdsProvider {
    self = [super init];
    if (self) {
        _recognizersConnector = [[RNGRecognizersConnector alloc] initWithGesturesIdsProvider:gesturesIdsProvider view:self];
    }

    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if([otherGestureRecognizer.view isKindOfClass:[RNGView class]] &&
       otherGestureRecognizer.view != gestureRecognizer.view &&
       [gestureRecognizer.view isDescendantOfView:otherGestureRecognizer.view]) {
        return YES;
    }
    
    return NO;
    
}

- (RCTDirectEventBlock)onTap {
    return [_recognizersConnector eventBlockForGestureId:RNGRecognizersConnector_gestureId_tap];
}
- (void)setOnTap:(RCTDirectEventBlock)onTapAction {
    [_recognizersConnector setEventBlock:onTapAction forGestureId:RNGRecognizersConnector_gestureId_tap];
}

- (RCTDirectEventBlock)onPan {
    return [_recognizersConnector eventBlockForGestureId:RNGRecognizersConnector_gestureId_pan];
}
- (void)setOnPan:(RCTDirectEventBlock)onPanAction {
    [_recognizersConnector setEventBlock:onPanAction forGestureId:RNGRecognizersConnector_gestureId_pan];
}

- (RCTDirectEventBlock)onPinch {
    return [_recognizersConnector eventBlockForGestureId:RNGRecognizersConnector_gestureId_pinch];
}
- (void)setOnPinch:(RCTDirectEventBlock)onPinchAction {
    [_recognizersConnector setEventBlock:onPinchAction forGestureId:RNGRecognizersConnector_gestureId_pinch];
}

- (RCTDirectEventBlock)onRotation {
    return [_recognizersConnector eventBlockForGestureId:RNGRecognizersConnector_gestureId_rotation];
}
- (void)setOnRotation:(RCTDirectEventBlock)onRotationAction {
    return [_recognizersConnector setEventBlock:onRotationAction forGestureId:RNGRecognizersConnector_gestureId_rotation];
}

@end
