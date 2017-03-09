//
// Created by Sergey Ilyevsky on 09/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import "RNGRecognizerHandler.h"
#import "RNGGesturesIdsProvider.h"


@implementation RNGRecognizerHandler {

}

- (instancetype)initWithActionBlock:(RCTBubblingEventBlock)actionBlock view:(UIView *)view {
    self = [super init];
    if (self) {
        _actionBlock = [actionBlock copy];
        _view = view;
        _gestureRecognizer = [(UIGestureRecognizer *)[[self gestureRecognizerClass] alloc] initWithTarget:self action:@selector(handleRecognizerAction: )];
    }

    return self;
}

- (void)_incrementCurrentGestureId {
    _currentGestureId++;
}

- (Class)gestureRecognizerClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)handleRecognizerAction:(UIGestureRecognizer *)recognizer
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
