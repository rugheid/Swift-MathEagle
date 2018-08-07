//
//  Random.h
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Random_OBJC : NSObject

+ (void)randomUIntArray:(long)length
             lowerBound:(unsigned long)lowerBound
             upperBound:(unsigned long)upperBound
                 closed:(bool)closed
                inArray:(unsigned long*)array;
+ (void)randomUInt8Array:(long)length
              lowerBound:(unsigned char)lowerBound
              upperBound:(unsigned char)upperBound
                  closed:(bool)closed
                 inArray:(unsigned char*)array;
+ (void)randomUInt16Array:(long)length
               lowerBound:(unsigned short)lowerBound
               upperBound:(unsigned short)upperBound
                   closed:(bool)closed
                  inArray:(unsigned short*)array;
+ (void)randomUInt32Array:(long)length
               lowerBound:(unsigned int)lowerBound
               upperBound:(unsigned int)upperBound
                   closed:(bool)closed
                  inArray:(unsigned int*)array;
+ (void)randomUInt64Array:(long)length
               lowerBound:(unsigned long long)lowerBound
               upperBound:(unsigned long long)upperBound
                   closed:(bool)closed
                  inArray:(unsigned long long*)array;
+ (void)randomIntArray:(long)length
            lowerBound:(long)lowerBound
            upperBound:(long)upperBound
                closed:(bool)closed
               inArray:(long*)array;
+ (void)randomInt8Array:(long)length
             lowerBound:(char)lowerBound
             upperBound:(char)upperBound
                 closed:(bool)closed
                inArray:(char*)array;
+ (void)randomInt16Array:(long)length
              lowerBound:(short)lowerBound
              upperBound:(short)upperBound
                  closed:(bool)closed
                 inArray:(short*)array;
+ (void)randomInt32Array:(long)length
              lowerBound:(int)lowerBound
              upperBound:(int)upperBound
                  closed:(bool)closed
                 inArray:(int*)array;
+ (void)randomInt64Array:(long)length
              lowerBound:(long long)lowerBound
              upperBound:(long long)upperBound
                  closed:(bool)closed
                 inArray:(long long*)array;
+ (void)randomFloatArray:(long)length
              lowerBound:(float)lowerBound
              upperBound:(float)upperBound
                  closed:(bool)closed
                 inArray:(float*)array;
+ (void)randomDoubleArray:(long)length
               lowerBound:(double)lowerBound
               upperBound:(double)upperBound
                   closed:(bool)closed
                  inArray:(double*)array;
+ (void)randomCGFloatArray:(long)length
              lowerBound:(CGFloat)lowerBound
              upperBound:(CGFloat)upperBound
                  closed:(bool)closed
                 inArray:(CGFloat*)array;

@end
