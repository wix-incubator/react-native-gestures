//
// Created by Sergey Ilyevsky on 09/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import "RNGPinchRecognizerHandler.h"


@implementation RNGPinchRecognizerHandler {

}

- (Class)gestureRecognizerClass {
    return [UIPinchGestureRecognizer class];
}

- (void)handleRecognizerAction:(UIGestureRecognizer *)recognizer {
    UIPinchGestureRecognizer *pinchRecognizer = (UIPinchGestureRecognizer *)recognizer;
    NSString *action;

    switch(pinchRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self _incrementCurrentGestureId];
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

    self.actionBlock(@{
            @"gestureId": @(self.currentGestureId),
            @"action": action,
            @"scale": @(pinchRecognizer.scale)
    });

}

@end