//
//  DMBomb.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMBomb.h"

@implementation DMBomb

- (id)initWithBoom:(void (^)(DMBomb *bomb))block {
    SKTexture *bombLarge = [SKTexture textureWithImageNamed:@"bomb-1.png"];
    SKTexture *bombSmall = [SKTexture textureWithImageNamed:@"bomb-2.png"];
    
    if (self = [super initWithTexture:bombLarge]) {
        SKAction *charging = [SKAction animateWithTextures:@[bombSmall, bombLarge] timePerFrame:0.3];
        SKAction *pulsing = [SKAction repeatAction:charging count:4];
        
        SKAction *boom = [SKAction runBlock:^{
            block(self);
        }];
        
        SKAction *bombing = [SKAction sequence:@[pulsing, boom]];
        
        [self runAction:bombing];
    }
    
    return self;
}

@end
