//
//  DMTile.h
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DMTile : SKSpriteNode

@property (nonatomic, assign, readonly) int row;
@property (nonatomic, assign, readonly) int column;

- (void)setRow:(int)row setColumn:(int)column;

- (BOOL)isImpassable;
- (BOOL)isDestructible;

@end
