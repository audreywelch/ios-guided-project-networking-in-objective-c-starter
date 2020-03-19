//
//  LSIQuakeViewController.m
//  Quakes-Objc
//
//  Created by Paul Solt on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeViewController.h"
#import "LSIQuakeFetcher.h"
#import "LSIQuake.h"

@interface LSIQuakeViewController ()

@property (nonatomic) LSIQuakeFetcher *quakeFetcher;

@end

@implementation LSIQuakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.quakeFetcher = [[LSIQuakeFetcher alloc] init];

    [self.quakeFetcher fetchQuakesWithCompletionBlock:^(NSArray<LSIQuake *> * _Nullable quakes, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching quakes: %@", error); // FIXME: Update UI based on errors
            return;
        }
        NSLog(@"Quakes: %ld", quakes.count);
    }];
}

@end
