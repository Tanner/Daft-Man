//
//  DMHeart.m
//  DaftMan
//
//  Created by Tanner Smith on 11/13/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMHeart.h"

@implementation DMHeart

- (id)init {
    if (self = [super initWithImageNamed:@"heart.png"]) {
    }
    
    return self;
}

- (void)pickedUpBy:(DMMovingSprite *)movingSprite {
    if ([self.delegate heartPickedUpBy:movingSprite]) {
        [super pickedUpBy:movingSprite];
    }
}

@end
