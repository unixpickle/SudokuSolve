//
//  ANMutableSudokuBoard.m
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANMutableSudokuBoard.h"

@implementation ANMutableSudokuBoard

- (void)setValue:(UInt8)number atX:(int)x y:(int)y {
    spaces[x + (9 * y)] = number;
}

- (void)setValue:(UInt8)number atIndex:(int)index {
    spaces[index] = number;
}

@end
