//
//  LSIQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Paul Solt on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeFetcher.h"

static NSString *baseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";

@implementation LSIQuakeFetcher

- (void)fetchQuakesWithCompletionBlock:(LSIQuakeFetcherCompletion)completion {
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:endDate options:0];
    
    NSDateInterval *dateInterval = [[NSDateInterval alloc] initWithStartDate:startDate endDate:endDate];
    
    [self fetchQuakesInTimeInterval:dateInterval completionBlock:completion];
}

- (void)fetchQuakesInTimeInterval:(NSDateInterval *)timeInterval
                  completionBlock:(LSIQuakeFetcherCompletion)completion {
    
    // https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:baseURLString];
    
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSString *startDateString = [formatter stringFromDate:timeInterval.startDate];
    NSString *endDateString = [formatter stringFromDate:timeInterval.endDate];
    
    urlComponents.queryItems = @[
      [NSURLQueryItem queryItemWithName:@"format" value:@"geojson"],
      [NSURLQueryItem queryItemWithName:@"starttime" value:startDateString],
      [NSURLQueryItem queryItemWithName:@"endtime" value:endDateString]
    ];
    
    NSURL *url = urlComponents.URL;
    NSLog(@"url: %@", url);
}

@end
