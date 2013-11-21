//
//  ANBoardView.m
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBoardView.h"

@implementation ANBoardView

@synthesize board;

- (id)initWithBoard:(ANSudokuBoard *)aBoard {
    if ((self = [super init])) {
        board = aBoard;
        [self deselectCell];
        self.drawErrors = YES;
    }
    return self;
}

- (void)updateBoard:(ANSudokuBoard *)aBoard {
    board = aBoard;
    [self setNeedsDisplay:YES];
}

- (BOOL)doesCellErrorAtX:(int)x y:(int)y {
    if (![board checkColumn:x]) return YES;
    if (![board checkRow:y]) return YES;
    
    // check chamber
    int group = (x / 3) + (y / 3) * 3;
    return ![board checkChamber:group];
}

#pragma mark - Selection -

- (void)deselectCell {
    selX = -1;
    selY = -1;
    [self setNeedsDisplay:YES];
}

- (void)selectNextCell {
    selX++;
    if (selX == 9) {
        selY++;
        selX = 0;
        if (selY == 9) {
            selX = 0;
            selY = 0;
        }
    }
}

- (void)selectLastCell {
    selX--;
    if (selX < 0) {
        selX = 8;
        selY--;
        if (selY < 0) {
            selY = 8;
            selX = 8;
        }
    }
}

#pragma mark - Overrides -

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)isFlipped {
    return YES;
}

- (void)setFrame:(NSRect)frameRect {
    NSAssert(frameRect.size.width == frameRect.size.height, @"I want equal dimensions.");
    [super setFrame:frameRect];
}

#pragma mark - Events -

- (void)mouseUp:(NSEvent *)theEvent {
    if (self.disable) return;
    
    CGFloat size = self.frame.size.width / 9;
    NSPoint location = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    int x = floorf(location.x / size);
    int y = floorf(location.y / size);
    if (selX == x && selY == y) return [self deselectCell];
    selX = x;
    selY = y;
    [self setNeedsDisplay:YES];
}

- (void)keyDown:(NSEvent *)theEvent {
    if (self.disable) return;
    if (selX < 0 || selY < 0) return;
    
    if ([theEvent keyCode] == 53) return [self deselectCell];
    if ([theEvent keyCode] == 51) {
        board = [board boardBySettingValue:0 atX:selX y:selY];
        [self selectLastCell];
    } else {
        int number = atoi(theEvent.characters.UTF8String);
        if (!number && ![theEvent.characters isEqualToString:@"0"]) return;
        board = [board boardBySettingValue:(number % 10) atX:selX y:selY];
        [self selectNextCell];
    }
    [self setNeedsDisplay:YES];
}

#pragma mark - Drawing -

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor whiteColor] set];
    NSRectFill(self.bounds);

    CGFloat size = self.frame.size.width;
    CGFloat spaceSize = size / 9;
    
    // draw selection
    if (selX >= 0) {
        [[NSColor colorWithDeviceWhite:0.9 alpha:1] set];
        NSRectFill(NSMakeRect(selX * spaceSize, selY * spaceSize, spaceSize, spaceSize));
    }
    
    // draw outline
    for (int x = 1; x < 9; x++) {
        if (x % 3 == 0) {
            [[NSColor blackColor] set];
        } else [[NSColor colorWithDeviceWhite:0.5 alpha:1] set];
        NSRectFill(NSMakeRect(spaceSize * x - !(x % 3), 0, x % 3 ? 1 : 3, size));
    }
    for (int y = 1; y < 9; y++) {
        if (y % 3 == 0) {
            [[NSColor blackColor] set];
        } else [[NSColor colorWithDeviceWhite:0.5 alpha:1] set];
        NSRectFill(NSMakeRect(0, y * spaceSize - !(y % 3), size, y % 3 ? 1 : 3));
    }
    [[NSColor blackColor] set];
    NSRectFill(NSMakeRect(0, 0, size, 3));
    NSRectFill(NSMakeRect(0, size - 3, size, 3));
    NSRectFill(NSMakeRect(0, 0, 3, size));
    NSRectFill(NSMakeRect(size - 3, 0, 3, size));
    
    // fill in numbers
    NSDictionary * blackAttr = @{NSFontAttributeName: [NSFont systemFontOfSize:22],
                                 NSForegroundColorAttributeName: [NSColor blackColor]};
    NSDictionary * redAttr = @{NSFontAttributeName: [NSFont boldSystemFontOfSize:22],
                               NSForegroundColorAttributeName: [NSColor redColor]};
    for (int x = 0; x < 9; x++) {
        for (int y = 0; y < 9; y++) {
            int value = [board getValueAtX:x y:y];
            if (!value) continue;
            
            NSDictionary * attrs = blackAttr;
            if (self.drawErrors && [self doesCellErrorAtX:x y:y]) {
                attrs = redAttr;
            }
            
            NSString * drawStr = [NSString stringWithFormat:@"%d", value];
            NSSize size = [drawStr sizeWithAttributes:attrs];
            NSRect frame = NSMakeRect(round(x * spaceSize + (spaceSize - size.width) / 2),
                                      round(y * spaceSize + (spaceSize - size.height) / 2),
                                      size.width, size.height);
            [[NSColor redColor] setFill];
            [[NSColor redColor] setStroke];
            [[NSColor redColor] set];
            [drawStr drawInRect:frame withAttributes:attrs];
        }
    }
    
    // TODO: fill in errors
}

@end
