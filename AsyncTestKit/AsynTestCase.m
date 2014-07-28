//
//  AsynTestKit.m
//  AsynTestKit
//
//  Created by Vikram Rao on 28/07/14.
//  Copyright (c) 2014 Vikram Rao. All rights reserved.
//

#import "AsynTestCase.h"
#import <XCTest/XCTest.h>

@interface AsynTestCase ()

@property (nonatomic) BOOL completed;

@end

@implementation AsynTestCase

-(void)wait:(int)timeOut
{
    int pollCount = 0;
    
    while (self.completed == NO && pollCount <= 4) {
        NSLog(@"polling... %i", pollCount);
        NSDate* untilDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
        [[NSRunLoop currentRunLoop] runUntilDate:untilDate];
        pollCount++;
    }
    
    if (pollCount == timeOut) {
        XCTFail(@"Timeout");
    }
}

-(void)done
{
    self.completed = YES;
}

@end
