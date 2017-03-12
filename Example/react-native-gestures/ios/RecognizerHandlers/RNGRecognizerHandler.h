//
// Created by Sergey Ilyevsky on 09/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include(<React/RCTComponent.h>)
#import <React/RCTComponent.h>
#else
#import "RCTComponent.h"
#endif

@class RNGGesturesIdsProvider;


@interface RNGRecognizerHandler : NSObject
- (instancetype)initWithActionBlock:(RCTBubblingEventBlock)actionBlock view:(UIView *)view;
- (Class)gestureRecognizerClass;
- (void)handleRecognizerAction:(UIGestureRecognizer *)recognizer;
- (void)_incrementCurrentGestureId;

@property (nonatomic, readonly) RCTBubblingEventBlock actionBlock;
@property (nonatomic, readonly) RNGGesturesIdsProvider *gesturesIdsProvider;
@property (nonatomic, readonly) NSUInteger currentGestureId;
@property (nonatomic, readonly, weak) UIView *view;
@property (nonatomic, readonly) UIGestureRecognizer *gestureRecognizer;

@end
