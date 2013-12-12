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

+ (NSArray *)colors {
    NSColor *red = [NSColor colorWithRed:0.78 green:0.21 blue:0.21 alpha:1.0];
    NSColor *green = [NSColor colorWithRed:0.21 green:0.78 blue:0.21 alpha:1.0];
    NSColor *blue = [NSColor colorWithRed:0.21 green:0.68 blue:0.78 alpha:1.0];
    NSColor *yellow = [NSColor colorWithRed:0.78 green:0.68 blue:0.21 alpha:1.0];
    
    return @[red, green, blue, yellow];
}

+ (SKAction *)actionForSprite {
    NSArray *colors = [DMDaftColor colors];
    
    SKAction *changeToRed = [SKAction colorizeWithColor:colors[0] colorBlendFactor:0 duration:0];
    SKAction *changeToGreen = [SKAction colorizeWithColor:colors[1] colorBlendFactor:0 duration:0];
    SKAction *changeToBlue = [SKAction colorizeWithColor:colors[2] colorBlendFactor:0 duration:0];
    SKAction *changeToYellow = [SKAction colorizeWithColor:colors[3] colorBlendFactor:0 duration:0];
    
    SKAction *actionSequence = [SKAction sequence:@[
                                          changeToRed,
                                          [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                          changeToGreen,
                                          [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                          changeToBlue,
                                          [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                          changeToYellow,
                                          [SKAction waitForDuration:COLOR_WAIT_DURATION]
                                          ]];
    
    return [SKAction repeatActionForever:actionSequence];
}

+ (SKAction *)actionForLabel:(SKLabelNode *)label {
    NSArray *colors = [DMDaftColor colors];
    
    void (^changeToRed)(void) = ^void (void)
    {
        label.fontColor = colors[0];
    };
    
    void (^changeToGreen)(void) = ^void (void)
    {
        label.fontColor = colors[1];
    };
    
    void (^changeToBlue)(void) = ^void (void)
    {
        label.fontColor = colors[2];
    };
    
    void (^changeToYellow)(void) = ^void (void)
    {
        label.fontColor = colors[3];
    };
    
    SKAction *actionSequence = [SKAction sequence:@[
                                                    [SKAction runBlock:changeToRed],
                                                    [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                                    [SKAction runBlock:changeToGreen],
                                                    [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                                    [SKAction runBlock:changeToBlue],
                                                    [SKAction waitForDuration:COLOR_WAIT_DURATION],
                                                    [SKAction runBlock:changeToYellow],
                                                    [SKAction waitForDuration:COLOR_WAIT_DURATION]
                                                    ]];
    
    return [SKAction repeatActionForever:actionSequence];
}

@end
