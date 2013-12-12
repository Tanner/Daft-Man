//
//  DMMainMenu.h
//  DaftMan
//
//  Created by Tanner Smith on 12/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMSceneDirectorDelegate.h"

@interface DMMainMenuScene : SKScene

@property (nonatomic, retain) SKLabelNode *titleLabel;
@property (nonatomic, retain) SKLabelNode *playLabel;
@property (nonatomic, retain) SKLabelNode *copyrightLabel;

@property (nonatomic, assign) id <DMSceneDirectorDelegate> delegate;

@end
