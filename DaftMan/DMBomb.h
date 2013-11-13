//
//  DMBomb.h
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DMBomb : SKSpriteNode

- (id)initWithBoom:(void (^)(DMBomb *bomb))block;

@end
