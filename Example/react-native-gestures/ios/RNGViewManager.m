//
// Created by Sergey Ilyevsky on 28/02/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import "RNGView.h"
#import "RNGSingleton.h"

#if __has_include(<React/RCTViewManager.h>)
#import <React/RCTViewManager.h>
#else
#import "RCTViewManager.h"
#endif

@interface RNGViewManager : RCTViewManager
@end

@implementation RNGViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[RNGView alloc] initWithGesturesIdsProvider:[RNGSingleton sharedInstance].gesturesIdsProvider];
}

RCT_EXPORT_VIEW_PROPERTY(onPinch, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onTap, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPan, RCTBubblingEventBlock)

@end
