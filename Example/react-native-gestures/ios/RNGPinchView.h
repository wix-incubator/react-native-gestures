//
//  RNGPinchView.h
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 23/02/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include("RCTBridgeModule.h")
#import "RCTComponent.h"
#else
#import <React/RCTComponent.h>
#endif

@interface RNGPinchView : UIView

@property (nonatomic, copy) RCTBubblingEventBlock onStart;
@property (nonatomic, copy) RCTBubblingEventBlock onChange;
@property (nonatomic, copy) RCTBubblingEventBlock onFinish;

@end
