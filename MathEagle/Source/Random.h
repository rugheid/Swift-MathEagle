//
//  Random.h
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Rugen Heidbuchel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Random_OBJC : NSObject

+ (void) randomUIntArrayOfLength:(long)length inArray:(unsigned long*)array;
+ (void) randomUInt8ArrayOfLength:(long)length inArray:(unsigned char*)array;
+ (void) randomUInt16ArrayOfLength:(long)length inArray:(unsigned short*)array;
+ (void) randomUInt32ArrayOfLength:(long)length inArray:(unsigned int*)array;
+ (void) randomUInt64ArrayOfLength:(long)length inArray:(unsigned long long*)array;
+ (void) randomIntArrayOfLength:(long)length inArray:(long*)array;
+ (void) randomInt8ArrayOfLength:(long)length inArray:(char*)array;
+ (void) randomInt16ArrayOfLength:(long)length inArray:(short*)array;
+ (void) randomInt32ArrayOfLength:(long)length inArray:(int*)array;
+ (void) randomInt64ArrayOfLength:(long)length inArray:(long long*)array;
+ (void) randomFloatArrayOfLength:(long)length inArray:(float*)array;
+ (void) randomDoubleArrayOfLength:(long)length inArray:(double*)array;

@end
