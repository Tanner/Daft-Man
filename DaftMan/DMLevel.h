//
//  DMLevel.h
//  DaftMan
//
//  Created by Tanner Smith on 11/14/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMScoreBoard.h"

#import "DMMovingSpriteDelegate.h"
#import "DMItemDelegate.h"
#import "DMSceneDirectorDelegate.h"

@interface DMLevel : SKNode <DMMovingSpriteDelegate, DMItemDelegate>

@property (nonatomic, assign) BOOL bombPlaced;

@property (nonatomic, assign) int score;
@property (nonatomic, assign) int level;
@property (nonatomic, assign) NSTimeInterval timeLeft;
@property (nonatomic, assign) int numberOfRupees;

@property (nonatomic, assign) BOOL firstUpdate;
@property (nonatomic, assign) NSTimeInterval lastUpdateTime;

@property (nonatomic, retain) DMScoreBoard *scoreBoard;
@property (nonatomic, assign) id <DMSceneDirectorDelegate> delegate;

- (id)init;
- (id)initWithLevel:(int)aLevel score:(int)startScore;
- (id)initWithLevel:(int)aLevel score:(int)startScore broHealth:(int)health;
- (id)initNumberOfFoes:(int)foeCount numberOfRupies:(int)rupeeCount score:(int)startScore;

- (void)update:(NSTimeInterval)currentTime;

@end
