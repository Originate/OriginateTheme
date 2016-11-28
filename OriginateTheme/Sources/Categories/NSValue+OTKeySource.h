//
//  NSValue+OTKeySource.h
//  OriginateTheme
//
//  Created by Danny Chhay on 11/28/16.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValue (OTKeySource)

#pragma mark - Methods
+ (NSValue *)valueForKeyPath:(NSString *)keyPath source:(NSDictionary *)definition fallback:(NSValue *)fallback;

@end
