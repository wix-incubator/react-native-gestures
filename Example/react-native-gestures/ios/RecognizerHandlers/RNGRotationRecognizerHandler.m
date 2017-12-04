//
//  RNGRotationRecognizerHandler.m
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 04/12/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNGRotationRecognizerHandler.h"

@implementation RNGRotationRecognizerHandler

- (Class)gestureRecognizerClass {
    return [UIRotationGestureRecognizer class];
}

- (void)handleRecognizerAction:(UIGestureRecognizer *)recognizer {
    UIRotationGestureRecognizer *rotationRecognizer = (UIRotationGestureRecognizer *)recognizer;
    NSString *action;
    
    switch(rotationRecognizer.state) {
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
                       @"rotation": @(rotationRecognizer.rotation)
                       });
    
}

@end
