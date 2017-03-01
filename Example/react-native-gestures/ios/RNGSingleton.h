//
//  RNGSingleton.h
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 27/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNGGesturesIdsProvider.h"

@interface RNGSingleton : NSObject

+ (RNGSingleton *)sharedInstance;

@property (nonatomic, readonly) RNGGesturesIdsProvider *gesturesIdsProvider;

@end
