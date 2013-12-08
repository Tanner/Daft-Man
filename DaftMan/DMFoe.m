//
//  DMFoe.m
//  DaftMan
//
//  Created by Tanner Smith on 11/26/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMFoe.h"

@implementation DMFoe {
    DMTile *tile;
}

- (id)init {
    if (self = [super initWithHealth:3 atlasName:@"foe"]) {
        self.name = @"foe";
    }
    
    return self;
}

- (void)act {
    tile = [self.delegate tileBelow:self];
    
    if ([self shouldChangeDirection] && arc4random() % 2 == 0) {
        [self randomizeDirection];
    }
    
    [super act];
}

- (void)randomizeDirection {
    BOOL retry = YES;
    
    switch (arc4random() % 4) {
        case 0:
            if (tile.northTile) {
                [self moveUp];
                retry = NO;
            }
            break;
        case 1:
            if (tile.southTile) {
                [self moveDown];
                retry = NO;
            }
            break;
        case 2:
            if (tile.westTile) {
                [self moveLeft];
                retry = NO;
            }
            break;
        case 3:
            if (tile.eastTile) {
                [self moveRight];
                retry = NO;
            }
            break;
    }
    
    if (retry) {
        [self randomizeDirection];
    }
}

- (BOOL)shouldChangeDirection {
    if (tile) {
        return CGPointEqualToPoint(tile.position, self.position);
    }
    
    return NO;
}

- (double)distanceBetween:(CGPoint)a and:(CGPoint)b {
    double dx = a.x - b.x;
    double dy = a.y - b.y;
    
    return sqrt(pow(dx, 2) + pow(dy, 2));
}

@end
