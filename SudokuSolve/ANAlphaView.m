//
//  ANAlphaView.m
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAlphaView.h"

@implementation ANAlphaView

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	[[NSColor whiteColor] set];
    NSRectFill(self.bounds);
}

@end
