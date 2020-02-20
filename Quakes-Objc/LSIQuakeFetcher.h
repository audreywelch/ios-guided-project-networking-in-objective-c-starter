//
//  LSIQuakeFetcher.h
//  Quakes-Objc
//
//  Created by Paul Solt on 2/20/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// Declare outside NONNULL area because the array or error can be null
typedef void (^LSIQuakeFetcherCompletion)(NSArray * _Nullable quakes, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface LSIQuakeFetcher : NSObject

- (void)fetchQuakesInTimeInterval:(NSTimeInterval)interval
                       completion:(LSIQuakeFetcherCompletion)completion;


@end

NS_ASSUME_NONNULL_END
