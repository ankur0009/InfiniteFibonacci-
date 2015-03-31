//
//  GlobalFibonacciGenerator.m
//  InfiniteFibonacci
//
//  Created by Ankur Gupta on 3/9/15.
//  Copyright (c) 2015 Ankur Gupta. All rights reserved.
//

#import "GlobalFibonacciGenerator.h"
#import "JKBigInteger.h"


JKBigInteger *currentFib; //Current fib number
JKBigInteger *nextFib; //Next fib number
JKBigInteger* placeholderFib; //Used to move to next fib number

@implementation GlobalFibonacciGenerator

// Returns singleton instance
// The generator is global  
+ (GlobalFibonacciGenerator*)sharedGenerator
{
    static GlobalFibonacciGenerator *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[GlobalFibonacciGenerator alloc] init];
        //Initialize the fibonacci numbers and placeholder object used
        //for generating the next number
        currentFib = [[JKBigInteger alloc] initWithString:@"0"];
        nextFib = [[JKBigInteger alloc] initWithString:@"1"];
        placeholderFib = [JKBigInteger alloc];
        
    });
    return _sharedInstance;
}

//Return the current fibonaacci number and update the fibonacci sequence
- (NSString *)nextFibonacciNumber{
    placeholderFib = [placeholderFib initWithString:[currentFib stringValue]];
    currentFib = [currentFib initWithString:[nextFib stringValue]];
    nextFib = [placeholderFib add:currentFib];
    return [placeholderFib stringValue];
}




@end
