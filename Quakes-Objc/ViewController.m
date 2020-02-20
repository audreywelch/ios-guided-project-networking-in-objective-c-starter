//
//  ViewController.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSILog.h"
#import "LSIFirstResponder.h"

// Swift
//typealias WeatherCompletion = (Bool, Error) -> Void

// typedef returnType (^TypeName)(parameterTypes);
typedef void (^WeatherCompletion)(int temperature);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Hey Quakes!");
    
    // How do I create a first responder object?
    LSIFirstResponder *responder = [[LSIFirstResponder alloc] init];

    NSLog(@"responder: %@", responder);
    NSLog(@"name: %@", responder.name);
    
    // Objects will be nil / null
    // int / float / double / bool will be 0 (NO)
    
    responder.name = @"John";
    NSLog(@"name: %@", responder.name);
    
    
    // Blocks

    // Swift
    //    let addNumbers = { (a: Int, b: Int) -> Int in {
    //        a + b
    //    }
    //    addNumbers(6, 3)

    // returnType (^blockName)(parameterTypes) = ^returnType(parameters) {
    //
    //};
    int (^addNumbers)(int a, int b) = ^int(int a, int b) {
        return a + b;
    };



    int result = addNumbers(5, 6);  // completion(nil, error);
    NSLog(@"The sum is: %d", result);
    
    [self doWorkAndCallCompletion:^(int temperature) {
        NSLog(@"finished the work, now updating the UI with %dºF", temperature);
    }];
    
    [self doWorkAndCallCompletion:^(int temperature) {
        
    }];
    
}

//- (void)doWorkAndCallCompletion:(void (^)(int temperature))completion {
- (void)doWorkAndCallCompletion:(WeatherCompletion)completion {
    
    NSLog(@"Doing work ...");
    
    completion(27);
}


@end
