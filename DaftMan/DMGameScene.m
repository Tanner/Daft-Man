//
//  DMMyScene.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMGameScene.h"

#import "DMLevel.h"
#import "DMMusicPlayer.h"

@implementation DMGameScene

@synthesize level, scoreBoard;

- (id)initWithSize:(CGSize)size level:(int)aLevel startingScore:(int)score startingHealth:(int)health delegate:(id <DMSceneDirectorDelegate>)delegate {
    if (self = [super initWithSize:size]) {        
        scoreBoard = [[DMScoreBoard alloc] init];
        level = [[DMLevel alloc] initWithLevel:aLevel score:score broHealth:health];
        
        scoreBoard.position = CGPointMake(0, size.height - SCOREBOARD_HEIGHT);
        
        level.scoreBoard = scoreBoard;
        level.delegate = delegate;
        
        [self addChild:level];
        [self addChild:scoreBoard];
        
        NSString *midiFilePath = [[NSBundle mainBundle] pathForResource:@"aroundtheworld" ofType:@"mid"];
        NSURL *midiFileURL = [NSURL fileURLWithPath:midiFilePath];
        
        [[DMMusicPlayer sharedMusicPlayer] playSequence:midiFileURL beatsPerMinute:120];
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
