//
//  DMMovingSpriteDelegate.h
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DMTile.h"

@class DMMovingSprite;

@protocol DMMovingSpriteDelegate <NSObject>

- (CGPoint)autoCorrectedPoint:(CGPoint)point sprite:(SKSpriteNode *)sprite;
- (DMTile *)tileBelow:(DMMovingSprite *)movingSprite;

- (void)hurt:(DMMovingSprite *)movingSprite;
- (void)died:(DMMovingSprite *)movingSprite;

@end
