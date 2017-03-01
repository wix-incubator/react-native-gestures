//
//  RNGGesturesIdsProvider.m
//  RNGGestures
//
//  Created by Sergey Ilyevsky on 27/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNGGesturesIdsProvider.h"

@implementation RNGGesturesIdsProvider {
    NSUInteger _last;
}

- (NSUInteger)next
{
    return ++_last;
}

@end
