//
//  ANMutableSudokuBoard.h
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSudokuBoard.h"

@interface ANMutableSudokuBoard : ANSudokuBoard

- (void)setValue:(UInt8)number atX:(int)x y:(int)y;
- (void)setValue:(UInt8)number atIndex:(int)index;

@end
