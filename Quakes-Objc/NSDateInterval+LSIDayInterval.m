//
//  NSDateInterval+LSIDayInterval.m
//  Quakes-Objc
//
//  Created by Audrey Welch on 5/5/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "NSDateInterval+LSIDayInterval.h"


@implementation NSDateInterval (LSIDayInterval)

+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days {
    return [self lsi_dateIntervalByAddingDays:days toDate:[[NSDate alloc] init]];
}

+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date {
    
    // Depending on days passed in, we either need to make startDate our current date
    // or endDate our current date
    // forward and backward in time possibilities
    
    NSDate *startDate = nil;
    NSDate *endDate = nil;
    
    if (days >= 0) {
        // Add a positive number to current date
        // so start is going to be current date
        startDate = date;
        endDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:startDate options:0];
    } else {
        // End date is right now
        endDate = date;
        startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:endDate options:0];
    }
    
    return [[NSDateInterval alloc] initWithStartDate:startDate endDate:endDate];  
}

@end
