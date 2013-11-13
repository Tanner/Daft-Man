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
#import "DMBomb.h"
#import "DMFire.h"

@implementation DMGameScene

@synthesize bombPlaced;

#define NUM_TILES_WIDTH 17
#define NUM_TILES_HEIGHT 13

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        CGPoint broStart;
        
        SKNode *ground = [[SKNode alloc] init];
        ground.name = @"ground";
        
        NSMutableArray *row = [[NSMutableArray alloc] init];
        
        for (int r = 0; r < NUM_TILES_HEIGHT; r++) {
            DMTile *previousTile = nil;
            
            for (int c = 0; c < NUM_TILES_WIDTH; c++) {
                DMTile *sprite;
                
                if (r == 0 || c == 0 || r == NUM_TILES_HEIGHT - 1 || c == NUM_TILES_WIDTH - 1) {
                    sprite = [[DMWall alloc] init];
                } else if (r % 2 == 0 && c % 2 == 0) {
                    sprite = [[DMWall alloc] init];
                } else {
                    sprite = [[DMGrass alloc] init];
                }
                
                if (row && [row count] >= NUM_TILES_WIDTH) {
                    DMTile *tile = [row objectAtIndex:c];
                    
                    sprite.southTile = tile;
                    tile.northTile = sprite;
                }
                
                if (previousTile) {
                    sprite.eastTile = previousTile;
                    previousTile.westTile = sprite;
                }
                
                [sprite setRow:r setColumn:c];

                if (r == 1 && c == 1) {
                    broStart = sprite.position;
                }
                
                [ground addChild:sprite];
                
                row[c] = sprite;
                previousTile = sprite;
            }
        }
        
        DMBro *bro = [[DMBro alloc] init];
        bro.position = broStart;
        bro.zPosition = 1;
        bro.delegate = self;
        
        bombPlaced = NO;
        
        [self addChild:ground];
        [self addChild:bro];
    }
    
    return self;
}

- (void)update:(CFTimeInterval)currentTime {
    DMBro *bro = (DMBro *) [self childNodeWithName:@"bro"];
    
    [bro act];
}

- (void)addBomb {
    if (bombPlaced) {
        return;
    }
    
    bombPlaced = YES;
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"bro"];
    
    DMBomb *bomb = [[DMBomb alloc] initWithBoom:^(DMBomb *bomb) {
        [self boom:bomb];
    }];
    
    bomb.position = [self tileForPoint:bro.position].position;
    bomb.zPosition = bro.zPosition - 1;
    
    [self addChild:bomb];
}

- (void)boom:(DMBomb *)bomb {
    bombPlaced = NO;
    
    DMTile *tile = [self tileForPoint:bomb.position];
    
    [self addFireToTile:tile];
    [self addFireToTile:tile.northTile];
    [self addFireToTile:tile.southTile];
    [self addFireToTile:tile.eastTile];
    [self addFireToTile:tile.westTile];
    
    [bomb removeFromParent];
}

- (void)addFireToTile:(DMTile *)tile {
    if (tile && [tile isKindOfClass:[DMGrass class]]) {
        DMFire *fire = [[DMFire alloc] initAtPosition:tile.position];
        
        [self addChild:fire];
    }
}

- (DMTile *)tileForPoint:(CGPoint)point {
    __block DMTile *tile = nil;
    
    [self enumerateChildNodesWithName:@"//ground/*" usingBlock:^(SKNode *node, BOOL *stop) {
        if (CGRectContainsPoint(node.frame, point)) {
            tile = (DMTile *) node;
            
            *stop = YES;
        }
    }];
    
    return tile;
}

- (void)keyDown:(NSEvent *)theEvent {
    if (theEvent.isARepeat) {
        return;
    }
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"bro"];
        
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
        case 49: {
            [self addBomb];
            break;
        }
    }
    
    [super keyDown:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent {
    if (theEvent.isARepeat) {
        return;
    }
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"bro"];
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

#pragma mark -
#pragma mark DMMovingSpriteDelegate

- (CGPoint)autoCorrectedPoint:(CGPoint)point sprite:(SKSpriteNode *)sprite {
    CGPoint oldPoint = sprite.position;
    CGPoint correctedPoint = point;
    
    CGRect spriteFrame = sprite.frame;
    
    __block DMWall *collisionWall = nil;
    
    [self enumerateChildNodesWithName:@"//ground/wall" usingBlock:^(SKNode *node, BOOL *stop) {
        DMWall *wall = (DMWall *) node;
        
        if (CGRectIntersectsRect(wall.frame, sprite.frame)) {
            *stop = YES;
            
            collisionWall = wall;
        }
    }];
    
    
    CGRect wallFrame = collisionWall.frame;
    
    CGRect intersectRect = CGRectIntersection(spriteFrame, wallFrame);
    
    int maxIntersect = 5;
    
    if (correctedPoint.x != oldPoint.x) {
        if (intersectRect.size.height > maxIntersect) {
            return oldPoint;
        }
        
        int sign = 1;
        if (spriteFrame.origin.y < wallFrame.origin.y) {
            sign *= -1;
        }
        
        correctedPoint = CGPointMake(correctedPoint.x, correctedPoint.y + sign * intersectRect.size.height);
    }
    
    else if(correctedPoint.y != oldPoint.y) {
        if (intersectRect.size.width > maxIntersect) {
            return oldPoint;
        }
        
        int sign = 1;
        if (spriteFrame.origin.x < wallFrame.origin.x) {
            sign *= -1;
        }
        
        correctedPoint = CGPointMake(correctedPoint.x + sign * intersectRect.size.width, correctedPoint.y);
    }
    
    return correctedPoint;
}

@end
