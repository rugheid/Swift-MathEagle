//
//  Matrix.m
//  MathEagle
//
//  Created by Rugen Heidbuchel on 23/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

#import "Matrix.h"
#import <Accelerate/Accelerate.h>

@implementation Matrix_OBJC

+ (void)LUDecompositionOfFloatMatrix:(float *)matrix nrOfRows:(int)rows nrOfColumns:(int)columns withPivotArray:(int *)pivotArray withInfo:(int *)info {
    
    sgetrf_(&rows, &columns, matrix, &rows, pivotArray, info);
}

+ (void)LUDecompositionOfDoubleMatrix:(double *)matrix nrOfRows:(int)rows nrOfColumns:(int)columns withPivotArray:(int *)pivotArray withInfo:(int *)info {
    
    dgetrf_(&rows, &columns, matrix, &rows, pivotArray, info);
}

@end
