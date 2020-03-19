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

    // Swift
    //    let addNumbers = { (a: Int, b: Int) -> Int in
    //        a + b
    //    }
    //    print(addNumbers(a: 4, b: 9))

    // Objective-C
    // returnType (^blockName)(parameterTypes) = ^returnType(parameters) {
    //
    // };
    // blockName()
    
    // Block in Objective-C (anonymous function, similar to a Closure in Swift)
    int (^addNumbers)(int a, int b) = ^int(int a, int b) {
        return a + b;
    };

    int result = addNumbers(15, 27);
    NSLog(@"Result: %d", result);
    
    [self doWorkAndCallCompletionHandler:^(int temperature) {
       // Update the UI (main thread)
        
        // Option + 0 = º
        NSLog(@"The temperature is %dºF", temperature);
    }];
}

// - (returnType)methodName:(returnType (^)(parameterTypes))completionName {
- (void)doWorkAndCallCompletionHandler:(void (^)(int temperature))completion {
    // API Call to get temperature ...
    NSLog(@"Getting temperature from API %%");
    
    completion(66);
}

//- (void)compare:(BOOL (^)(int a, int b))completion {
//    // API Call to get temperature ...
//    NSLog(@"Getting temperature from API %%");
//
//    if (completion(27, 42)) {
//        NSLog(@"comparing values");
//    }
//}


@end
