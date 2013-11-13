//
//  DMItem.m
//  DaftMan
//
//  Created by Tanner Smith on 11/13/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMItem.h"

#import "DMMovingSprite.h"

@implementation DMItem

- (void)pickedUpBy:(DMMovingSprite *)movingSprite {
    [self removeFromParent];
}

@end
