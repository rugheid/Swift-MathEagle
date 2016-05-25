//
//  BigFrac.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 16/04/16.
//  Copyright © 2015 Rugen Heidbuchel. All rights reserved.
//

#import "BigFrac.h"
#import "BigInt.h"

@implementation BigFrac_OBJC


#pragma mark - Initialisers

- (instancetype)init{
    if (self = [super init]) {
        mpq_init(mpqBigFrac);
        return self;
    }
    return nil;
}

- (instancetype)initWithBigFracOBJC:(BigFrac_OBJC *)bigFracNumber {
    if (self = [super init]) {
        mpq_init(mpqBigFrac);
        mpq_set(mpqBigFrac, bigFracNumber->mpqBigFrac);
        return self;
    }
    return nil;
}

- (instancetype)initWithBigIntOBJC:(BigInt_OBJC *)bigIntNumber {
    if (self = [super init]) {
        mpq_init(mpqBigFrac);
        mpq_set_z(mpqBigFrac, bigIntNumber->mpzBigInt);
        return self;
    }
    return nil;
}

- (instancetype)initWithLongNumerator:(long)longNumerator denominator:(long)longDenominator {
    if (self = [super init]) {
        mpq_init(mpqBigFrac);
        mpq_set_si(mpqBigFrac, longNumerator, longDenominator);
        return self;
    }
    return nil;
}

- (instancetype)initWithUnsignedLongNumerator:(unsigned long)unsignedLongNumerator denominator:(unsigned long)unsignedLongDenominator {
    if (self = [super init]) {
        mpq_init(mpqBigFrac);
        mpq_set_ui(mpqBigFrac, unsignedLongNumerator, unsignedLongDenominator);
        return self;
    }
    return nil;
}

- (instancetype)initWithString:(const char *)string inBase:(int)base {
    if (self = [super init]) {
        mpq_init(mpqBigFrac);
        if (mpq_set_str(mpqBigFrac, string, base) == 0) {
            return self;
        } else {
            mpq_clear(mpqBigFrac);
            return nil;
        }
    }
    return nil;
}


#pragma mark - Deallocation

- (void)clear {
    mpq_clear(mpqBigFrac);
}


#pragma mark - Basic Methods

- (void)canonicalize {
    mpq_canonicalize(mpqBigFrac);
}


#pragma mark - Basic Properties

- (BigInt_OBJC *)numerator {
    BigInt_OBJC *bigIntOBJC = [[BigInt_OBJC alloc] init];
    mpz_set(bigIntOBJC->mpzBigInt, mpq_numref(mpqBigFrac));
    return bigIntOBJC;
}

- (BigInt_OBJC *)denominator {
    BigInt_OBJC *bigIntOBJC = [[BigInt_OBJC alloc] init];
    mpz_set(bigIntOBJC->mpzBigInt, mpq_denref(mpqBigFrac));
    return bigIntOBJC;
}


#pragma mark - Conversions

- (double)getDoubleValue {
    return mpq_get_d(mpqBigFrac);
}

- (char *)getStringValueInBase:(int)base {
    return mpq_get_str(NULL, base, mpqBigFrac);
}


#pragma mark - Comparisons

- (int)compareWithBigFracOBJC:(BigFrac_OBJC *)bigFracNumber {
    return mpq_cmp(mpqBigFrac, bigFracNumber->mpqBigFrac);
}


#pragma mark - Operations

+ (void)set:(BigFrac_OBJC *)result toSumOf:(BigFrac_OBJC *)left and:(BigFrac_OBJC *)right {
    mpq_add(result->mpqBigFrac, left->mpqBigFrac, right->mpqBigFrac);
}

+ (void)set:(BigFrac_OBJC *)result toNegationOf:(BigFrac_OBJC *)bigFracNumber {
    mpq_neg(result->mpqBigFrac, bigFracNumber->mpqBigFrac);
}

+ (void)set:(BigFrac_OBJC *)result toDifferenceOf:(BigFrac_OBJC *)left and:(BigFrac_OBJC *)right {
    mpq_sub(result->mpqBigFrac, left->mpqBigFrac, right->mpqBigFrac);
}

+ (void)set:(BigFrac_OBJC *)result toProductOf:(BigFrac_OBJC *)left and:(BigFrac_OBJC *)right {
    mpq_mul(result->mpqBigFrac, left->mpqBigFrac, right->mpqBigFrac);
}

+ (void)set:(BigFrac_OBJC *)result toQuotientOf:(BigFrac_OBJC *)left and:(BigFrac_OBJC *)right {
    mpq_div(result->mpqBigFrac, left->mpqBigFrac, right->mpqBigFrac);
}

+ (void)set:(BigFrac_OBJC *)result toAbsoluteValueOf:(BigFrac_OBJC *)bigFracNumber {
    mpq_abs(result->mpqBigFrac, bigFracNumber->mpqBigFrac);
}

@end
