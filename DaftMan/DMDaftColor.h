//
//  DMDaftColor.h
//  DaftMan
//
//  Created by Tanner Smith on 12/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SpriteKit/SpriteKit.h>

@interface DMDaftColor : NSObject

+ (SKAction *)actionForSprite;
+ (SKAction *)actionForLabel:(SKLabelNode *)label;

@end
