//
//  RNGSingleton.m
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 27/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNGSingleton.h"

@implementation RNGSingleton

+ (RNGSingleton *)sharedInstance
{
    static RNGSingleton *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RNGSingleton alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if(self = [super init]) {
        _gesturesIdsProvider = [[RNGGesturesIdsProvider alloc] init];
    }
    
    return self;
}

@end
