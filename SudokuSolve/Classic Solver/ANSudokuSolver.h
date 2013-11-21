//
//  ANSudokuSolver.h
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANMutableSudokuBoard.h"

@protocol ANSudokuSolverDelegate

- (void)sudokuSolver:(id)sender foundSolution:(ANSudokuBoard *)board;
- (void)sudokuSolverFailed:(id)sender;

@end

@interface ANSudokuSolver : NSObject {
    ANMutableSudokuBoard * board;
    NSThread * thread;
}

@property (nonatomic, weak) NSObject<ANSudokuSolverDelegate> * delegate;

- (id)initWithBoard:(ANSudokuBoard *)aBoard;

- (void)run;
- (void)cancel;

@end
