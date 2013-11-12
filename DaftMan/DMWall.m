//
//  DMWall.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMWall.h"

@implementation DMWall

- (id)init {
    if (self = [super initWithImageNamed:@"wall.png"]) {
        [self setSize:CGSizeMake(32, 32)];
    }
    
    return self;
}

- (BOOL)isImpassable {
    return YES;
}

@end
