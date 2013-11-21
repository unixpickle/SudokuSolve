//
//  ANAppDelegate.h
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANBoardWindow.h"

@interface ANAppDelegate : NSObject <NSApplicationDelegate> {
    ANBoardWindow * mainWindow;
}

- (IBAction)solve:(id)sender;

@end
