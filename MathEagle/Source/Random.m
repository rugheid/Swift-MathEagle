//
//  Random.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import "Random.h"

@implementation Random_OBJC


typedef union {
    float f;
    int i;
} float_generator;

+ (void)randomFloatArrayOfLength:(long)length inArray:(float*)array {
    
    float_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.i = arc4random();
        
        while (!isnormal(g.f)) {
            g.i = arc4random();
        }
        
        array[k] = g.f;
    }
}

@end
