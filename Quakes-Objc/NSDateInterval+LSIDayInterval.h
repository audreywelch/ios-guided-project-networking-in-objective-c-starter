//
//  NSDateInterval+LSIDayInterval.h
//  Quakes-Objc
//
//  Created by Audrey Welch on 5/5/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Category (like a Swift Extension)
@interface NSDateInterval (LSIDayInterval)

// Convenience methods

// + = class method
// [NSDateInterval ourMethodName]; // how to invoke
// [NSDateInterval dateIntervalByAddingDays: -7]; // range from past week

// When we don't own the source code, we need to make our method names unique
// Apple controls the implementation of NSDateInterval, so if we both implement the same method,
// the objc runtime has a 50/50 chance of calling the wrong version which would behave differently (crash!)
// so add our lowercase 3-letter prefix with an underscore when creating a category on an object we don't own

// Uses the current date as the end interval
+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days;
+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
