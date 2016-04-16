//
//  BigFrac.h
//  MathEagle
//
//  Created by Rugen Heidbuchel on 16/04/16.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gmp.h"
#import "BigInt.h"

@interface BigFrac_OBJC : NSObject {
    mpq_t mpqBigFrac;
}

#pragma mark - Initialisers
- (instancetype)initWithBigFracOBJC:(BigFrac_OBJC*)bigFracNumber;
- (instancetype)initWithBigIntOBJC:(BigInt_OBJC*)bigIntNumber;
- (instancetype)initWithLongNumerator:(long)longNumerator
                          denominator:(long)longDenominator;
- (instancetype)initWithUnsignedLongNumerator:(unsigned long)unsignedLongNumerator
                                  denominator:(unsigned long)unsignedLongDenominator;
- (instancetype)initWithString:(const char *)string inBase:(int)base;

#pragma mark - Deallocation
- (void)clear;

#pragma mark - Basic Methods
- (void)canonicalize;

#pragma mark - Conversions
- (double)getDoubleValue;
- (char*)getStringValueInBase:(int)base;

#pragma mark - Comparisons
- (int)compareWithBigFracOBJC:(BigFrac_OBJC*)bigFracNumber;

#pragma mark - Operations
+ (void)set:(BigFrac_OBJC*)result toSumOf:(BigFrac_OBJC*)left and:(BigFrac_OBJC*)right;
+ (void)set:(BigFrac_OBJC*)result toNegationOf:(BigFrac_OBJC*)bigFracNumber;
+ (void)set:(BigFrac_OBJC*)result toDifferenceOf:(BigFrac_OBJC*)left and:(BigFrac_OBJC*)right;
+ (void)set:(BigFrac_OBJC*)result toProductOf:(BigFrac_OBJC*)left and:(BigFrac_OBJC*)right;
+ (void)set:(BigFrac_OBJC*)result toQuotientOf:(BigFrac_OBJC*)left and:(BigFrac_OBJC*)right;
+ (void)set:(BigFrac_OBJC*)result toAbsoluteValueOf:(BigFrac_OBJC*)bigFracNumber;

@end
