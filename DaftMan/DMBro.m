//
//  DMBro.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMBro.h"

@implementation DMBro

- (id)init {
    [self loadTextures];
    
    if (self = [super initWithTexture:[self.rightWalkTextures objectAtIndex:0]]) {
        [self setAnchorPoint:CGPointMake(0, 0)];
    }
    
    return self;
}

- (void)loadTextures {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"bro"];
    
    self.upWalkTextures = [self textureGroupFromAtlas:atlas prefix:@"bro-up-" count:3];
    self.downWalkTextures = [self textureGroupFromAtlas:atlas prefix:@"bro-down-" count:3];
    self.leftWalkTextures = [self textureGroupFromAtlas:atlas prefix:@"bro-left-" count:3];
    self.rightWalkTextures = [self textureGroupFromAtlas:atlas prefix:@"bro-right-" count:3];
}

@end
