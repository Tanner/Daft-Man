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
#import "DMFoe.h"
#import "DMRupee.h"

@implementation DMLevel

#define NUM_TILES_WIDTH 17
#define NUM_TILES_HEIGHT 13

#define TIME_TO_WIN 120
#define HURT_FOE_SCORE_VALUE 5

#define BOMB_DISTANCE 2

#define ADDITIONAL_BRICKS 5

@synthesize bombPlaced;
@synthesize score, level, timeLeft, numberOfRupees;
@synthesize lastUpdateTime;
@synthesize scoreBoard;

- (id)init {
    if (self = [self initNumberOfFoes:5 numberOfRupies:10]) {
    }
    
    return self;
}

- (id)initNumberOfFoes:(int)foeCount numberOfRupies:(int)rupeeCount {
    if (self = [super init]) {
        self.name = @"level";
        
        timeLeft = TIME_TO_WIN;
        level = 1;
        
        // Create all our useful SKNodes
        SKNode *ground = [[SKNode alloc] init];
        ground.name = @"ground";
        
        SKNode *items = [[SKNode alloc] init];
        items.name = @"items";
        
        SKNode *movingSprites = [[SKNode alloc] init];
        movingSprites.name = @"moving-sprites";
        movingSprites.zPosition = 1;
        
        [self addChild:ground];
        [self addChild:items];
        [self addChild:movingSprites];
        
        numberOfRupees = rupeeCount;
        bombPlaced = NO;
        
        // Add ground objects
        [self addGroundObjects];
        
        // Add bro and foes
        [self addFoes:foeCount];
        
        DMBro *bro = [[DMBro alloc] init];
        bro.position = [DMTile tileCenterForRow:1 column:1];
        bro.delegate = self;
        
        [movingSprites addChild:bro];
        
        // Add bricks
        [self addBricks:rupeeCount];
    }
    
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    static BOOL firstUpdate = YES;
    
    [self checkCollisions];
    
    [self enumerateChildNodesWithName:@"//moving-sprites/*" usingBlock:^(SKNode *node, BOOL *stop) {
        DMMovingSprite *movingSprite = (DMMovingSprite *) node;
        
        [movingSprite act];
    }];
    
    if (!firstUpdate) {
        timeLeft -= currentTime - lastUpdateTime;
        
        [scoreBoard setTime:timeLeft];
    } else {
        firstUpdate = NO;
    }
    
    lastUpdateTime = currentTime;
}

- (void)checkCollisions {
    SKNode *items = [self childNodeWithName:@"items"];
    SKNode *movingSprites = [self childNodeWithName:@"moving-sprites"];
    
    if ([items.children count] == 0 || [movingSprites.children count] == 0) {
        return;
    }
    
    [movingSprites.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DMMovingSprite *movingSprite = (DMMovingSprite *) obj;

        [items.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DMItem *item = (DMItem *) obj;

            if (CGRectIntersectsRect(movingSprite.frame, item.frame)) {
                [item pickedUpBy:movingSprite];
            }
        }];
    }];
}

#pragma mark -
#pragma mark Scoreboard

- (void)setScoreBoard:(DMScoreBoard *)aScoreBoard {
    scoreBoard = aScoreBoard;
    
    DMBro *bro = (DMBro *) [self childNodeWithName:@"//bro"];
    
    [scoreBoard setScore:score];
    [scoreBoard setLevel:level];
    [scoreBoard setTime:timeLeft];
    [scoreBoard setRupees:numberOfRupees];
    [scoreBoard setHearts:[bro health]];
}

- (void)updateScoreBoardScore {
    [scoreBoard setScore:score];
}

#pragma mark -
#pragma mark Node Creation

- (CGPoint)addGroundObjects {
    CGPoint broStart;
    NSMutableArray *row = [[NSMutableArray alloc] init];
    
    SKNode *ground = [self childNodeWithName:@"ground"];
    
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
                sprite.westTile = previousTile;
                previousTile.eastTile = sprite;
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
    
    return broStart;
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
        int index = arc4random() % [grass count];
        CGPoint grassPosition = ((SKNode *) [grass objectAtIndex:index]).position;
        
        __block BOOL collidesWithMovingSprite = NO;
        
        [self enumerateChildNodesWithName:@"//moving-sprites/*" usingBlock:^(SKNode *node, BOOL *stop) {
            if (CGPointEqualToPoint(node.position, grassPosition)) {
                collidesWithMovingSprite = YES;
                *stop = YES;
            }
        }];
        
        if (collidesWithMovingSprite) {
            i--;
            continue;
        }
        
        DMBrick *brick;
        
        if (rupeesToAdd > 0) {
            brick = [[DMBrick alloc] initWithRupee];
            
            rupeesToAdd--;
        } else {
            brick = [[DMBrick alloc] initWithRandomItem];
        }
        
        brick.position = grassPosition;
        brick.item.delegate = self;
        
        [ground addChild:brick];
    }
}

- (void)addFoes:(int)foeCount {
    SKNode *movingSprites = [self childNodeWithName:@"moving-sprites"];
    
    __block NSMutableArray *grass = [[NSMutableArray alloc] init];
    
    [self enumerateChildNodesWithName:@"//ground/grass" usingBlock:^(SKNode *node, BOOL *stop) {
        [grass addObject:node];
    }];
    
    for (int i = 0; i < foeCount; i++) {
        int index = arc4random() % [grass count];
        
        DMFoe *foe = [[DMFoe alloc] init];
        
        foe.position = ((SKNode *) [grass objectAtIndex:index]).position;
        foe.delegate = self;
        
        [movingSprites addChild:foe];
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
        fire.delegate = self;
        
        SKNode *items = [self childNodeWithName:@"//items"];
        [items addChild:fire];
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
    
    CGRect spriteFrame = CGRectMake(point.x - sprite.size.width / 2, point.y - sprite.size.height / 2, sprite.size.width, sprite.size.height);
    
    __block DMTile *collisionTile = nil;
    
    SKNode *ground = [self childNodeWithName:@"ground"];
    
    [ground.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SKNode *node = (SKNode *) obj;
        
        if ([node isKindOfClass:[DMTile class]]) {
            DMTile *tile = (DMTile *) node;
            
            if ([tile isImpassable]) {
                if (CGRectIntersectsRect(tile.frame, spriteFrame)) {
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

- (DMTile *)tileBelow:(DMMovingSprite *)movingSprite {
    return [self tileForPoint:movingSprite.position];
}

- (void)hurt:(DMMovingSprite *)movingSprite {
    if ([movingSprite isKindOfClass:[DMBro class]]) {
        DMBro *bro = (DMBro *) movingSprite;
        
        [scoreBoard setHearts:[bro health]];
    }
}

- (void)died:(DMMovingSprite *)movingSprite {
    if ([movingSprite isKindOfClass:[DMBro class]]) {
        // This is something important
        // I'm not quite what sure what yet to do
        // But it's all all right
    } else {
        // A foe died! Yay!
        score += HURT_FOE_SCORE_VALUE;
        
        [self updateScoreBoardScore];
    }
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
        
        [scoreBoard setRupees:numberOfRupees];
        
        score += RUPEE_SCORE_VALUE;
        
        [self updateScoreBoardScore];
        
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
    
    if ([movingSprite isKindOfClass:[DMBro class]]) {
        DMBro *bro = (DMBro *) movingSprite;
        
        [scoreBoard setHearts:[bro health]];
    }
    
    return YES;
}

- (BOOL)firePickedUpBy:(DMMovingSprite *)movingSprite {
    [movingSprite hurt];
    
    return NO;
}

@end
