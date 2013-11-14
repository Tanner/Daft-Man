//
//  DMItem.h
//  DaftMan
//
//  Created by Tanner Smith on 11/13/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMMovingSprite.h"
#import "DMItemDelegate.h"

@interface DMItem : SKSpriteNode

typedef enum itemTypes {
    RUPEE,
    STAR,
    HEART
} ItemType;

@property (nonatomic, assign) id <DMItemDelegate> delegate;

- (void)pickedUpBy:(DMMovingSprite *)movingSprite;

@end
