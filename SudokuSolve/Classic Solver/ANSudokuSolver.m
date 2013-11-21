//
//  ANSudokuSolver.m
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSudokuSolver.h"

@interface ANSudokuSolver (Private)

- (void)backgroundMethod;
- (ANSudokuBoard *)iteration:(int)index;
- (void)notifySolution:(ANSudokuBoard *)soln;

@end

@implementation ANSudokuSolver

- (id)initWithBoard:(ANSudokuBoard *)aBoard {
    if ((self = [super init])) {
        board = [aBoard mutableCopy];
    }
    return self;
}

- (void)run {
    if (thread) return;
    thread = [[NSThread alloc] initWithTarget:self
                                     selector:@selector(backgroundMethod)
                                       object:nil];
    [thread start];
}

- (void)cancel {
    [thread cancel];
    thread = nil;
}

#pragma mark - Private -

- (void)backgroundMethod {
    ANSudokuBoard * solved = [self iteration:0];
    if (!solved) {
        if ([self.delegate respondsToSelector:@selector(sudokuSolverFailed:)]) {
            [self.delegate performSelectorOnMainThread:@selector(sudokuSolverFailed:)
                                            withObject:self
                                         waitUntilDone:NO];
        }
    } else if ([self.delegate respondsToSelector:@selector(sudokuSolver:foundSolution:)]) {
        [self performSelectorOnMainThread:@selector(notifySolution:)
                               withObject:solved
                            waitUntilDone:NO];
    }
}

- (ANSudokuBoard *)iteration:(int)index {
    if (![board isSolvable]) return nil;
    if (index == 81) {
        if ([board isSolved]) return [board copy];
        return nil;
    }
    if ([board getValueAtIndex:index]) return [self iteration:(index + 1)];
    for (int i = 1; i <= 9; i++) {
        [board setValue:i atIndex:index];
        ANSudokuBoard * soln = [self iteration:(index + 1)];
        if (soln) return soln;
    }
    [board setValue:0 atIndex:index];
    return nil;
}

- (void)notifySolution:(ANSudokuBoard *)soln {
    [self.delegate sudokuSolver:self foundSolution:soln];
}

@end
