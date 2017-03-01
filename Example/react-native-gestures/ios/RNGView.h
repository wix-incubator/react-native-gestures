//
//  RNGView.h
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 28/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include("RCTBridgeModule.h")
#import "RCTComponent.h"
#else
#import <React/RCTComponent.h>
#endif
#import "Gestures/RNGGesture.h"

@interface RNGView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onPinchAction;
@property (nonatomic, copy) RCTBubblingEventBlock onTapAction;
@property (nonatomic, copy) RCTBubblingEventBlock onPanAction;

- (instancetype)__unavailable init;
- (instancetype)initWithGesturesIdsProvider:(RNGGesturesIdsProvider *)gesturesIdsProvider;

@end
