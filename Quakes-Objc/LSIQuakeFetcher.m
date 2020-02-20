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

- (void)fetchQuakesInTimeInterval:(NSTimeInterval)interval
                       completion:(LSIQuakeFetcherCompletion)completion {
    
    NSLog(@"fetching Quakes");
    
    
    
}

@end
