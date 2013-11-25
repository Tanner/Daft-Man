//
//  DMMyScene.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMGameScene.h"

#import "DMLevel.h"

@implementation DMGameScene

@synthesize level;

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        level = [[DMLevel alloc] init];
        
        [self addChild:level];
    }
    
    return self;
}

- (void)update:(CFTimeInterval)currentTime {
    [level update:currentTime];
}

- (void)keyDown:(NSEvent *)theEvent {
    [level keyDown:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent {
    [level keyUp:theEvent];
}

@end
