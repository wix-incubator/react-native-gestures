//
//  RNGPinchView.m
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 23/02/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "RNGPinchView.h"

@implementation RNGPinchView {
    int _currentId;
}

- (instancetype)init
{
    if(self = [super init]) {        
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizerAction:)];
        [self addGestureRecognizer:pinchRecognizer];
    }
    
    return self;
}

- (void)handleGestureRecognizerAction:(UIPinchGestureRecognizer *)pinchRecognizer
{
    RCTBubblingEventBlock callback;
    NSString *action;
    
    switch(pinchRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _currentId++;
            callback = self.onStart;
            action = @"start";
            break;
        case UIGestureRecognizerStateChanged:
            callback = self.onChange;
            action = @"change";
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            callback = self.onFinish;
            action = @"finish";
            break;

        case UIGestureRecognizerStatePossible:
            break;
    }
    
    if(!callback) {
        return;
    }
    
    callback(@{
               @"gestureId": @(_currentId),
               @"action": action,
               @"scale": @(pinchRecognizer.scale)
               });
}

@end
