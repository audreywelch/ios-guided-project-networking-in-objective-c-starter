//
//  LSIQuake.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuake.h"

@implementation LSIQuake

// Control + I = reindent
- (instancetype)initWithMagnitude:(NSNumber *)magnitude
                            place:(NSString *)place
                             time:(NSDate *)time
                         latitude:(double)latitude
                        longitude:(double)longitude {
    self = [super init];
    if (self) {
        _magnitude = magnitude;
        _place = [place copy];
        _time = time;
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

@end
