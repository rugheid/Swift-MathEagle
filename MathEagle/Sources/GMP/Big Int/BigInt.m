//
//  BigInt.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 14/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

#import "BigInt.h"

@implementation BigInt_OBJC


#pragma mark - Initialisers

- (instancetype)init{
    if (self = [super init]) {
        mpz_init(mpzBigInt);
        return self;
    }
    return nil;
}

- (instancetype)initWithBigIntOBJC:(BigInt_OBJC *)bigIntNumber {
    if (self = [super init]) {
        mpz_init_set(mpzBigInt, bigIntNumber->mpzBigInt);
        return self;
    }
    return nil;
}

- (instancetype)initWithLong:(long)longNumber {
    if (self = [super init]) {
        mpz_init_set_si(mpzBigInt, longNumber);
        return self;
    }
    return nil;
}

- (instancetype)initWithUnsignedLong:(unsigned long)unsignedLongNumber {
    if (self = [super init]) {
        mpz_init_set_ui(mpzBigInt, unsignedLongNumber);
        return self;
    }
    return nil;
}

- (instancetype)initWithDouble:(double)doubleNumber {
    if (self = [super init]) {
        mpz_init_set_d(mpzBigInt, doubleNumber);
        return self;
    }
    return nil;
}

- (instancetype)initWithString:(const char *)string inBase:(int)base {
    if (self = [super init]) {
        if (mpz_init_set_str(mpzBigInt, string, base) == 0) {
            return self;
        } else {
            mpz_clear(mpzBigInt);
            return nil;
        }
    }
    return nil;
}


#pragma mark - Conversions

- (long)getLongValue {
    return mpz_get_si(mpzBigInt);
}

- (unsigned long)getUnsignedLongValue {
    return mpz_get_ui(mpzBigInt);
}

- (double)getDoubleValue {
    return mpz_get_d(mpzBigInt);
}

- (char *)getStringValueInBase:(int)base {
    return mpz_get_str(NULL, base, mpzBigInt);
}


#pragma mark - Comparisons

- (int)compareWithBigIntOBJC:(BigInt_OBJC *)bigIntNumber {
    return mpz_cmp(mpzBigInt, bigIntNumber->mpzBigInt);
}


#pragma mark - Operations

+ (void)set:(BigInt_OBJC *)result toSumOf:(BigInt_OBJC *)left and:(BigInt_OBJC *)right {
    mpz_add(result->mpzBigInt, left->mpzBigInt, right->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toNegationOf:(BigInt_OBJC *)bigIntNumber {
    mpz_neg(result->mpzBigInt, bigIntNumber->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toDifferenceOf:(BigInt_OBJC *)left and:(BigInt_OBJC *)right {
    mpz_sub(result->mpzBigInt, left->mpzBigInt, right->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toProductOf:(BigInt_OBJC *)left and:(BigInt_OBJC *)right {
    mpz_mul(result->mpzBigInt, left->mpzBigInt, right->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toQuotientOf:(BigInt_OBJC *)left and:(BigInt_OBJC *)right {
    mpz_div(result->mpzBigInt, left->mpzBigInt, right->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toAbsoluteValueOf:(BigInt_OBJC *)bigIntNumber {
    mpz_abs(result->mpzBigInt, bigIntNumber->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toSquareRootOf:(BigInt_OBJC *)bigIntNumber {
    mpz_sqrt(result->mpzBigInt, bigIntNumber->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toPowerOf:(BigInt_OBJC *)left and:(BigInt_OBJC *)right modulo:(BigInt_OBJC *)modulo {
    mpz_powm(result->mpzBigInt, left->mpzBigInt, right->mpzBigInt, modulo->mpzBigInt);
}

+ (void)set:(BigInt_OBJC *)result toPowerOf:(BigInt_OBJC *)bigIntNumber and:(unsigned long int)uint {
    mpz_pow_ui(result->mpzBigInt, bigIntNumber->mpzBigInt, uint);
}

+ (void)set:(BigInt_OBJC *)result toFactorial:(unsigned long int)uint {
    mpz_fac_ui(result->mpzBigInt, uint);
}

+ (void)set:(BigInt_OBJC *)result toDoubleFactorial:(unsigned long int)uint {
    mpz_2fac_ui(result->mpzBigInt, uint);
}

+ (void)set:(BigInt_OBJC *)result toFactorial:(unsigned long int)uint multi:(unsigned long int)m {
    mpz_mfac_uiui(result->mpzBigInt, uint, m);
}

@end
