//
//  LSIQuakeViewController.m
//  Quakes-Objc
//
//  Created by Audrey Welch on 5/5/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeViewController.h"
#import "LSIQuakeFetcher.h"
#import "NSDateInterval+LSIDayInterval.h"

// Class Extension (anonymous category) - anonymous because it has no value inside of it
@interface LSIQuakeViewController ()

// Private property
@property (nonatomic) LSIQuakeFetcher *quakeFetcher;

@end

@implementation LSIQuakeViewController

// Lazy property initialization
- (LSIQuakeFetcher *)quakeFetcher {
    if (!_quakeFetcher) {
        _quakeFetcher = [[LSIQuakeFetcher alloc] init];
    }
    return _quakeFetcher;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateInterval *interval = [NSDateInterval lsi_dateIntervalByAddingDays:-1];
    
    [self.quakeFetcher fetchQuakesInTimeInterval:interval completionBlock:^(NSArray<LSIQuake *> * _Nullable quakes, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching quakes: %@", error);
            return;
        }
        
        // Otherwise, we have a list of quakes
        NSLog(@"Quakes: %ld", quakes.count);
    }];
}


@end
