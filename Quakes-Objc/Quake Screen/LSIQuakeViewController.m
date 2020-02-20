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
    
}


@end
