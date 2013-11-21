//
//  ANSudokuBoard.h
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSudokuBoard : NSObject <NSCopying, NSCoding> {
    UInt8 spaces[81];
}

- (id)initWithBoard:(const UInt8 *)spaces;

- (UInt8)getValueAtX:(int)x y:(int)y;
- (UInt8)getValueAtIndex:(int)index;

- (BOOL)isSolvable;
- (BOOL)isSolved;
- (BOOL)checkRow:(NSInteger)row;
- (BOOL)checkColumn:(NSInteger)col;
- (BOOL)checkChamber:(NSInteger)chIdx;

- (ANSudokuBoard *)boardBySettingValue:(UInt8)val atX:(int)x y:(int)y;
- (ANSudokuBoard *)boardBySettingValue:(UInt8)val atIndex:(int)index;

@end
