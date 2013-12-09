//
//  DMScoreBoard.h
//  DaftMan
//
//  Created by Tanner Smith on 12/8/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DMScoreBoard : SKNode

#define SCOREBOARD_HEIGHT 80

@property (nonatomic, retain) SKLabelNode *scoreLabel;
@property (nonatomic, retain) SKLabelNode *levelLabel;
@property (nonatomic, retain) SKLabelNode *timeLabel;
@property (nonatomic, retain) SKLabelNode *rupeesLabel;

@property (nonatomic, retain) SKTexture *heartTexture;
@property (nonatomic, retain) SKNode *heartsNode;

- (id)init;

- (void)setScore:(int)score;
- (void)setLevel:(int)level;
- (void)setTime:(NSTimeInterval)time;
- (void)setRupees:(int)rupees;
- (void)setHearts:(int)hearts;

@end
