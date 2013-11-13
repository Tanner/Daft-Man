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
        self.name = @"brick";
        
        [self setSize:CGSizeMake(32, 32)];
    }
    
    return self;
}

- (id)initWithPrize:(SKSpriteNode *)aPrize {
    if (self = [self init]) {
        prize = aPrize;
    }
    
    return self;
}

- (BOOL)isImpassable {
    return YES;
}

- (BOOL)isDestructible {
    return YES;
}

@end
