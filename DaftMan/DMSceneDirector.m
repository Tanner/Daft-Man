//
//  DMSceneDirector.m
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMSceneDirector.h"

#import "DMGameScene.h"
#import "DMEndScene.h"

@implementation DMSceneDirector

@synthesize size, view;

- (id)initWithSize:(CGSize)aSize view:(SKView *)aView {
    if (self = [super init]) {
        size = aSize;
        view = aView;
    }
    
    DMGameScene *gameScene = [DMGameScene sceneWithSize:size delegate:self];
    
    gameScene.scaleMode = SKSceneScaleModeAspectFit;
    
    [view presentScene:gameScene];
    
    return self;
}

- (void)levelCompleteForlevel:(int)aLevel score:(int)score time:(NSTimeInterval)time won:(BOOL)won {
    DMEndScene *endScene = [[DMEndScene alloc] initWithSize:self.size level:aLevel score:score time:time won:won];
    
    [view presentScene:endScene];
}

@end
