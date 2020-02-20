//
//  LSIQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/20/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeFetcher.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "LSIQuake.h"
#import "LSIQuakeResults.h"

static NSString *const baseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";


@implementation LSIQuakeFetcher

- (void)fetchQuakesInDateInterval:(NSDateInterval *)interval
                       completion:(LSIQuakeFetcherCompletion)completion {
    
    NSLog(@"fetching Quakes");
    // https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseURLString];
    
    NSISO8601DateFormatter *dateFormatter = [[NSISO8601DateFormatter alloc] init];
    NSString *startTimeString = [dateFormatter stringFromDate:interval.startDate];
    NSString *endTimeString = [dateFormatter stringFromDate:interval.endDate];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"format" value:@"geojson"],
        [NSURLQueryItem queryItemWithName:@"starttime" value:startTimeString],
        [NSURLQueryItem queryItemWithName:@"endtime" value:endTimeString],
    ];
    
    NSURL *url = urlComponents.URL;
    NSLog(@"URL: %@", url);
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Test");
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data should not be nil from API request", LSIDataNilError);
            completion(nil, dataError);
            return;
        }
        
        // How can I use the LSIQuake and LSIQuakeResults here?
        NSError *jsonError = nil;
        
        // &jsonError = "address of" jsonError
        // memory address = house/apt address
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        // Determine if QuakeResults can be created
        // NSLog(@"JSON: %@", json);
        LSIQuakeResults *quakeResults = [[LSIQuakeResults alloc] initWithDictionary:json];
        
        if (!quakeResults) {
            NSString *errorMessage = [NSString stringWithFormat:@"Unable to parse JSON object, %@", json];
            NSError *parsingError = errorWithMessage(errorMessage, LSIJSONDecodeError);
            completion(nil, parsingError);
            return;
        }
        
        // How do I call my completion handler with the array of quakes?
        completion(quakeResults.quakes, nil);
        
        
    }] resume];
}

- (void)fetchQuakesWithCompletion:(LSIQuakeFetcherCompletion)completion {
    // Date math
    NSDate *endDate = [NSDate date];  // avoid: adding 60*60*24*28 seconds to go to tomorrow
    NSDate *startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:endDate options:0];
    
    NSDateInterval *interval = [[NSDateInterval alloc] initWithStartDate:startDate endDate:endDate];
    [self fetchQuakesInDateInterval:interval completion:completion];
}

@end
