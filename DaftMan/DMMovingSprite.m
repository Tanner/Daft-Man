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

@synthesize upWalkTextures, downWalkTextures, leftWalkTextures, rightWalkTextures;

- (id)init {
    if (self = [super init]) {
        direction = STOP;
        
        health = 100;
    }
    
    return self;
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
