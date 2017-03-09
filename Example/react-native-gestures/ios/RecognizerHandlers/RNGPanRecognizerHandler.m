//
// Created by Sergey Ilyevsky on 09/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import "RNGPanRecognizerHandler.h"


@implementation RNGPanRecognizerHandler {

}

- (Class)gestureRecognizerClass
{
    return [UIPanGestureRecognizer class];
}

- (void)handleRecognizerAction:(UIGestureRecognizer *)recognizer
{
    UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)recognizer;

    NSString *action;
    switch(panRecognizer.state) {
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

    CGPoint point = [panRecognizer translationInView:self.view];
    self.actionBlock(@{
            @"gestureId": @(self.currentGestureId),
            @"action": action,
            @"x": @(point.x),
            @"y": @(point.y),
    });
}


@end
