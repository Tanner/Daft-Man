//
//  DMStar.m
//  DaftMan
//
//  Created by Tanner Smith on 11/13/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMStar.h"

@implementation DMStar

- (id)init {
    if (self = [super initWithImageNamed:@"star.png"]) {
    }
    
    return self;
}

- (void)pickedUpBy:(DMMovingSprite *)movingSprite {
    if ([self.delegate starPickedUpBy:movingSprite]) {
        [super pickedUpBy:movingSprite];
    }
}

@end
