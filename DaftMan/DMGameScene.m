//
//  DMMyScene.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMGameScene.h"

#import "DMWall.h"
#import "DMGrass.h"

@implementation DMGameScene

@synthesize tiles;

#define NUM_TILES_WIDTH 17
#define NUM_TILES_HEIGHT 13

#define OFFSET_X -16
#define OFFSET_Y -16

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        tiles = [[NSMutableArray alloc] init];
        
        for (int r = 0; r < NUM_TILES_HEIGHT; r++) {
            NSMutableArray *row = [[NSMutableArray alloc] init];
            
            [tiles addObject:row];
            
            for (int c = 0; c < NUM_TILES_WIDTH; c++) {
                DMTile *sprite;
                
                if (r == 0 || c == 0 || r == NUM_TILES_HEIGHT - 1 || c == NUM_TILES_WIDTH - 1) {
                    sprite = [[DMWall alloc] init];
                } else {
                    sprite = [[DMGrass alloc] init];
                }
                
                if (sprite == nil) continue;
                [sprite setRow:r setColumn:c];

                [row addObject:sprite];
                [self addChild:sprite];
            }
        }
        
        [tiles enumerateObjectsUsingBlock:^(NSMutableArray *row, NSUInteger idx, BOOL *stop) {
            [row enumerateObjectsUsingBlock:^(DMTile *tile, NSUInteger idx, BOOL *stop) {
                tile.position = CGPointMake(tile.position.x + OFFSET_X, tile.position.y + OFFSET_Y);
            }];
        }];
    }
    return self;
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
