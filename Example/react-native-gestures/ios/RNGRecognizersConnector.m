//
// Created by Sergey Ilyevsky on 09/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import "RNGRecognizersConnector.h"
#import "RNGRecognizerHandler.h"
#import "RNGGesturesIdsProvider.h"
#import "RNGPinchRecognizerHandler.h"
#import "RNGTapRecognizerHandler.h"
#import "RNGPanRecognizerHandler.h"


@implementation RNGRecognizersConnector {
    NSMutableDictionary<NSNumber *, RNGRecognizerHandler *> *_handlers;
    RNGGesturesIdsProvider *_gesturesIdsProvider;
    __weak UIView<UIGestureRecognizerDelegate> *_view;
}

- (instancetype)initWithGesturesIdsProvider:(RNGGesturesIdsProvider *)gesturesIdsProvider view:(UIView<UIGestureRecognizerDelegate> *)view {
    self = [super init];
    if (self) {
        _gesturesIdsProvider = gesturesIdsProvider;
        _handlers = @{}.mutableCopy;
        _view = view;
    }

    return self;
}

- (Class)_classForGestureId:(RNGRecognizersConnector_gestureId)gestureId
{
    switch(gestureId) {
        case RNGRecognizersConnector_gestureId_pinch:
            return [RNGPinchRecognizerHandler class];
        case RNGRecognizersConnector_gestureId_tap:
            return [RNGTapRecognizerHandler class];
        case RNGRecognizersConnector_gestureId_pan:
            return [RNGPanRecognizerHandler class];
    }

    return nil;
}

- (void)setEventBlock:(RCTBubblingEventBlock)block forGestureId:(RNGRecognizersConnector_gestureId)gestureId {
    RNGRecognizerHandler *oldHandler = _handlers[@(gestureId)];
    if(oldHandler) {
        [_handlers removeObjectForKey:@(gestureId)];
        [_view removeGestureRecognizer:oldHandler.gestureRecognizer];
    }

    RNGRecognizerHandler *handler = [(RNGRecognizerHandler *) [[self _classForGestureId:gestureId] alloc] initWithActionBlock:block];
    _handlers[@(gestureId)] = handler;
    handler.gestureRecognizer.delegate = _view;
    [_view addGestureRecognizer:handler.gestureRecognizer];

}

- (RCTBubblingEventBlock)eventBlockForGestureId:(RNGRecognizersConnector_gestureId)gestureId {
    return _handlers[@(gestureId)].actionBlock;
}


@end
