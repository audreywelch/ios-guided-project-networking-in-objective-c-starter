//
//  LSIQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Audrey Welch on 5/5/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeFetcher.h"
#import "LSIQuake.h"
#import "LSIQuakeResults.h"
#import "LSIErrors.h"
#import "LSILog.h"

static NSString *baseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";

@implementation LSIQuakeFetcher

// Overriding the default NSObject initializer (we don't need to redeclare in the .h file)
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)fetchQuakesInTimeInterval:(NSDateInterval *)interval
                  completionBlock:(LSIQuakeFetcherCompletionBlock)completionBlock {
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:baseURLString];
    
    // Add URL components
    // This is what we're building:
    // https://earthquake.usgs.gove/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02
    
    // Need to create a date formatter
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    
    // Strings to pass in as query parameters
    NSString *startTimeString = [formatter stringFromDate:interval.startDate];
    NSString *endTimeString = [formatter stringFromDate:interval.endDate];
    
    // Create URL componenet query items
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"starttime" value:startTimeString],
        [NSURLQueryItem queryItemWithName:@"endtime" value:endTimeString],
        [NSURLQueryItem queryItemWithName:@"format" value:@"geojson"]
    ];
    
    // NSURLSession task
    NSURL *url = urlComponents.URL; // FIXME: Add error handling if value is nil
    
    // Create data task
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Sanity check is to move this print statement to be inside the data task
        // that lets us know we did actually invoke the data task
        NSLog(@"url: %@", url);
        
        // Errors
        if (error) {
            completionBlock(nil, error);
            return;
        }
        
        if (!data) {
            // No error was given, but also no data
            // So we need to create our own error here
            // In this case we customized a way to make this easier with our LSIErrors.h/.m
            NSError *dataError = errorWithMessage(@"No data in URL response for quakes", LSIDataNilError);
            completionBlock(nil, dataError);
            return;
        }
        
        // Data parsing
        
        // We use NSError instead of do-catch blocks in objc
        // Give the message the error and the address of the error
        // & = address of
        NSError *jsonError = nil; // nil = no error
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        // Future: You may need to check kindOfClass if it's not what we expect!
        
        if (jsonError) {
            completionBlock(nil, jsonError);
            return;
        }
        
        // Decode using our initializers
        LSIQuakeResults *quakeResults = [[LSIQuakeResults alloc] initWithDictionary:json];
        
        // FIXME: check for non-nil results
        
        completionBlock(quakeResults.quakes, nil);
        
        // Call completion handlers

    }];
    
    [task resume];
    
}

@end
