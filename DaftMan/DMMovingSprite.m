//
//  DMMovingSprite.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMMovingSprite.h"

@implementation DMMovingSprite

@synthesize direction;
@synthesize health, immunity;
@synthesize moveTime;

@synthesize upWalkTextures, downWalkTextures, leftWalkTextures, rightWalkTextures;
@synthesize upWalkAnimation, downWalkAnimation, leftWalkAnimation, rightWalkAnimation;

@synthesize moveUpAction, moveDownAction, moveLeftAction, moveRightAction;
@synthesize moveUpGroupAction, moveDownGroupAction, moveLeftGroupAction, moveRightGroupAction;

- (id)initWithHealth:(int)aHealth moveTime:(NSTimeInterval)aMoveTime atlasName:(NSString *)atlasName {
    if (self = [super init]) {
        direction = STOP;
                
        health = aHealth;
        moveTime = aMoveTime;
        
        [self setUpMoveActionsWithMoveDistance:32];
        [self loadTexturesFromAtlasNamed:atlasName count:3];
        
        [self setUpGroupedMoveActions];
        
        self.texture = upWalkTextures[0];
        self.size = ((SKTexture *) upWalkTextures[0]).size;
        
        [self setAnchorPoint:CGPointMake(0, 0)];
    }
    
    return self;
}

- (void)moveUp {
    [self runAction:moveUpGroupAction];
    
    direction = UP;
}

- (void)moveDown {
    [self runAction:moveDownGroupAction];

    direction = DOWN;
}

- (void)moveLeft {
    [self runAction:moveLeftGroupAction];

    direction = LEFT;
}

- (void)moveRight {
    [self runAction:moveRightGroupAction];

    direction = RIGHT;
}

- (void)stop {
    [self removeAllActions];
    
    direction = STOP;
}

- (void)setUpMoveActionsWithMoveDistance:(CGFloat)distance {
    moveUpAction = [SKAction moveByX:0 y:distance duration:moveTime];
    moveDownAction = [SKAction moveByX:0 y:-distance duration:moveTime];
    moveLeftAction = [SKAction moveByX:-distance y:0 duration:moveTime];
    moveRightAction = [SKAction moveByX:distance y:0 duration:moveTime];
}

- (void)setUpGroupedMoveActions {
    moveUpGroupAction = [SKAction group:@[moveUpAction, upWalkAnimation]];
    moveDownGroupAction = [SKAction group:@[moveDownAction, downWalkAnimation]];
    moveLeftGroupAction = [SKAction group:@[moveLeftAction, leftWalkAnimation]];
    moveRightGroupAction = [SKAction group:@[moveRightAction, rightWalkAnimation]];
}

- (void)loadTexturesFromAtlasNamed:(NSString *)atlasName count:(int)count {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    
    NSString *formatString = [NSString stringWithFormat:@"%@-%%@-", atlasName];
    
    NSString *upString = [NSString stringWithFormat:formatString, @"up"];
    NSString *downString = [NSString stringWithFormat:formatString, @"down"];
    NSString *leftString = [NSString stringWithFormat:formatString, @"left"];
    NSString *rightString = [NSString stringWithFormat:formatString, @"right"];
    
    self.upWalkTextures = [self textureGroupFromAtlas:atlas prefix:upString count:count];
    self.downWalkTextures = [self textureGroupFromAtlas:atlas prefix:downString count:count];
    self.leftWalkTextures = [self textureGroupFromAtlas:atlas prefix:leftString count:count];
    self.rightWalkTextures = [self textureGroupFromAtlas:atlas prefix:rightString count:count];
    
    self.upWalkAnimation = [SKAction animateWithTextures:self.upWalkTextures timePerFrame:self.moveTime / 3];
    self.downWalkAnimation = [SKAction animateWithTextures:self.downWalkTextures timePerFrame:self.moveTime / 3];
    self.leftWalkAnimation = [SKAction animateWithTextures:self.leftWalkTextures timePerFrame:self.moveTime / 3];
    self.rightWalkAnimation = [SKAction animateWithTextures:self.rightWalkTextures timePerFrame:self.moveTime / 3];
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
