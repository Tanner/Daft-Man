//
//  DMFoe.m
//  DaftMan
//
//  Created by Tanner Smith on 11/26/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMFoe.h"

@implementation DMFoe

- (id)init {
    if (self = [super initWithHealth:3 atlasName:@"foe"]) {
        self.name = @"foe";
    }
    
    return self;
}

@end
