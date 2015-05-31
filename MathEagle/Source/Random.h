//
//  Random.h
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Random_OBJC : NSObject

+ (void) randomFloatArrayOfLength:(long)length inArray:(float*)array;
+ (void) randomDoubleArrayOfLength:(long)length inArray:(double*)array;

@end
