//
//  NSDateInterval+LSIDayInterval.m
//  Quakes-Objc
//
//  Created by Paul Solt on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "NSDateInterval+LSIDayInterval.h"

@implementation NSDateInterval (LSIDayInterval)

+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days {
    return [self lsi_dateIntervalByAddingDays:days toDate:[[NSDate alloc] init]];
}

+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date {
    return nil;
}


@end
