//
//  Random.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import "Random.h"

@implementation Random_OBJC


#pragma mark Unions

typedef union {
    float f;
    int i;
    unsigned int ui;
} single_precision_generator;

typedef union {
    double d;
    long l;
    unsigned long ul;
    struct {
        unsigned int a;
        unsigned int b;
    } integers;
} double_precision_generator;



#pragma mark - Array Functions

+ (void)randomUIntArrayOfLength:(long)length inArray:(unsigned long *)array {
    
    double_precision_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.integers.a = arc4random();
        g.integers.b = arc4random();
        
        array[k] = g.ul;
    }
}


+ (void)randomUInt8ArrayOfLength:(long)length inArray:(unsigned char *)array {
    
    for (long k = 0; k < length; k++) {
        
        array[k] = arc4random_uniform(UCHAR_MAX);
    }
}


+ (void)randomUInt16ArrayOfLength:(long)length inArray:(unsigned short *)array {
    
    for (long k = 0; k < length; k++) {
        
        array[k] = arc4random_uniform(USHRT_MAX);
    }
}


+ (void)randomIntArrayOfLength:(long)length inArray:(long *)array {
    
    double_precision_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.integers.a = arc4random();
        g.integers.b = arc4random();
        
        array[k] = g.l;
    }
}


+ (void)randomFloatArrayOfLength:(long)length inArray:(float*)array {
    
    single_precision_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.i = arc4random();
        
        while (!isnormal(g.f)) {
            g.ui = arc4random();
        }
        
        array[k] = g.f;
    }
}


+ (void)randomDoubleArrayOfLength:(long)length inArray:(double*)array {
    
    double_precision_generator g;
    
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
