//
//  Random.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import "Random.h"

@implementation Random_OBJC


+ (void)randomIntArrayOfLength:(long)length inArray:(long *)array {
    
    for (long k = 0; k < length; k++) {
        
        array[k] = arc4random();
    }
}



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



typedef union {
    double d;
    struct {
        int a;
        int b;
    } integers;
} double_generator;

+ (void)randomDoubleArrayOfLength:(long)length inArray:(double*)array {
    
    double_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.integers.a = arc4random();
        g.integers.b = arc4random();
        
        while (!isnormal(g.d)) {
            g.integers.b = arc4random();
        }
        
        array[k] = g.d;
    }
}

@end
