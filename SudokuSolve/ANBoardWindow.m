//
//  ANBoardWindow.m
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBoardWindow.h"

@implementation ANBoardWindow

@synthesize boardView;

- (id)init {
    if ((self = [super initWithContentRect:NSMakeRect(0, 0, 350, 350)
                                 styleMask:(NSTitledWindowMask | NSClosableWindowMask)
                                   backing:NSBackingStoreBuffered defer:NO])) {
        self.title = @"Sudoku Cheater";
        
        boardView = [[ANBoardView alloc] initWithBoard:[[ANSudokuBoard alloc] init]];
        boardView.frame = NSMakeRect(25, 25, 300, 300);
        [self.contentView addSubview:boardView];
        
        loadShield = [[ANAlphaView alloc] initWithFrame:[self.contentView bounds]];
        loadShield.alphaValue = 0.3;
        
        progress = [[NSProgressIndicator alloc] init];
        [progress setStyle:NSProgressIndicatorSpinningStyle];
        [progress setIndeterminate:YES];
    }
    return self;
}

- (void)solve {
    if (isLoading) return;
    [self startLoadingUI];
    
    ANSudokuSolver * solver = [[ANSudokuSolver alloc] initWithBoard:boardView.board];
    solver.delegate = self;
    [solver run];
}

- (void)startLoadingUI {
    isLoading = YES;
    boardView.disable = YES;
    
    [self.contentView addSubview:loadShield];
    [self.contentView addSubview:progress];
    
    loadShield.frame = [self.contentView bounds];
    progress.frame = NSMakeRect(([self.contentView frame].size.width - 32) / 2,
                                ([self.contentView frame].size.height - 32) / 2,
                                32, 32);
    
    [progress startAnimation:self];
}

- (void)stopLoadingUI {
    isLoading = NO;
    boardView.disable = NO;
    
    [loadShield removeFromSuperview];
    [progress removeFromSuperview];
    [progress stopAnimation:self];
}

#pragma mark - Sudoku -

- (void)sudokuSolver:(id)sender foundSolution:(ANSudokuBoard *)board {
    [boardView updateBoard:board];
    [self stopLoadingUI];
}

- (void)sudokuSolverFailed:(id)sender {
    NSLog(@"no solution");
    [self stopLoadingUI];
}

@end
