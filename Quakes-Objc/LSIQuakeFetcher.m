//
//  LSIQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/20/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeFetcher.h"

static NSString *const baseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";


@implementation LSIQuakeFetcher

- (void)fetchQuakesInDateInterval:(NSDateInterval *)interval
                       completion:(LSIQuakeFetcherCompletion)completion {
    
    NSLog(@"fetching Quakes");
}

- (void)fetchQuakesWithCompletion:(LSIQuakeFetcherCompletion)completion {
    // Date math
    NSDate *endDate = [NSDate date];  // avoid: adding 60*60*24*28 seconds to go to tomorrow
    NSDate *startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:endDate options:0];
    
    NSDateInterval *interval = [[NSDateInterval alloc] initWithStartDate:startDate endDate:endDate];
    [self fetchQuakesInDateInterval:interval completion:completion];
}

@end
