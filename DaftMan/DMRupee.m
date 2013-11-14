//
//  DMRupee.m
//  DaftMan
//
//  Created by Tanner Smith on 11/13/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMRupee.h"

@implementation DMRupee

#define DEFAULT_VALUE 20

@synthesize value;

- (id)initWithValue:(int)aValue {
    if (self = [super initWithImageNamed:@"rupee-yellow.png"]) {
        value = aValue;
    }
    
    return self;
}

- (id)init {
    if (self = [self initWithValue:DEFAULT_VALUE]) {
    }
    
    return self;
}

- (void)pickedUpBy:(DMMovingSprite *)movingSprite {
    [super pickedUpBy:movingSprite];
    [self.delegate rupeePickedUpBy:movingSprite];
}

@end
