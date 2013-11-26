//
//  DMTile.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMTile.h"

@implementation DMTile

@synthesize row, column;
@synthesize northTile, southTile, eastTile, westTile;

#define WIDTH 32
#define HEIGHT 32

- (void)setRow:(int)aRow setColumn:(int)aColumn {
    column = aColumn;
    row = aRow;
    
    super.position = [DMTile tileCenterForRow:row column:column];
}

- (BOOL)isImpassable {
    return NO;
}

- (BOOL)isDestructible {
    return NO;
}

+ (CGPoint)tileCenterForRow:(int)row column:(int)column {
    return CGPointMake(column * WIDTH, row * HEIGHT);
}

@end
