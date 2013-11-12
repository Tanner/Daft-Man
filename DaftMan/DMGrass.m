//
//  DMGrass.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMGrass.h"

@implementation DMGrass

@synthesize red, green, blue, yellow;

#define COLOR_WAIT_DURATION 1.0

- (id)init {
    red = [NSColor colorWithRed:0.78 green:0.21 blue:0.21 alpha:1.0];
    green = [NSColor colorWithRed:0.21 green:0.78 blue:0.21 alpha:1.0];
    blue = [NSColor colorWithRed:0.21 green:0.68 blue:0.78 alpha:1.0];
    yellow = [NSColor colorWithRed:0.78 green:0.68 blue:0.21 alpha:1.0];
    
    if (self = [super initWithColor:red size:CGSizeMake(32, 32)]) {
        SKAction *changeToRed = [SKAction colorizeWithColor:red colorBlendFactor:0 duration:0];
        SKAction *changeToGreen = [SKAction colorizeWithColor:green colorBlendFactor:0 duration:0];
        SKAction *changeToBlue = [SKAction colorizeWithColor:blue colorBlendFactor:0 duration:0];
        SKAction *changeToYellow = [SKAction colorizeWithColor:yellow colorBlendFactor:0 duration:0];
        
        SKAction *actionSequence = [SKAction sequence:@[
                                                        changeToRed,
                                                        [SKAction waitForDuration: COLOR_WAIT_DURATION],
                                                        changeToGreen,
                                                        [SKAction waitForDuration: COLOR_WAIT_DURATION],
                                                        changeToBlue,
                                                        [SKAction waitForDuration: COLOR_WAIT_DURATION],
                                                        changeToYellow,
                                                        [SKAction waitForDuration: COLOR_WAIT_DURATION]
                                                        ]];
        
        SKAction *colorWheel = [SKAction repeatActionForever:actionSequence];
        
        [self runAction:colorWheel];
    }
    
    return self;
}

@end
