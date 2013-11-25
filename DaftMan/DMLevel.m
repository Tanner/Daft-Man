//
//  DMLevel.m
//  DaftMan
//
//  Created by Tanner Smith on 11/14/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMLevel.h"

#import "DMBro.h"
#import "DMBrick.h"
#import "DMWall.h"
#import "DMGrass.h"
#import "DMBomb.h"
#import "DMFire.h"
#import "DMItem.h"

@implementation DMLevel

#define NUM_TILES_WIDTH 17
#define NUM_TILES_HEIGHT 13

#define BOMB_DISTANCE 2

#define ADDITIONAL_BRICKS 5

@synthesize bombPlaced, numberOfRupees;

- (id)init {
    if (self = [self initNumberOfFoes:3 numberOfRupies:5]) {
    }
    
    return self;
}

- (id)initNumberOfFoes:(int)foeCount numberOfRupies:(int)rupeeCount {
    if (self = [super init]) {
        self.name = @"level";
        
        CGPoint broStart;
        
        SKNode *ground = [[SKNode alloc] init];
        ground.name = @"ground";
        
        NSMutableArray *row = [[NSMutableArray alloc] init];
        
        for (int r = 0; r < NUM_TILES_HEIGHT; r++) {
            DMTile *previousTile = nil;
            
            for (int c = 0; c < NUM_TILES_WIDTH; c++) {
                DMTile *sprite;
                
                BOOL borderWall = (r == 0 || c == 0 || r == NUM_TILES_HEIGHT - 1 || c == NUM_TILES_WIDTH - 1);
                
                if ((r % 2 == 0 && c % 2 == 0) || borderWall) {
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
        
        [self addChild:ground];
        
        [self addBricks:rupeeCount];
        
        numberOfRupees = rupeeCount;
        
        SKNode *items = [[SKNode alloc] init];
        items.name = @"items";
        
        [self addChild:items];
        
        SKNode *movingSprites = [[SKNode alloc] init];
        movingSprites.name = @"moving-sprites";
        movingSprites.zPosition = 1;
        
        DMBro *bro = [[DMBro alloc] init];
        bro.position = broStart;
        bro.delegate = self;
        
        bombPlaced = NO;
        
        [movingSprites addChild:bro];
        
        [self addChild:movingSprites];
    }
    
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    [self checkCollisions];
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"//bro"];
    
    [bro act];
}

- (void)checkCollisions {
    [self enumerateChildNodesWithName:@"//moving-sprites/*" usingBlock:^(SKNode *node, BOOL *stop) {
        DMMovingSprite *movingSprite = (DMMovingSprite *) node;
        
        [self enumerateChildNodesWithName:@"//items/*" usingBlock:^(SKNode *node, BOOL *stop) {
            DMItem *item = (DMItem *) node;
            
            if (CGRectIntersectsRect(movingSprite.frame, item.frame)) {
                [item pickedUpBy:movingSprite];
            }
        }];
    }];
}

- (void)addBricks:(int)rupeeCount {
    SKNode *ground = [self childNodeWithName:@"ground"];
    
    __block NSMutableArray *grass = [[NSMutableArray alloc] init];
    
    [self enumerateChildNodesWithName:@"//ground/grass" usingBlock:^(SKNode *node, BOOL *stop) {
        [grass addObject:node];
    }];
    
    int bricksToAdd = rupeeCount + arc4random() % ADDITIONAL_BRICKS;
    int rupeesToAdd = rupeeCount;
    
    for (int i = 0; i < bricksToAdd; i++) {
        int index = arc4random() % ([grass count] + 1);
        
        DMBrick *brick;
        
        if (rupeesToAdd > 0) {
            brick = [[DMBrick alloc] initWithRupee];
            
            rupeesToAdd--;
        } else {
            brick = [[DMBrick alloc] initWithRandomItem];
        }
        
        brick.position = ((SKNode *) [grass objectAtIndex:index]).position;
        brick.item.delegate = self;
        
        [ground addChild:brick];
    }
}

#pragma mark -
#pragma mark Bomb Handling

- (void)addBomb {
    if (bombPlaced) {
        return;
    }
    
    bombPlaced = YES;
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"//bro"];
    
    DMBomb *bomb = [[DMBomb alloc] initWithBoom:^(DMBomb *bomb) {
        [self boom:bomb];
    }];
    
    bomb.position = [self tileForPoint:bro.position].position;
    
    [self addChild:bomb];
}

- (void)boom:(DMBomb *)bomb {
    bombPlaced = NO;
    
    [bomb removeFromParent];
    
    DMTile *tile = [self tileForPoint:bomb.position];
    
    [self addFireToTile:tile];
    
    [self spreadFireFromTile:tile distance:BOMB_DISTANCE usingBlock:^DMTile *(DMTile *currentTile) {
        return currentTile.northTile;
    }];
    
    [self spreadFireFromTile:tile distance:BOMB_DISTANCE usingBlock:^DMTile *(DMTile *currentTile) {
        return currentTile.southTile;
    }];
    
    [self spreadFireFromTile:tile distance:BOMB_DISTANCE usingBlock:^DMTile *(DMTile *currentTile) {
        return currentTile.eastTile;
    }];
    
    [self spreadFireFromTile:tile distance:BOMB_DISTANCE usingBlock:^DMTile *(DMTile *currentTile) {
        return currentTile.westTile;
    }];
}

#pragma mark -
#pragma mark Fire Handling

- (void)spreadFireFromTile:(DMTile *)tile distance:(int)distance usingBlock:(DMTile *(^)(DMTile *currentTile))nextTile {
    DMTile *nextTileToBurn = nextTile(tile);
    
    if ([tile isKindOfClass:[DMGrass class]]) {
        [self addFireToTile:nextTileToBurn];
        
        __block bool blockEncountered = NO;
        
        [self enumerateChildNodesWithName:@"//ground/brick" usingBlock:^(SKNode *node, BOOL *stop) {
            if (CGPointEqualToPoint(node.position, nextTileToBurn.position)) {
                [((DMBrick *)node) destroy];
                
                blockEncountered = YES;
            }
        }];
        
        if (blockEncountered) {
            return;
        }
        
        distance--;
        
        if (distance > 0) {
            [self spreadFireFromTile:nextTileToBurn distance:distance usingBlock:nextTile];
        }
    }
}

- (void)addFireToTile:(DMTile *)tile {
    if (tile && [tile isKindOfClass:[DMGrass class]]) {
        DMFire *fire = [[DMFire alloc] initAtPosition:tile.position];
        
        [self addChild:fire];
    }
}

#pragma mark -
#pragma mark Tile Helper Methods

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


#pragma mark -
#pragma mark DMMovingSpriteDelegate

- (CGPoint)autoCorrectedPoint:(CGPoint)point sprite:(SKSpriteNode *)sprite {
    CGPoint oldPoint = sprite.position;
    CGPoint correctedPoint = point;
    
    CGRect spriteFrame = sprite.frame;
    
    __block DMTile *collisionTile = nil;
    
    [self enumerateChildNodesWithName:@"//ground/*" usingBlock:^(SKNode *node, BOOL *stop) {
        if ([node isKindOfClass:[DMTile class]]) {
            DMTile *tile = (DMTile *) node;
            
            if ([tile isImpassable]) {
                if (CGRectIntersectsRect(tile.frame, sprite.frame)) {
                    *stop = YES;
                    
                    collisionTile = tile;
                }
            }
        }
    }];
    
    CGRect tileFrame = collisionTile.frame;
    
    CGRect intersectRect = CGRectIntersection(spriteFrame, tileFrame);
    
    int maxIntersect = 5;
    
    if (correctedPoint.x != oldPoint.x) {
        if (intersectRect.size.height > maxIntersect) {
            return oldPoint;
        }
        
        int sign = 1;
        if (spriteFrame.origin.y < tileFrame.origin.y) {
            sign *= -1;
        }
        
        correctedPoint = CGPointMake(correctedPoint.x, correctedPoint.y + sign * intersectRect.size.height);
    } else if (correctedPoint.y != oldPoint.y) {
        if (intersectRect.size.width > maxIntersect) {
            return oldPoint;
        }
        
        int sign = 1;
        if (spriteFrame.origin.x < tileFrame.origin.x) {
            sign *= -1;
        }
        
        correctedPoint = CGPointMake(correctedPoint.x + sign * intersectRect.size.width, correctedPoint.y);
    }
    
    return correctedPoint;
}


#pragma mark -
#pragma mark Key Event Handling

- (void)keyDown:(NSEvent *)theEvent {
    if (theEvent.isARepeat) {
        return;
    }
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"//bro"];
    
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
        default:
            [super keyDown:theEvent];
            break;
    }
}

- (void)keyUp:(NSEvent *)theEvent {
    if (theEvent.isARepeat) {
        return;
    }
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"//bro"];
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
        default:
            [super keyUp:theEvent];
            break;
    }
    
    if (stop) {
        [bro stop];
    }
}

#pragma mark -
#pragma mark DMItemDelegate

- (BOOL)rupeePickedUpBy:(DMMovingSprite *)movingSprite {
    if ([movingSprite isKindOfClass:[DMBro class]]) {
        numberOfRupees--;
        
        return YES;
    }
    
    return NO;
}

- (BOOL)starPickedUpBy:(DMMovingSprite *)movingSprite {    
    movingSprite.movementMultiplier = 2;
    
    return YES;
}

- (BOOL)heartPickedUpBy:(DMMovingSprite *)movingSprite {
    movingSprite.health++;
    
    return YES;
}

@end
