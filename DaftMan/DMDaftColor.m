//
//  DMDaftColor.m
//  DaftMan
//
//  Created by Tanner Smith on 12/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMDaftColor.h"

@implementation DMDaftColor

#define COLOR_WAIT_DURATION 1.0

+ (SKAction *)action {
    static dispatch_once_t onceToken;
    
    static NSColor *red;
    static NSColor *green;
    static NSColor *blue;
    static NSColor *yellow;
    
    static SKAction *changeToRed;
    static SKAction *changeToGreen;
    static SKAction *changeToBlue;
    static SKAction *changeToYellow;
    
    static SKAction *actionSequence;
    
    static SKAction *colorWheel;
    
    dispatch_once(&onceToken, ^{
        red = [NSColor colorWithRed:0.78 green:0.21 blue:0.21 alpha:1.0];
        green = [NSColor colorWithRed:0.21 green:0.78 blue:0.21 alpha:1.0];
        blue = [NSColor colorWithRed:0.21 green:0.68 blue:0.78 alpha:1.0];
        yellow = [NSColor colorWithRed:0.78 green:0.68 blue:0.21 alpha:1.0];
        
        changeToRed = [SKAction colorizeWithColor:red colorBlendFactor:0 duration:0];
        changeToGreen = [SKAction colorizeWithColor:green colorBlendFactor:0 duration:0];
        changeToBlue = [SKAction colorizeWithColor:blue colorBlendFactor:0 duration:0];
        changeToYellow = [SKAction colorizeWithColor:yellow colorBlendFactor:0 duration:0];
        
        actionSequence = [SKAction sequence:@[
                                              changeToRed,
                                              [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                              changeToGreen,
                                              [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                              changeToBlue,
                                              [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                              changeToYellow,
                                              [SKAction waitForDuration:COLOR_WAIT_DURATION]
                                            ]];
        
        colorWheel = [SKAction repeatActionForever:actionSequence];
    });
    
    return colorWheel;
}

@end
