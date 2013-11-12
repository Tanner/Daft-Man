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

@property (nonatomic, retain) NSArray *upWalkTextures;
@property (nonatomic, retain) NSArray *downWalkTextures;
@property (nonatomic, retain) NSArray *leftWalkTextures;
@property (nonatomic, retain) NSArray *rightWalkTextures;

- (NSArray *)textureGroupFromAtlas:(SKTextureAtlas *)atlas prefix:(NSString *)prefix count:(int)count;

@end
