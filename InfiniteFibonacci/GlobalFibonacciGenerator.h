//
//  GlobalFibonacciGenerator.h
//  InfiniteFibonacci
//
//  Created by Ankur Gupta on 3/9/15.
//  Copyright (c) 2015 Ankur Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalFibonacciGenerator : NSObject

+ (GlobalFibonacciGenerator*)sharedGenerator;
- (NSString *)nextFibonacciNumber;


@end
