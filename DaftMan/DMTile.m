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

#define OFFSET_X -16
#define OFFSET_Y -16

- (void)setRow:(int)aRow setColumn:(int)aColumn {
    column = aColumn;
    row = aRow;
    
    super.position = CGPointMake(column * super.size.width + super.size.width * 0.5 + OFFSET_X, row * super.size.height + super.size.height * 0.5 + OFFSET_Y);
}

- (BOOL)isImpassable {
    return NO;
}

- (BOOL)isDestructible {
    return NO;
}

@end
