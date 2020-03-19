//
//  LSIQuake+NSJSONSerialization.m
//  Quakes-Objc
//
//  Created by Paul Solt on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuake+NSJSONSerialization.h"

@implementation LSIQuake (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSDictionary *properties = dictionary[@"properties"];
    
    // All Objective-C collections must store objects (int, long, float are wrapped in NSNumber)
    NSNumber *magnitudeNumber = properties[@"mag"];
    
    NSString *place = properties[@"place"];
    
    // How to parse time as a date?
    // NSNumber
    NSNumber *timeNumber = properties[@"time"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue / 1000.0];
    
    NSDictionary *geometry = dictionary[@"geometry"];
    NSArray *coordinates = geometry[@"coordinates"];
    
    NSNumber *latitudeNumber = nil;
    NSNumber *longitudeNumber = nil;
    
    if (coordinates.count >= 2) {
        longitudeNumber = coordinates[0];
        latitudeNumber = coordinates[1]; // longitude is before latitude in array
    }
    
    // check if required properties are non-nil, otherwise return nil
    
    // API Decision: Discard any null magnitudes, but print it out for investigation
    if ([magnitudeNumber isKindOfClass:[NSNull class]]) {
        magnitudeNumber = nil;
        NSLog(@"Mag is null: %@", dictionary);
    }
    
    // magnitude is optional
    if (!(place || timeNumber || latitudeNumber || longitudeNumber)) {
        return nil;  // failable init if missing required
    }
    
    // return the object using the default init
    self = [self initWithMagnitude:magnitudeNumber
                             place:place
                              time:time
                          latitude:latitudeNumber.doubleValue
                         longitude:longitudeNumber.doubleValue];
    
    return self;
    
}

@end
