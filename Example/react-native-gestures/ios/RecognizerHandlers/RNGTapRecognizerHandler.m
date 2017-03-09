//
// Created by Sergey Ilyevsky on 09/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import "RNGTapRecognizerHandler.h"


@implementation RNGTapRecognizerHandler {

}

- (void)handleRecognizerAction:(UIGestureRecognizer *)recognizer {
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)recognizer;

    if(tapRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }

    [self _incrementCurrentGestureId];
    self.actionBlock(@{
        @"gestureId": @(self.currentGestureId),
    });
}

- (Class)gestureRecognizerClass
{
    return [UITapGestureRecognizer class];
}

@end
