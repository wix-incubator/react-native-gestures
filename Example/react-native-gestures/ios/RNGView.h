//
//  RNGView.h
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 28/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include(<React/RCTComponent.h>)
#import <React/RCTComponent.h>
#else
#import "RCTComponent.h"
#endif
#import "RNGGesturesIdsProvider.h"

@interface RNGView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, copy) RCTDirectEventBlock onPinch;
@property (nonatomic, copy) RCTDirectEventBlock onTap;
@property (nonatomic, copy) RCTDirectEventBlock onPan;
@property (nonatomic, copy) RCTDirectEventBlock onRotation;

- (instancetype)__unavailable init;
- (instancetype)initWithGesturesIdsProvider:(RNGGesturesIdsProvider *)gesturesIdsProvider;

@end
