//
//  RNGView.m
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 28/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNGView.h"

@implementation RNGView {
    RNGGesturesIdsProvider *_gesturesIdsProvider;
    UIPinchGestureRecognizer *_pinchRecognizer;
    NSUInteger _currentPinchGestureId;
    UITapGestureRecognizer *_tapRecognizer;
    UIPanGestureRecognizer *_panRecognizer;
    NSUInteger _currentPanGestureId;
}

- (instancetype)initWithGesturesIdsProvider:(RNGGesturesIdsProvider *)gesturesIdsProvider {
    self = [super init];
    if (self) {
        _gesturesIdsProvider = gesturesIdsProvider;
    }

    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)setOnPinch:(RCTBubblingEventBlock)onPinchAction {
    _onPinch = [onPinchAction copy];

    if(_pinchRecognizer) {
        [self removeGestureRecognizer:_pinchRecognizer];
    }

    _pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePinchGestureRecognizerAction:)];
    _pinchRecognizer.delegate = self;
    [self addGestureRecognizer:_pinchRecognizer];
}

- (void)setOnTap:(RCTBubblingEventBlock)onTapAction {
    _onTap = [onTapAction copy];

    if(_tapRecognizer) {
        [self removeGestureRecognizer:_tapRecognizer];
    }

    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGestureRecognizerAction:)];
    _tapRecognizer.delegate = self;
    [self addGestureRecognizer:_tapRecognizer];
}

- (void)setOnPan:(RCTBubblingEventBlock)onPanAction {
    _onPan = [onPanAction copy];

    if(_panRecognizer) {
        [self removeGestureRecognizer:_panRecognizer];;
    }

    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePanGestureRecognizerAction:)];
    _panRecognizer.delegate = self;
    [self addGestureRecognizer:_panRecognizer];
}

- (void)_handlePinchGestureRecognizerAction:(UIPinchGestureRecognizer *)pinchRecognizer
{
    NSString *action;

    switch(pinchRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _currentPinchGestureId = [_gesturesIdsProvider next];
            action = @"start";
            break;
        case UIGestureRecognizerStateChanged:
            action = @"change";
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            action = @"finish";
            break;

        case UIGestureRecognizerStatePossible:
            return;
    }

    _onPinch(@{
            @"gestureId": @(_currentPinchGestureId),
            @"action": action,
            @"scale": @(pinchRecognizer.scale)
    });
}

- (void)_handleTapGestureRecognizerAction:(UITapGestureRecognizer *)tapRecognizer
{
    if(tapRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }

    _onTap(@{});
}

- (void)_handlePanGestureRecognizerAction:(UIPanGestureRecognizer *)panRecognizer
{
    NSString *action;

    switch(panRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _currentPanGestureId = [_gesturesIdsProvider next];
            action = @"start";
            break;
        case UIGestureRecognizerStateChanged:
            action = @"change";
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            action = @"finish";
            break;

        case UIGestureRecognizerStatePossible:
            return;
    }

    CGPoint point = [panRecognizer translationInView:self];
    _onPan(@{
            @"gestureId": @(_currentPanGestureId),
            @"action": action,
            @"x": @(point.x),
            @"y": @(point.y),
    });
}

@end
