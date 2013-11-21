//
//  ANSudokuBoard.m
//  SudokuSolve
//
//  Created by Alex Nichol on 11/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSudokuBoard.h"
#import "ANMutableSudokuBoard.h"

@implementation ANSudokuBoard

- (id)initWithBoard:(const UInt8 *)_spaces {
    if ((self = [super init])) {
        memcpy(spaces, _spaces, 81);
    }
    return self;
}

#pragma mark - Access -

- (UInt8)getValueAtX:(int)x y:(int)y {
    return spaces[x + (9 * y)];
}

- (UInt8)getValueAtIndex:(int)index {
    return spaces[index];
}

#pragma mark - Validation -

- (BOOL)isSolvable {
    for (int i = 0; i < 9; i++) {
        if (![self checkRow:i]) return NO;
        if (![self checkColumn:i]) return NO;
        if (![self checkChamber:i]) return NO;
    }
    return YES;
}

- (BOOL)isSolved {
    if (![self isSolvable]) return NO;
    for (int i = 0; i < 81; i++) {
        if (spaces[i] == 0) return NO;
    }
    return YES;
}

- (BOOL)checkRow:(NSInteger)row {
    int startIdx = (int)row * 9;
    UInt16 flags = 0;
    for (int i = startIdx; i < startIdx + 9; i++) {
        int number = spaces[i];
        if (number == 0) continue;
        if ((flags & (1 << number))) return NO;
        flags |= (1 << number);
    }
    return YES;
}

- (BOOL)checkColumn:(NSInteger)col {
    UInt16 flags = 0;
    for (int i = (int)col; i < 81; i += 9) {
        int number = spaces[i];
        if (number == 0) continue;
        if ((flags & (1 << number))) return NO;
        flags |= (1 << number);
    }
    return YES;
}

- (BOOL)checkChamber:(NSInteger)chIdx {
    int xOff = ((int)chIdx % 3) * 3;
    int yOff = ((int)chIdx / 3) * 3;
    UInt16 flags = 0;
    for (int x = xOff; x < xOff + 3; x++) {
        for (int y = yOff; y < yOff + 3; y++) {
            int index = x + (9 * y);
            int number = spaces[index];
            if (number == 0) continue;
            if ((flags & (1 << number))) return NO;
            flags |= (1 << number);
        }
    }
    return YES;
}

#pragma mark - Mutilation -

- (ANSudokuBoard *)boardBySettingValue:(UInt8)val atX:(int)x y:(int)y {
    UInt8 newChars[81];
    memcpy(newChars, spaces, 81);
    newChars[x + (y * 9)] = val;
    return [[ANSudokuBoard alloc] initWithBoard:newChars];
}

- (ANSudokuBoard *)boardBySettingValue:(UInt8)val atIndex:(int)index {
    UInt8 newChars[81];
    memcpy(newChars, spaces, 81);
    newChars[index] = val;
    return [[ANSudokuBoard alloc] initWithBoard:newChars];
}

#pragma mark - Copying -

- (id)mutableCopy {
    return [[ANMutableSudokuBoard alloc] initWithBoard:spaces];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[ANSudokuBoard allocWithZone:zone] initWithBoard:spaces];
}

#pragma mark - Coding -

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        NSData * data = [aDecoder decodeObjectForKey:@"data"];
        NSAssert(data.length == 81, @"Invalid data length.");
        memcpy(spaces, data.bytes, 81);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSData * data = [NSData dataWithBytes:spaces length:81];
    [aCoder encodeObject:data forKey:@"data"];
}

@end
