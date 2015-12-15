//
//  BigInt.h
//  MathEagle
//
//  Created by Rugen Heidbuchel on 14/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gmp.h"

@interface BigInt_OBJC : NSObject {
    mpz_t mpzBigInt;
}

#pragma mark - Initialisers
- (instancetype)initWithBigIntOBJC:(BigInt_OBJC*)bigIntNumber;
- (instancetype)initWithLong:(long)longNumber;
- (instancetype)initWithUnsignedLong:(unsigned long)unsignedLongNumber;
- (instancetype)initWithDouble:(double)doubleNumber;
- (instancetype)initWithString:(const char *)string inBase:(int)base;

#pragma mark - Conversions
- (long)getLongValue;
- (unsigned long)getUnsignedLongValue;
- (double)getDoubleValue;
- (char*)getStringValueInBase:(int)base;

#pragma mark - Comparisons
- (int)compareWithBigIntOBJC:(BigInt_OBJC*)bigIntNumber;

#pragma mark - Operations
+ (void)set:(BigInt_OBJC*)result toSumOf:(BigInt_OBJC*)left and:(BigInt_OBJC*)right;

@end
