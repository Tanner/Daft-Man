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

#define OFFSET_X -16
#define OFFSET_Y -16

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setAnchorPoint:CGPointMake(0, 0)];
    }
    
    return self;
}

- (id)initWithColor:(NSColor *)color size:(CGSize)size {
    if (self = [super initWithColor:color size:size]) {
        [self setAnchorPoint:CGPointMake(0, 0)];
    }
    
    return self;
}

- (void)setRow:(int)aRow setColumn:(int)aColumn {
    column = aColumn;
    row = aRow;
    
    super.position = CGPointMake(column * super.size.width + OFFSET_X, row * super.size.height + OFFSET_Y);
}

- (BOOL)isImpassable {
    return NO;
}

- (BOOL)isDestructible {
    return NO;
}

@end
