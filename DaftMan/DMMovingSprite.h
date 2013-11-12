//
//  DMMovingSprite.h
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DMMovingSprite : SKSpriteNode

typedef enum movingSpriteDirection {
    UP,
    DOWN,
    LEFT,
    RIGHT,
    STOP
} MovingSpriteDirection;

@property (nonatomic, assign) MovingSpriteDirection direction;

@property (nonatomic, assign) int health;
@property (nonatomic, assign) int immunity;

@property (nonatomic, assign) NSTimeInterval moveTime;

@property (nonatomic, retain) NSArray *upWalkTextures;
@property (nonatomic, retain) NSArray *downWalkTextures;
@property (nonatomic, retain) NSArray *leftWalkTextures;
@property (nonatomic, retain) NSArray *rightWalkTextures;

@property (nonatomic, retain) SKAction *upWalkAnimation;
@property (nonatomic, retain) SKAction *downWalkAnimation;
@property (nonatomic, retain) SKAction *leftWalkAnimation;
@property (nonatomic, retain) SKAction *rightWalkAnimation;

@property (nonatomic, retain) SKAction *moveUpAction;
@property (nonatomic, retain) SKAction *moveDownAction;
@property (nonatomic, retain) SKAction *moveLeftAction;
@property (nonatomic, retain) SKAction *moveRightAction;

@property (nonatomic, retain) SKAction *moveUpGroupAction;
@property (nonatomic, retain) SKAction *moveLeftGroupAction;
@property (nonatomic, retain) SKAction *moveDownGroupAction;
@property (nonatomic, retain) SKAction *moveRightGroupAction;

- (id)initWithHealth:(int)aHealth moveTime:(NSTimeInterval)aMoveTime atlasName:(NSString *)atlasName;

- (void)moveUp;
- (void)moveDown;
- (void)moveLeft;
- (void)moveRight;
- (void)stop;

@end
