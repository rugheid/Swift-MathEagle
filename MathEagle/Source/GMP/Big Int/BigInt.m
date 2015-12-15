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

@end
