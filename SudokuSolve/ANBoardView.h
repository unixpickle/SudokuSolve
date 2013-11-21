//
//  ANBoardView.h
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANSudokuBoard.h"

@interface ANBoardView : NSView {
    ANSudokuBoard * board;
    
    int selX, selY;
}

@property (readwrite) BOOL drawErrors;
@property (readwrite) BOOL disable;
@property (readonly) ANSudokuBoard * board;

- (id)initWithBoard:(ANSudokuBoard *)aBoard;
- (void)updateBoard:(ANSudokuBoard *)aBoard;

- (void)deselectCell;
- (void)selectNextCell;
- (void)selectLastCell;

- (BOOL)doesCellErrorAtX:(int)x y:(int)y;

@end
