//
//  RNGPinchManager.m
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 23/02/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "RNGPinchView.h"
#import <React/RCTViewManager.h>

@interface RNGPinchManager : RCTViewManager
@end

@implementation RNGPinchManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[RNGPinchView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(onStart, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFinish, RCTBubblingEventBlock)

@end
