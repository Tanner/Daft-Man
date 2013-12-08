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

@synthesize level, scoreBoard;

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {        
        scoreBoard = [[DMScoreBoard alloc] init];
        level = [[DMLevel alloc] init];
        
        scoreBoard.position = CGPointMake(0, size.height - SCOREBOARD_HEIGHT);
        
        level.scoreBoard = scoreBoard;
        
        [self addChild:level];
        [self addChild:scoreBoard];
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
