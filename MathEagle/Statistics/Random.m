//
//  Random.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import "Random.h"

////////////////////////////////////////////////////////////////
//
//    Swift and Objective-C numeric types
//
// Swift     Objective-C
// -------------------------------------------------------------
// UInt      unsigned long
//     On 32-bit platforms, UInt is the same size as UInt32, and on
//     64-bit platforms, UInt is the same size as UInt64. (4/8 bytes)
// UInt8     unsigned char
// UInt16    unsigned short
// UInt32    unsigned int
// UInt64    unsigned long long
// Int       long
//     On 32-bit platforms, Int is the same size as Int32, and on
//     64-bit platforms, Int is the same size as Int64. (4/8 bytes)
// Int8      char
// Int16     short
// Int32     int
// Int64     long long
// Float     float
// Double    double
////////////////////////////////////////////////////////////////

@implementation Random_OBJC

#pragma C Functions

static double randomNext(void) {
    // Return random double in [0,1] .
    return ((double)arc4random())/((double)UINT32_MAX);
}

// arc4random_uniform is limited to unsigned 32 bit integers.
// We define our own unsigned 64 bit integer randomUInt64 here.
// Unlike arc4random_uniform , our randomUInt64 can return its input.
static unsigned long long randomUInt64(unsigned long long upperBound) {
    // Return random integer in [0,upperBound] .
    if (upperBound<UINT32_MAX) {
        return arc4random_uniform((uint32_t)(upperBound+1));
    } else {
        // limit divisble by upperBound to avoid modulo bias
        unsigned long long limit = UINT64_MAX-UINT64_MAX%upperBound;
        // Discover n<limit
        unsigned long long n = 0;
        while (YES) {
            arc4random_buf(&n,sizeof(n));
            if (n>=limit) break;
        };
        // Return answer < upperBound
        return n % upperBound;
    }
}

#pragma mark - Array Functions

+ (void)randomUIntArray:(long)length
             lowerBound:(unsigned long)lowerBound
             upperBound:(unsigned long)upperBound
                 closed:(bool)closed
                inArray:(unsigned long*)array {
    unsigned long delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned long offset = (unsigned long)randomUInt64(delta-1);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomUInt8Array:(long)length
              lowerBound:(unsigned char)lowerBound
              upperBound:(unsigned char)upperBound
                  closed:(bool)closed
                 inArray:(unsigned char*)array {
    unsigned char delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned char offset = arc4random_uniform(delta);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomUInt16Array:(long)length
               lowerBound:(unsigned short)lowerBound
               upperBound:(unsigned short)upperBound
                   closed:(bool)closed
                  inArray:(unsigned short*)array {
    unsigned short delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned short offset = arc4random_uniform(delta);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomUInt32Array:(long)length
               lowerBound:(unsigned int)lowerBound
               upperBound:(unsigned int)upperBound
                   closed:(bool)closed
                  inArray:(unsigned int*)array {
    unsigned int delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned int offset = arc4random_uniform(delta);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomUInt64Array:(long)length
               lowerBound:(unsigned long long)lowerBound
               upperBound:(unsigned long long)upperBound
                   closed:(bool)closed
                  inArray:(unsigned long long*)array {
    unsigned long long delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned long long offset = randomUInt64(delta-1);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomIntArray:(long)length
            lowerBound:(long)lowerBound
            upperBound:(long)upperBound
                closed:(bool)closed
               inArray:(long*)array {
    unsigned long delta = (unsigned long)(upperBound-lowerBound);
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned long offset = (unsigned long)randomUInt64(delta-1);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomInt8Array:(long)length
             lowerBound:(char)lowerBound
             upperBound:(char)upperBound
                 closed:(bool)closed
                inArray:(char*)array {
    unsigned char delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned char offset = arc4random_uniform(delta);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomInt16Array:(long)length
              lowerBound:(short)lowerBound
              upperBound:(short)upperBound
                  closed:(bool)closed
                 inArray:(short*)array {
    unsigned short delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned short offset = arc4random_uniform(delta);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomInt32Array:(long)length
              lowerBound:(int)lowerBound
              upperBound:(int)upperBound
                  closed:(bool)closed
                 inArray:(int*)array {
    unsigned int delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned int offset = arc4random_uniform(delta);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomInt64Array:(long)length
              lowerBound:(long long)lowerBound
              upperBound:(long long)upperBound
                  closed:(bool)closed
                 inArray:(long long*)array {
    unsigned long long delta = upperBound-lowerBound;
    if (closed) delta++;
    if (delta==0) {
        // The half-open range is empty.  Error or return best answer.
        delta=1;
    }
    for (long k = 0; k < length; k++) {
        unsigned long long offset = randomUInt64(delta-1);
        array[k] = lowerBound+offset;
    }
}

+ (void)randomFloatArray:(long)length
              lowerBound:(float)lowerBound
              upperBound:(float)upperBound
                  closed:(bool)closed
                 inArray:(float*)array {
    float delta = upperBound-lowerBound;
    for (long k = 0; k < length; k++) {
        float a = lowerBound;
        // This loop should iterate once in most cases.
        for (int i=1;i<10;i++) {
            float offset = ((float)randomNext())*delta;
            a = lowerBound+offset;
            if ((lowerBound<=a)
                &&((a<upperBound)
                   ||(closed&&(a==upperBound)))) {
                    break;
                }
        }
        array[k] = a;
    }
}

+ (void)randomDoubleArray:(long)length
               lowerBound:(double)lowerBound
               upperBound:(double)upperBound
                   closed:(bool)closed
                  inArray:(double*)array {
    double delta = upperBound-lowerBound;
    for (long k = 0; k < length; k++) {
        double a = lowerBound;
        // This loop should iterate once in most cases.
        for (int i=1;i<10;i++) {
            double offset = randomNext()*delta;
            a = lowerBound+offset;
            if ((lowerBound<=a)
                &&((a<upperBound)
                   ||(closed&&(a==upperBound)))) {
                break;
            }
        }
        array[k] = a;
    }
}

+ (void)randomCGFloatArray:(long)length
              lowerBound:(CGFloat)lowerBound
              upperBound:(CGFloat)upperBound
                  closed:(bool)closed
                 inArray:(CGFloat*)array {
    CGFloat delta = upperBound-lowerBound;
    for (long k = 0; k < length; k++) {
        CGFloat a = lowerBound;
        // This loop should iterate once in most cases.
        for (int i=1;i<10;i++) {
            CGFloat offset = ((CGFloat)randomNext())*delta;
            a = lowerBound+offset;
            if ((lowerBound<=a)
                &&((a<upperBound)
                   ||(closed&&(a==upperBound)))) {
                    break;
                }
        }
        array[k] = a;
    }
}

@end
