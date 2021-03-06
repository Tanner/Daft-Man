//
//  DMMyScene.h
//  DaftMan
//

//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMSceneDirectorDelegate.h"
#import "DMLevel.h"
#import "DMScoreBoard.h"

@interface DMGameScene : SKScene

@property (nonatomic, retain) DMLevel *level;
@property (nonatomic, retain) DMScoreBoard *scoreBoard;

- (id)initWithSize:(CGSize)size level:(int)aLevel startingScore:(int)score startingHealth:(int)health delegate:(id <DMSceneDirectorDelegate>)delegate;

@end
