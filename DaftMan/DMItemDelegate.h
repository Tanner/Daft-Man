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

- (BOOL)rupeePickedUpBy:(DMMovingSprite *)movingSprite;
- (BOOL)starPickedUpBy:(DMMovingSprite *)movingSprite;
- (BOOL)heartPickedUpBy:(DMMovingSprite *)movingSprite;
- (BOOL)firePickedUpBy:(DMMovingSprite *)movingSprite;

@end
