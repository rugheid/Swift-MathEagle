//
//  BigFloat.h
//  MathEagle
//
//  Created by Rugen Heidbuchel on 22/04/16.
//  Copyright © 2016 Rugen Heidbuchel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gmp.h"
#import "BigInt.h"
#import "BigFrac.h"

@interface BigFloat_OBJC : NSObject {
    @public
    mpf_t mpfBigFloat;
}

#pragma mark - Initialisers
- (instancetype)initWithPrecision:(unsigned long int)precision;
- (instancetype)initWithBigFloatOBJC:(BigFloat_OBJC*)bigFloatNumber;
- (instancetype)initWithBigIntOBJC:(BigInt_OBJC*)bigIntNumber;
- (instancetype)initWithBigFracOBJC:(BigFrac_OBJC*)bigFracNumber;
- (instancetype)initWithLong:(long)longNumber;
- (instancetype)initWithUnsignedLong:(unsigned long)unsignedLongNumber;
- (instancetype)initWithDouble:(double)doubleNumber;
- (instancetype)initWithString:(const char *)string inBase:(int)base;

#pragma mark - Settings
- (void)setDefaultPrecision:(unsigned long)precision;
- (unsigned long int)getDefaultPrecision;

#pragma mark - Properties
- (void)setPrecision:(unsigned long)precision;
- (unsigned long)getPrecision;

#pragma mark - Conversions
- (long)getLongValue;
- (unsigned long)getUnsignedLongValue;
- (double)getDoubleValue;
- (char*)getStringValueInBase:(int)base
            exponentReference:(long int *)exponent
            maxNumberOfDigits:(size_t)nDigits;

#pragma mark - Comparisons
- (int)compareWithBigFloatOBJC:(BigFloat_OBJC*)bigFloatNumber;
- (int)compareWithDouble:(double)doubleNumber;
- (int)compareWithUnsignedLong:(unsigned long)unsignedLongNumber;
- (int)compareWithLong:(long)longNumber;

#pragma mark - Operations
+ (void)set:(BigFloat_OBJC*)result toSumOf:(BigFloat_OBJC*)left and:(BigFloat_OBJC*)right;
+ (void)set:(BigFloat_OBJC*)result toSumOf:(BigFloat_OBJC*)left andUnsignedLong:(unsigned long)right;
+ (void)set:(BigFloat_OBJC*)result toNegationOf:(BigFloat_OBJC*)bigFloatNumber;
+ (void)set:(BigFloat_OBJC*)result toDifferenceOf:(BigFloat_OBJC*)left and:(BigFloat_OBJC*)right;
+ (void)set:(BigFloat_OBJC*)result toDifferenceOfUnsignedLong:(unsigned long)left and:(BigFloat_OBJC*)right;
+ (void)set:(BigFloat_OBJC*)result toDifferenceOf:(BigFloat_OBJC*)left andUnsignedLong:(unsigned long)right;
+ (void)set:(BigFloat_OBJC*)result toProductOf:(BigFloat_OBJC*)left and:(BigFloat_OBJC*)right;
+ (void)set:(BigFloat_OBJC*)result toProductOf:(BigFloat_OBJC*)left andUnsignedLong:(unsigned long)right;
+ (void)set:(BigFloat_OBJC*)result toQuotientOf:(BigFloat_OBJC*)left and:(BigFloat_OBJC*)right;
+ (void)set:(BigFloat_OBJC*)result toQuotientOfUnsignedLong:(unsigned long)left and:(BigFloat_OBJC*)right;
+ (void)set:(BigFloat_OBJC*)result toQuotientOf:(BigFloat_OBJC*)left andUnsignedLong:(unsigned long)right;
+ (void)set:(BigFloat_OBJC*)result toAbsoluteValueOf:(BigFloat_OBJC*)bigFloatNumber;
+ (void)set:(BigFloat_OBJC*)result toSquareRootOf:(BigFloat_OBJC*)bigFloatNumber;
+ (void)set:(BigFloat_OBJC*)result toSquareRootOfUnsignedLong:(unsigned long)unsignedLong;
+ (void)set:(BigFloat_OBJC*)result to:(BigFloat_OBJC*)base toThePower:(unsigned long)exponent;

@end
