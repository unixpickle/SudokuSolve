//
//  ANAppDelegate.m
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAppDelegate.h"

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    mainWindow = [[ANBoardWindow alloc] init];
    [mainWindow center];
    [mainWindow makeKeyAndOrderFront:self];
    
    /*UInt8 numbers[81] = {1,4,5,3,2,7,6,9,8,8,3,9,6,5,4,1,2,7,6,7,2,9,1,8,5,4,3,4,9,6,1,8,5,3,7,2,2,1,8,4,7,3,9,5,6,7,5,3,2,9,6,4,8,1,3,6,7,5,4,2,8,1,9,9,8,4,7,6,1,2,3,5,5,2,1,8,3,9,7,6,4};
    ANSudokuBoard * board = [[ANSudokuBoard alloc] initWithBoard:numbers];
    [mainWindow.boardView updateBoard:board];
    
    NSLog(@"%d", [board isSolved]);*/
}

- (IBAction)solve:(id)sender {
    [mainWindow solve];
}

@end
