//
//  DMMyScene.h
//  DaftMan
//

//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMMovingSpriteDelegate.h"
#import "DMBro.h"

@interface DMGameScene : SKScene <DMMovingSpriteDelegate>

@property (nonatomic, assign) BOOL bombPlaced;

@property (nonatomic, assign) int bricksInLevel;

@end
