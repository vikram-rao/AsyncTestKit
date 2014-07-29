//
//  AsynTestKit.m
//  AsynTestKit
//
//  Created by Vikram Rao on 28/07/14.
//  Copyright (c) 2014 Vikram Rao. All rights reserved.
//

#import "AsyncTestCase.h"
#import <XCTest/XCTest.h>

@interface AsyncTestCase ()

@property (nonatomic) BOOL completed;

@end

@implementation AsyncTestCase

-(void)wait:(int)timeOut
{
    int elapsedTime = 0;
    
    while (self.completed == NO && elapsedTime <= 4) {
        NSDate* untilDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
        [[NSRunLoop currentRunLoop] runUntilDate:untilDate];
        elapsedTime++;
    }
    
    if (elapsedTime == timeOut) {
        XCTFail(@"Timeout");
    }
}

-(void)done
{
    self.completed = YES;
}

@end
