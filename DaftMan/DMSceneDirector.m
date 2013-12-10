//
//  DMSceneDirector.m
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMSceneDirector.h"

#import "DMGameScene.h"

@implementation DMSceneDirector

@synthesize size, view;

- (id)initWithSize:(CGSize)aSize view:(SKView *)aView {
    if (self = [super init]) {
        size = aSize;
        view = aView;
    }
    
    SKScene *gameScene = [DMGameScene sceneWithSize:size];
    
    gameScene.scaleMode = SKSceneScaleModeAspectFit;
    
    [view presentScene:gameScene];
    
    return self;
}

@end
