//
//  DMBrick.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMBrick.h"

@implementation DMBrick

@synthesize prize;

- (id)init {
    // TODO: Brick.png is only 30x30
    if (self = [super initWithImageNamed:@"brick.png"]) {
        [self setSize:CGSizeMake(32, 32)];
    }
    
    return self;
}

- (id)initWithPrize:(DMPrize *)aPrize {
    if (self = [self init]) {
        prize = aPrize;
    }
    
    return self;
}

- (BOOL)isDestructible {
    return YES;
}

@end
