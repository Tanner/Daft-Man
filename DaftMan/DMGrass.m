//
//  DMGrass.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMGrass.h"

#import "DMDaftColor.h"

@implementation DMGrass

- (id)init {
    
    if (self = [super initWithColor:[NSColor blackColor] size:CGSizeMake(32, 32)]) {
        self.name = @"grass";
        
        [self runAction:[DMDaftColor action]];
    }
    
    return self;
}

@end
