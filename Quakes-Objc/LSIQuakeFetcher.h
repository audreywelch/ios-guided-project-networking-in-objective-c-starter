//
//  LSIQuakeFetcher.h
//  Quakes-Objc
//
//  Created by Audrey Welch on 5/5/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIQuake;

// typealias in Swift
// declare a named type for our completion handler
typedef void (^LSIQuakeFetcherCompletionBlock)(NSArray<LSIQuake *> * _Nullable quakes, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface LSIQuakeFetcher : NSObject

// We are going to use the default initializer, so don't need to restate that here

// I want to return:
// Array of LSIQuakes, NSError

//- (void)fetchQuakesInTimeInterval:(NSDateInterval *)interval
//                  completionBlock:(void (^)(NSArray<LSIQuake *> *quakes, NSError *error))completionBlock;

- (void)fetchQuakesInTimeInterval:(NSDateInterval *)interval
                  completionBlock:(LSIQuakeFetcherCompletionBlock)completionBlock;


@end

NS_ASSUME_NONNULL_END
