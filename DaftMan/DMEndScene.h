//
//  DMEndScene.h
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DMEndScene : SKScene

@property (nonatomic, retain) SKLabelNode *titleLabel;
@property (nonatomic, retain) SKLabelNode *scoreLabel;

@property (nonatomic, retain) SKLabelNode *lineThreeLabel;
@property (nonatomic, retain) SKLabelNode *lineFourLabel;

- (id)initWithSize:(CGSize)size level:(int)level score:(int)score time:(NSTimeInterval)time won:(BOOL)won;

@end
