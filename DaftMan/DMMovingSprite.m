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
@synthesize movementMultiplier;
@synthesize delegate;

@synthesize upWalkTextures, downWalkTextures, leftWalkTextures, rightWalkTextures;
@synthesize upWalkAnimation, downWalkAnimation, leftWalkAnimation, rightWalkAnimation;

#define TIME_PER_FRAME (1.0 / 5)

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

- (void)moveUp {
    [self runAction:upWalkAnimation];
    
    distanceToMove = CGPointMake(0, 1);
    direction = UP;
}

- (void)moveDown {
    [self runAction:downWalkAnimation];
    
    distanceToMove = CGPointMake(0, -1);
    direction = DOWN;
}

- (void)moveLeft {
    [self runAction:leftWalkAnimation];
    
    distanceToMove = CGPointMake(-1, 0);
    direction = LEFT;
}

- (void)moveRight {
    [self runAction:rightWalkAnimation];

    distanceToMove = CGPointMake(1, 0);
    direction = RIGHT;
}

- (void)stop {
    [self removeAllActions];
    
    distanceToMove = CGPointMake(0, 0);
    direction = STOP;
}

- (void)act {
    CGPoint newPosition = CGPointMake(self.position.x + distanceToMove.x * movementMultiplier, self.position.y + distanceToMove.y * movementMultiplier);
    
    newPosition = [delegate autoCorrectedPoint:newPosition sprite:self];
    
//    if ([delegate canMoveToPoint:newPosition sprite:self]) {
        self.position = newPosition;
//    }
}

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
