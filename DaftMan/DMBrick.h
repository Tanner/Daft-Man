//
//  DMBrick.h
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMTile.h"

@interface DMBrick : DMTile

typedef enum prizeTypes {
    RUPEE,
    STAR
} PrizeType;

@property (nonatomic, retain) SKSpriteNode *prize;

- (id)initWithPrize:(SKSpriteNode *)aPrize;
- (id)initWithRandomPrize;

- (void)destroy;

@end
