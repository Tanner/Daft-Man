//
//  DMItem.h
//  DaftMan
//
//  Created by Tanner Smith on 11/13/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMMovingSprite.h"

@interface DMItem : SKSpriteNode

- (void)pickedUpBy:(DMMovingSprite *)movingSprite;

@end
