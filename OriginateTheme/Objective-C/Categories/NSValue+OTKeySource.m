//
//  NSValue+OTKeySource.m
//  OriginateTheme
//
//  Created by Danny Chhay on 2016-11-28.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "NSValue+OTKeySource.h"

@implementation NSValue (OTKeySource)

#pragma mark - UIFont (OTKeySource)

+ (NSValue *)valueForKeyPath:(NSString *)keyPath source:(NSDictionary *)definition fallback:(NSValue *)fallback
{
    return [definition valueForKeyPath:keyPath] ?: fallback;
}

@end
