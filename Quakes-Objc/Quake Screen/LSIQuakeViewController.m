//
//  LSIQuakeViewController.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/20/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeViewController.h"
#import "LSIQuakeFetcher.h"

@interface LSIQuakeViewController ()

@property LSIQuakeFetcher *quakeFetcher;

@end

@implementation LSIQuakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.quakeFetcher = [[LSIQuakeFetcher alloc] init];
    
    [self.quakeFetcher fetchQuakesWithCompletion:^(NSArray * _Nullable quakes, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching quakes: %@", error);
            return;
        }
        
        NSLog(@"Quakes: %@", quakes);
    }];
}

@end
