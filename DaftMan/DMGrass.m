//
//  DMGrass.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMGrass.h"

@implementation DMGrass

@synthesize red, green, blue, yellow;

- (id)init {
    green = [NSColor colorWithRed:0.21 green:0.78 blue:0.21 alpha:1.0];
    
    if (self = [super initWithColor:green size:CGSizeMake(32, 32)]) {
    
    }
    
    return self;
}

@end
