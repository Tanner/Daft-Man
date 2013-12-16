//
//  DMMovingSprite.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMMovingSprite.h"

@implementation DMMovingSprite

@synthesize direction, distanceToMove;
@synthesize health, immunity;
@synthesize movementMultiplier, lastAct, endSpeedUp;
@synthesize delegate;

@synthesize upWalkTextures, downWalkTextures, leftWalkTextures, rightWalkTextures;
@synthesize upWalkAnimation, downWalkAnimation, leftWalkAnimation, rightWalkAnimation;

#define TIME_PER_FRAME (1.0 / 5)

#define BLINK_DURATION  0.25
#define BLINK_COUNT 8

#define SPEED_UP_DURATION 14

- (id)initWithHealth:(int)aHealth atlasName:(NSString *)atlasName {
    if (self = [super init]) {
        direction = STOP;
        distanceToMove = CGPointMake(0, 0);

        health = aHealth;
        
        movementMultiplier = 1;
        
        [self loadTexturesFromAtlasNamed:atlasName count:3];
        
        self.texture = upWalkTextures[0];
        self.size = ((SKTexture *) upWalkTextures[0]).size;
    }
    
    return self;
}

#pragma mark -
#pragma mark Movement Methods

- (void)moveUp {
    [self runAction:upWalkAnimation withKey:@"movementAnimation"];
    
    distanceToMove = CGPointMake(0, 1);
    direction = UP;
}

- (void)moveDown {
    [self runAction:downWalkAnimation withKey:@"movementAnimation"];
    
    distanceToMove = CGPointMake(0, -1);
    direction = DOWN;
}

- (void)moveLeft {
    [self runAction:leftWalkAnimation withKey:@"movementAnimation"];
    
    distanceToMove = CGPointMake(-1, 0);
    direction = LEFT;
}

- (void)moveRight {
    [self runAction:rightWalkAnimation withKey:@"movementAnimation"];

    distanceToMove = CGPointMake(1, 0);
    direction = RIGHT;
}

- (void)stop {
    [self removeActionForKey:@"movementAnimation"];
    
    distanceToMove = CGPointMake(0, 0);
    direction = STOP;
}

- (void)speedUp {
    movementMultiplier = 2.0;
    
    endSpeedUp = lastAct + SPEED_UP_DURATION;
}

- (void)normalSpeed {
    movementMultiplier = 1.0;
}

- (void)act:(NSTimeInterval)currentTime {
    CGPoint newPosition = CGPointMake(self.position.x + distanceToMove.x * movementMultiplier, self.position.y + distanceToMove.y * movementMultiplier);
    
    newPosition = [delegate autoCorrectedPoint:newPosition sprite:self];
    
    self.position = newPosition;
    
    if (movementMultiplier > 1.0 && endSpeedUp <= currentTime) {
        [self normalSpeed];
    }
    
    lastAct = currentTime;
}

#pragma mark -
#pragma mark Health Methods

- (void)hurt {
    if ([self actionForKey:@"blink"]) {
        // Blink is already running so we are "immune"
        return;
    }
    
    health--;
    
    [delegate hurt:self];
    
    if (health <= 0) {
        [delegate died:self];
        [self removeFromParent];
        
        return;
    }
    
    NSArray *blinkActions = @[
        [SKAction fadeOutWithDuration:BLINK_DURATION / 2],
        [SKAction fadeInWithDuration:BLINK_DURATION / 2]
    ];
    
    SKAction *blinkSequence = [SKAction sequence:blinkActions];
    SKAction *blink = [SKAction repeatAction:blinkSequence count:BLINK_COUNT];
    
    [self runAction:blink withKey:@"blink"];
}

#pragma mark -
#pragma mark Texture Helpers

- (void)loadTexturesFromAtlasNamed:(NSString *)atlasName count:(int)count {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    
    NSString *formatString = [NSString stringWithFormat:@"%@-%%@-", atlasName];
    
    NSString *upString = [NSString stringWithFormat:formatString, @"up"];
    NSString *downString = [NSString stringWithFormat:formatString, @"down"];
    NSString *leftString = [NSString stringWithFormat:formatString, @"left"];
    NSString *rightString = [NSString stringWithFormat:formatString, @"right"];
    
    upWalkTextures = [self textureGroupFromAtlas:atlas prefix:upString count:count];
    downWalkTextures = [self textureGroupFromAtlas:atlas prefix:downString count:count];
    leftWalkTextures = [self textureGroupFromAtlas:atlas prefix:leftString count:count];
    rightWalkTextures = [self textureGroupFromAtlas:atlas prefix:rightString count:count];
    
    upWalkAnimation = [SKAction animateWithTextures:self.upWalkTextures timePerFrame:TIME_PER_FRAME];
    downWalkAnimation = [SKAction animateWithTextures:self.downWalkTextures timePerFrame:TIME_PER_FRAME];
    leftWalkAnimation = [SKAction animateWithTextures:self.leftWalkTextures timePerFrame:TIME_PER_FRAME];
    rightWalkAnimation = [SKAction animateWithTextures:self.rightWalkTextures timePerFrame:TIME_PER_FRAME];
    
    upWalkAnimation = [SKAction repeatActionForever:upWalkAnimation];
    downWalkAnimation = [SKAction repeatActionForever:downWalkAnimation];
    leftWalkAnimation = [SKAction repeatActionForever:leftWalkAnimation];
    rightWalkAnimation = [SKAction repeatActionForever:rightWalkAnimation];
}

- (NSArray *)textureGroupFromAtlas:(SKTextureAtlas *)atlas prefix:(NSString *)prefix count:(int)count {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= count; i++) {
        SKTexture *texture = [atlas textureNamed:[NSString stringWithFormat:@"%@%d", prefix, i]];
        
        [array addObject:texture];
    }
    
    return array;
}

@end
