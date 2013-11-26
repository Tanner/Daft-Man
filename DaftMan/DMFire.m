//
//  DMFire.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMFire.h"

@implementation DMFire

#define MAX_TIME_PER_FRAME 0.5
#define MIN_TIME_PER_FRAME 0.2

#define TOTAL_TIME 2.5
#define TOTAL_TIME_VARIANCE 0.4

- (id)initAtPosition:(CGPoint)point {
    SKTexture *fireLeft = [SKTexture textureWithImageNamed:@"fire-1.png"];
    SKTexture *fireRight = [SKTexture textureWithImageNamed:@"fire-2.png"];
    
    if (self = [super initWithTexture:fireLeft]) {
        NSTimeInterval timePerFrame = (arc4random() % (int) ((MAX_TIME_PER_FRAME - MIN_TIME_PER_FRAME) * 10 + 1) + (MIN_TIME_PER_FRAME * 10)) / 10.0;
        
        NSTimeInterval totalTimeVariance = (arc4random() % (int) (TOTAL_TIME_VARIANCE * 20 + 1)) / 10.0 - TOTAL_TIME_VARIANCE;
                
        int numberOfTimes = (TOTAL_TIME + totalTimeVariance) / (timePerFrame * 2);
        
        SKAction *flick = [SKAction animateWithTextures:@[fireLeft, fireRight] timePerFrame:timePerFrame];
        SKAction *flickering = [SKAction repeatAction:flick count:numberOfTimes];
        
        SKAction *extinguish = [SKAction runBlock:^{
            [self removeFromParent];
        }];
        
        self.position = point;
        
        [self runAction:[SKAction sequence:@[flickering, extinguish]]];
    }
    
    return self;
}

- (void)pickedUpBy:(DMMovingSprite *)movingSprite {
    if ([self.delegate firePickedUpBy:movingSprite]) {
        [super pickedUpBy:movingSprite];
    }
}

@end
