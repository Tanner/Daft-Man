//
//  DMMyScene.h
//  DaftMan
//

//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMLevel.h"
#import "DMScoreBoard.h"

@interface DMGameScene : SKScene

@property (nonatomic, retain) DMLevel *level;
@property (nonatomic, retain) DMScoreBoard *scoreBoard;

@end
