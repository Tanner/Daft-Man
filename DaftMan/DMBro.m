//
//  DMBro.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMBro.h"

@implementation DMBro

- (id)init {    
    if (self = [super initWithHealth:3 atlasName:@"bro"]) {
        self.name = @"bro";
    }
    
    return self;
}

- (BOOL)hurt {
    if ([super hurt]) {
        [self runAction:[SKAction playSoundFileNamed:@"hurt.wav" waitForCompletion:NO]];
        
        return YES;
    }
    
    return NO;
}

@end
