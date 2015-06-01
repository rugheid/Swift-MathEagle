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
    unsigned long ul;
    struct {
        int a;
        int b;
    } integers;
} unsigned_long_generator;

+ (void)randomUIntArrayOfLength:(long)length inArray:(unsigned long *)array {
    
    unsigned_long_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.integers.a = arc4random();
        g.integers.b = arc4random();
        
        array[k] = g.ul;
    }
}



typedef union {
    long l;
    struct {
        int a;
        int b;
    } integers;
} long_generator;

+ (void)randomIntArrayOfLength:(long)length inArray:(long *)array {
    
    long_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.integers.a = arc4random();
        g.integers.b = arc4random();
        
        array[k] = g.l;
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
