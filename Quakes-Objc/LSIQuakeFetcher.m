//
//  LSIQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Paul Solt on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeFetcher.h"
#import "LSIErrors.h"
#import "LSIQuakeResults.h"
#import "LSIQuake.h"

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
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url
                                                           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (!data) { // if (data == nil) {
            NSError *dataError = errorWithMessage(@"Data is nil from API response", LSIDataNilError);
            completion(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) { // if jsonError is no longer nil, then we have a problem!
            completion(nil, jsonError);
            return;
        }
        
        // Decode the JSON using our model objects
        LSIQuakeResults *quakeResults = [[LSIQuakeResults alloc] initWithDictionary:json];
        completion(quakeResults.quakes, nil);
    }];
    [task resume];
}

@end
