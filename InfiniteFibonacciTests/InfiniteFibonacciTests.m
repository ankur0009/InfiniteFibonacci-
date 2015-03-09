//
//  InfiniteFibonacciTests.m
//  InfiniteFibonacciTests
//
//  Created by Ankur Gupta on 3/9/15.
//  Copyright (c) 2015 Ankur Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GlobalFibonacciGenerator.h"

@interface InfiniteFibonacciTests : XCTestCase

@end

@implementation InfiniteFibonacciTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//Check if correct fibonacci numbers are generated
-(void) testFibonacciGenerator{
    //Generate some initial number
    [[GlobalFibonacciGenerator sharedGenerator] nextFibonacciNumber];
    [[GlobalFibonacciGenerator sharedGenerator] nextFibonacciNumber];
    [[GlobalFibonacciGenerator sharedGenerator] nextFibonacciNumber];
    [[GlobalFibonacciGenerator sharedGenerator] nextFibonacciNumber];
    [[GlobalFibonacciGenerator sharedGenerator] nextFibonacciNumber];
    
    //check if sixth fibonacci number is equal to 5
    XCTAssertEqualObjects([[GlobalFibonacciGenerator sharedGenerator] nextFibonacciNumber], @"5", @"Fibonacci generator failed.");
}


- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
