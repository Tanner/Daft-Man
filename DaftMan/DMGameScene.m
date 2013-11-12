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

@implementation DMGameScene {
    BOOL keyDown;
}

@synthesize tiles, bro;

#define NUM_TILES_WIDTH 17
#define NUM_TILES_HEIGHT 13

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
                } else if (r % 2 == 0 && c % 2 == 0) {
                    sprite = [[DMWall alloc] init];
                } else {
                    sprite = [[DMGrass alloc] init];
                }
                
                [sprite setRow:r setColumn:c];

                [row addObject:sprite];
                [self addChild:sprite];
            }
        }
        
        bro = [[DMBro alloc] init];
        bro.position = ((SKSpriteNode *) tiles[1][1]).position;
        
        [self addChild:bro];
    }
    
    return self;
}

- (void)update:(CFTimeInterval)currentTime {
    [bro act];
}

- (void)keyDown:(NSEvent *)theEvent {
    if (theEvent.isARepeat) {
        return;
    }
    
    
    switch (theEvent.keyCode) {
        case 126:
            [bro moveUp];
            break;
        case 125:
            [bro moveDown];
            break;
        case 123:
            [bro moveLeft];
            break;
        case 124:
            [bro moveRight];
            break;
    }
    
    [super keyDown:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent {
    if (theEvent.isARepeat) {
        return;
    }
    
    BOOL stop = NO;
    
    switch (theEvent.keyCode) {
        case 126:
            if ([bro direction] == UP) {
                stop = YES;
            }
            break;
        case 125:
            if ([bro direction] == DOWN) {
                stop = YES;
            }
            break;
        case 123:
            if ([bro direction] == LEFT) {
                stop = YES;
            }
            break;
        case 124:
            if ([bro direction] == RIGHT) {
                stop = YES;
            }
            break;
    }
    
    if (stop) {
        [bro stop];
    }
    
    [super keyUp:theEvent];
}

@end
