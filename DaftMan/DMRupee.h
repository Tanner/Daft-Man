//
//  DMRupee.h
//  DaftMan
//
//  Created by Tanner Smith on 11/13/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMItem.h"

@interface DMRupee : DMItem

#define RUPEE_SCORE_VALUE 20

@property (nonatomic, assign) int value;

- (id)initWithValue:(int)aValue;

@end
