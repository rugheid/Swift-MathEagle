//
//  Random.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 30/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import "Random.h"

@implementation Random_OBJC

+ (void)randomFloatArrayOfLength:(long)length inArray:(float*)array {
    
    for (long k = 0; k < length; k++) {
        
        int i = arc4random();
#warning This sometimes produces NaN or inf, so this has to be rewritten, it's also not uniform because of the exponent's random behaviour
        array[k] = *(float*)&i;
    }
}

@end
