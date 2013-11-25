//
//  DMBrick.h
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMTile.h"

#import "DMItem.h"

@interface DMBrick : DMTile

@property (nonatomic, retain) DMItem *item;

- (id)initWithItem:(DMItem *)anItem;
- (id)initWithRupee;
- (id)initWithRandomItem;

- (void)destroy;

@end
