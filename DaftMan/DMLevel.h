//
//  DMLevel.h
//  DaftMan
//
//  Created by Tanner Smith on 11/14/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DMMovingSpriteDelegate.h"
#import "DMItemDelegate.h"

@interface DMLevel : SKNode <DMMovingSpriteDelegate, DMItemDelegate>

@property (nonatomic, assign) BOOL bombPlaced;

- (id)init;
- (id)initNumberOfFoes:(int)foeCount numberOfRupies:(int)rupeeCount;

- (void)update:(NSTimeInterval)currentTime;

@end
