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

@property (nonatomic, retain) DMTile *northTile;
@property (nonatomic, retain) DMTile *southTile;
@property (nonatomic, retain) DMTile *eastTile;
@property (nonatomic, retain) DMTile *westTile;

- (void)setRow:(int)row setColumn:(int)column;

- (BOOL)isImpassable;
- (BOOL)isDestructible;

@end
