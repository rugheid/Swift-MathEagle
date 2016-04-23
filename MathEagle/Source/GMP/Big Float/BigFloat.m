//
//  BigFloat.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 22/04/16.
//  Copyright © 2016 Jorestha Solutions. All rights reserved.
//

#import "BigFloat.h"

@implementation BigFloat_OBJC


#pragma mark - Initialisers

- (instancetype)init{
    if (self = [super init]) {
        mpf_init(mpfBigFloat);
        return self;
    }
    return nil;
}

- (instancetype)initWithPrecision:(unsigned long)precision {
    if (self = [super init]) {
        mpf_init2(mpfBigFloat, precision);
        return self;
    }
    return nil;
}

- (instancetype)initWithBigFloatOBJC:(BigFloat_OBJC *)bigFloatNumber {
    if (self = [super init]) {
        mpf_init_set(mpfBigFloat, bigFloatNumber->mpfBigFloat);
        return self;
    }
    return nil;
}

- (instancetype)initWithBigIntOBJC:(BigInt_OBJC *)bigIntNumber {
    if (self = [super init]) {
        mpf_init(mpfBigFloat);
        mpf_set_z(mpfBigFloat, bigIntNumber->mpzBigInt);
        return self;
    }
    return nil;
}

- (instancetype)initWithBigFracOBJC:(BigFrac_OBJC *)bigFracNumber {
    if (self = [super init]) {
        mpf_init(mpfBigFloat);
        mpf_set_q(mpfBigFloat, bigFracNumber->mpqBigFrac);
        return self;
    }
    return nil;
}

- (instancetype)initWithLong:(long)longNumber {
    if (self = [super init]) {
        mpf_init_set_si(mpfBigFloat, longNumber);
        return self;
    }
    return nil;
}

- (instancetype)initWithUnsignedLong:(unsigned long)unsignedLongNumber {
    if (self = [super init]) {
        mpf_init_set_ui(mpfBigFloat, unsignedLongNumber);
        return self;
    }
    return nil;
}

- (instancetype)initWithDouble:(double)doubleNumber {
    if (self = [super init]) {
        mpf_init_set_d(mpfBigFloat, doubleNumber);
        return self;
    }
    return nil;
}

- (instancetype)initWithString:(const char *)string inBase:(int)base {
    if (self = [super init]) {
        if (mpf_init_set_str(mpfBigFloat, string, base) == 0) {
            return self;
        } else {
            mpf_clear(mpfBigFloat);
            return nil;
        }
    }
    return nil;
}


#pragma mark - Settings

- (void)setDefaultPrecision:(unsigned long)precision {
    mpf_set_default_prec(precision);
}

- (unsigned long)getDefaultPrecision {
    return mpf_get_default_prec();
}


#pragma mark - Properties

- (void)setPrecision:(unsigned long)precision {
    mpf_set_prec(mpfBigFloat, precision);
}

- (unsigned long)getPrecision {
    return mpf_get_prec(mpfBigFloat);
}


#pragma mark - Conversions

- (long)getLongValue {
    return mpf_get_si(mpfBigFloat);
}

- (unsigned long)getUnsignedLongValue {
    return mpf_get_ui(mpfBigFloat);
}

- (double)getDoubleValue {
    return mpf_get_d(mpfBigFloat);
}

- (char *)getStringValueInBase:(int)base
             exponentReference:(long *)exponent
             maxNumberOfDigits:(size_t)nDigits {
    return mpf_get_str(NULL, exponent, base, nDigits, mpfBigFloat);
}


#pragma mark - Comparisons

- (int)compareWithBigFloatOBJC:(BigFloat_OBJC *)bigFloatNumber {
    return mpf_cmp(mpfBigFloat, bigFloatNumber->mpfBigFloat);
}

- (int)compareWithDouble:(double)doubleNumber {
    return mpf_cmp_d(mpfBigFloat, doubleNumber);
}

- (int)compareWithUnsignedLong:(unsigned long)unsignedLongNumber {
    return mpf_cmp_ui(mpfBigFloat, unsignedLongNumber);
}

- (int)compareWithLong:(long)longNumber {
    return mpf_cmp_si(mpfBigFloat, longNumber);
}


#pragma mark - Operations

+ (void)set:(BigFloat_OBJC *)result toSumOf:(BigFloat_OBJC *)left and:(BigFloat_OBJC *)right {
    mpf_add(result->mpfBigFloat, left->mpfBigFloat, right->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toSumOf:(BigFloat_OBJC *)left andUnsignedLong:(unsigned long)right {
    mpf_add_ui(result->mpfBigFloat, left->mpfBigFloat, right);
}

+ (void)set:(BigFloat_OBJC *)result toNegationOf:(BigFloat_OBJC *)bigFloatNumber {
    mpf_neg(result->mpfBigFloat, bigFloatNumber->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toDifferenceOf:(BigFloat_OBJC *)left and:(BigFloat_OBJC *)right {
    mpf_sub(result->mpfBigFloat, left->mpfBigFloat, right->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toDifferenceOfUnsignedLong:(unsigned long)left and:(BigFloat_OBJC *)right {
    mpf_ui_sub(result->mpfBigFloat, left, right->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toDifferenceOf:(BigFloat_OBJC *)left andUnsignedLong:(unsigned long)right {
    mpf_sub_ui(result->mpfBigFloat, left->mpfBigFloat, right);
}

+ (void)set:(BigFloat_OBJC *)result toProductOf:(BigFloat_OBJC *)left and:(BigFloat_OBJC *)right {
    mpf_mul(result->mpfBigFloat, left->mpfBigFloat, right->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toProductOf:(BigFloat_OBJC *)left andUnsignedLong:(unsigned long)right {
    mpf_mul_ui(result->mpfBigFloat, left->mpfBigFloat, right);
}

+ (void)set:(BigFloat_OBJC *)result toQuotientOf:(BigFloat_OBJC *)left and:(BigFloat_OBJC *)right {
    mpf_div(result->mpfBigFloat, left->mpfBigFloat, right->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toQuotientOfUnsignedLong:(unsigned long)left and:(BigFloat_OBJC *)right {
    mpf_ui_div(result->mpfBigFloat, left, right->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toQuotientOf:(BigFloat_OBJC *)left andUnsignedLong:(unsigned long)right {
    mpf_div_ui(result->mpfBigFloat, left->mpfBigFloat, right);
}

+ (void)set:(BigFloat_OBJC *)result toAbsoluteValueOf:(BigFloat_OBJC *)bigFloatNumber {
    mpf_abs(result->mpfBigFloat, bigFloatNumber->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toSquareRootOf:(BigFloat_OBJC *)bigFloatNumber {
    mpf_sqrt(result->mpfBigFloat, bigFloatNumber->mpfBigFloat);
}

+ (void)set:(BigFloat_OBJC *)result toSquareRootOfUnsignedLong:(unsigned long)unsignedLong {
    mpf_sqrt_ui(result->mpfBigFloat, unsignedLong);
}

+ (void)set:(BigFloat_OBJC *)result to:(BigFloat_OBJC *)base toThePower:(unsigned long)exponent {
    mpf_pow_ui(result->mpfBigFloat, base->mpfBigFloat, exponent);
}

@end
