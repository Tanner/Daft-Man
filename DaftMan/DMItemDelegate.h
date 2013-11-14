//
//  DMItemDelegate.h
//  DaftMan
//
//  Created by Tanner Smith on 11/14/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DMMovingSprite.h"

@protocol DMItemDelegate <NSObject>

- (void)rupeePickedUpBy:(DMMovingSprite *)movingSprite;
- (void)starPickedUpBy:(DMMovingSprite *)movingSprite;
- (void)heartPickedUpBy:(DMMovingSprite *)movingSprite;

@end
