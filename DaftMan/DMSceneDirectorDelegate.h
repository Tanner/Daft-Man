//
//  DMSceneDirectorDelegate.h
//  DaftMan
//
//  Created by Tanner Smith on 12/10/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMSceneDirectorDelegate <NSObject>

- (void)levelCompleteForlevel:(int)level score:(int)score time:(NSTimeInterval)time won:(BOOL)won;

@end
