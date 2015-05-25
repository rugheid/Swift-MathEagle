//
//  Matrix.h
//  MathEagle
//
//  Created by Rugen Heidbuchel on 23/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matrix_OBJC : NSObject

+ (void) LUDecompositionOfMatrix:(float*)matrix nrOfRows:(int)rows nrOfColumns:(int)columns withPivotArray:(int*)pivotArray withInfo:(int*)info;

@end
