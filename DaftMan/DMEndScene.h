//
//  DMEndScene.h
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMSceneDirectorDelegate.h"

@interface DMEndScene : SKScene

@property (nonatomic, retain) SKLabelNode *titleLabel;
@property (nonatomic, retain) SKLabelNode *scoreLabel;

@property (nonatomic, retain) SKLabelNode *lineThreeLabel;
@property (nonatomic, retain) SKLabelNode *lineFourLabel;

@property (nonatomic, assign) id <DMSceneDirectorDelegate> delegate;

@property (nonatomic, assign) int level;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) BOOL win;

@property (nonatomic, assign) BOOL firstUpdate;
@property (nonatomic, assign) NSTimeInterval startTime;

- (id)initWithSize:(CGSize)size level:(int)aLevel score:(int)aScore time:(NSTimeInterval)time won:(BOOL)won;

@end
