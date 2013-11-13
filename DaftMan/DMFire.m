//
//  DMFire.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMFire.h"

@implementation DMFire

- (id)initAtPosition:(CGPoint)point {
    SKTexture *fireLeft = [SKTexture textureWithImageNamed:@"fire-1.png"];
    SKTexture *fireRight = [SKTexture textureWithImageNamed:@"fire-2.png"];
    
    if (self = [super initWithTexture:fireLeft]) {
        SKAction *flick = [SKAction animateWithTextures:@[fireLeft, fireRight] timePerFrame:0.3];
        SKAction *flickering = [SKAction repeatAction:flick count:4];
        
        SKAction *extinguish = [SKAction runBlock:^{
            [self removeFromParent];
        }];
        
        self.position = point;
        
        [self runAction:[SKAction sequence:@[flickering, extinguish]]];
    }
    
    return self;
}

@end
