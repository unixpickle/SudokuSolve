//
//  ANBoardWindow.h
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANBoardView.h"
#import "ANSudokuSolver.h"
#import "ANAlphaView.h"

@interface ANBoardWindow : NSWindow <ANSudokuSolverDelegate> {
    ANBoardView * boardView;
    
    BOOL isLoading;
    NSProgressIndicator * progress;
    NSView * loadShield;
}

@property (readonly) ANBoardView * boardView;

- (void)solve;

- (void)startLoadingUI;
- (void)stopLoadingUI;

@end
