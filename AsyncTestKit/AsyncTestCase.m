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

-(void)resetWait
{
    self.completed = NO;    
}

-(void)wait:(int)timeOut
{
    while (self.completed == NO && timeOut > 0) {
        NSLog(@"Waiting %d seconds", timeOut);
        NSDate* untilDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
        [[NSRunLoop currentRunLoop] runUntilDate:untilDate];
        timeOut--;
    }
    
    if (timeOut == 0) {
        XCTFail(@"Timeout");
    }
    
    [self resetWait];
}

-(void)done
{
    self.completed = YES;
}

@end
