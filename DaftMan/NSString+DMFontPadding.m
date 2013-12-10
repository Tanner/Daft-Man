//
//  NSString+DMFontPadding.m
//  DaftMan
//
//  Created by Tanner Smith on 12/10/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "NSString+DMFontPadding.h"

@implementation NSString (DMFontPadding)

NSString * const template = @"   ";

+ (NSString *)stringByPaddingString:(NSString *)string {
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@" " options:NSRegularExpressionCaseInsensitive error:&error];
    
    return [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:template];
}

@end
