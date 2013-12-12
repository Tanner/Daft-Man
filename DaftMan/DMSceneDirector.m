//
//  DMSceneDirector.m
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMSceneDirector.h"

#import "DMMainMenuScene.h"
#import "DMGameScene.h"
#import "DMEndScene.h"

@implementation DMSceneDirector

@synthesize size, view;

- (id)initWithSize:(CGSize)aSize view:(SKView *)aView {
    if (self = [super init]) {
        size = aSize;
        view = aView;
    }
    
    [self mainMenu];
    
    return self;
}

- (void)mainMenu {
    DMMainMenuScene *mainMenuScene = [[DMMainMenuScene alloc] initWithSize:self.size];
    
    mainMenuScene.delegate = self;
    
    [view presentScene:mainMenuScene];
}

- (void)levelCompleteForlevel:(int)aLevel score:(int)score time:(NSTimeInterval)time won:(BOOL)won {
    DMEndScene *endScene = [[DMEndScene alloc] initWithSize:self.size level:aLevel score:score time:time won:won];
    
    endScene.delegate = self;
    
    [view presentScene:endScene];
}

- (void)nextLevel:(int)level startingScore:(int)score {
    DMGameScene *gameScene = [[DMGameScene alloc] initWithSize:size level:level startingScore:score delegate:self];

    [view presentScene:gameScene];
}

@end
