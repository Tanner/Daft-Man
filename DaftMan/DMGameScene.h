//
//  DMMyScene.h
//  DaftMan
//

//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMBro.h"

@interface DMGameScene : SKScene

@property (nonatomic, retain) NSMutableArray *tiles;

@property (nonatomic, retain) DMBro *bro;

@end
