//
//  DMMyScene.h
//  DaftMan
//

//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMGameSceneDelegate.h"
#import "DMLevel.h"
#import "DMScoreBoard.h"

@interface DMGameScene : SKScene <DMGameSceneDelegate>

@property (nonatomic, retain) DMLevel *level;
@property (nonatomic, retain) DMScoreBoard *scoreBoard;

@end
