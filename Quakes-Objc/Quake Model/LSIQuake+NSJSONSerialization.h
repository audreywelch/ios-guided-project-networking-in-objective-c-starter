//
//  LSIQuake+NSJSONSerialization.h
//  Quakes-Objc
//
//  Created by Paul Solt on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuake.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIQuake (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
