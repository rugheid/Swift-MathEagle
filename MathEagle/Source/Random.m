//
//  Random.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Rugen Heidbuchel. All rights reserved.
//

#import "Random.h"

@implementation Random_OBJC


#pragma mark Unions

typedef union {
    float f;            // Float
    int i;              // Int32
    unsigned int ui;    // UInt32
} single_precision_generator;

typedef union {
    double d;               // Double
    long l;                 // Int
    long long ll;           // Int64
    unsigned long ul;       // UInt
    unsigned long long ull; // UInt64
    struct {
        unsigned int a;
        unsigned int b;
    } integers;             // UInt32
} double_precision_generator;

typedef union {
    char c;             // Int8
    unsigned char uc;   // UInt8
} char_generator;

typedef union {
    short s;             // Int16
    unsigned short us;   // UInt16
} short_generator;



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
        
        array[k] = (unsigned char) arc4random_uniform(UCHAR_MAX);
    }
}


+ (void)randomUInt16ArrayOfLength:(long)length inArray:(unsigned short *)array {
    
    for (long k = 0; k < length; k++) {
        
        array[k] = (unsigned short) arc4random_uniform(USHRT_MAX);
    }
}


+ (void)randomUInt32ArrayOfLength:(long)length inArray:(unsigned int *)array {
    
    for (long k = 0; k < length; k++) {
        
        array[k] = arc4random();
    }
}


+ (void)randomUInt64ArrayOfLength:(long)length inArray:(unsigned long long *)array {
    
    double_precision_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.integers.a = arc4random();
        g.integers.b = arc4random();
        
        array[k] = g.ull;
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


+ (void)randomInt8ArrayOfLength:(long)length inArray:(char *)array {
    
    char_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.uc = arc4random_uniform(UCHAR_MAX);
        
        array[k] = g.c;
    }
}


+ (void)randomInt16ArrayOfLength:(long)length inArray:(short *)array {
    
    short_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.us = arc4random_uniform(USHRT_MAX);
        
        array[k] = g.s;
    }
}


+ (void)randomInt32ArrayOfLength:(long)length inArray:(int *)array {
    
    single_precision_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.ui = arc4random();
        
        array[k] = g.i;
    }
}


+ (void)randomInt64ArrayOfLength:(long)length inArray:(long long *)array {
    
    double_precision_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.integers.a = arc4random();
        g.integers.b = arc4random();
        
        array[k] = g.ll;
    }
}


+ (void)randomFloatArrayOfLength:(long)length inArray:(float*)array {
    
    single_precision_generator g;
    
    for (long k = 0; k < length; k++) {
        
        g.ui = arc4random();
        
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
