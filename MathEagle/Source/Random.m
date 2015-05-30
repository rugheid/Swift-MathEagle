//
//  Random.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import "Random.h"

@implementation Random_OBJC

+ (void)randomFloatArrayOfLength:(long)length inArray:(float*)array {
    
    for (long k = 0; k < length; k++) {
        
        int i = arc4random();
        array[k] = *(float*)&i;
    }
}

@end
