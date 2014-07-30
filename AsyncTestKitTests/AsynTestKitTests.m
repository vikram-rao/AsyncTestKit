//
//  AsynTestKitTests.m
//  AsynTestKitTests
//
//  Created by Vikram Rao on 28/07/14.
//  Copyright (c) 2014 Vikram Rao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AsyncTestCase.h"

@interface AsynTestKitTests : AsyncTestCase

@end

@implementation AsynTestKitTests

- (void) testWhenMakingNetworkRequest
{
    NSURL *url = [NSURL URLWithString:@"http://www.vikramrao.in"];
    NSURLRequest *networkRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:networkRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        XCTAssertNil(connectionError, @"Error occured - %@", connectionError);
        [self done]; //Signal that test can terminate
    }];
    
    [self wait:4]; //Wait for 4 seconds. Fails if [self done] is not called on or before 4 seconds.
}

- (void)testWhenUsingGCD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self done];
    });
    
    [self wait:2];
}

- (void)testWhenUsingNSTimer
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:NO];
    [self wait:2];
}

- (void)testWhenHavingToRunTwoTimedOperations
{
    __block int asynCount = 0;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        asynCount++;
        [self done];
    });
    
    [self wait:2];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        asynCount++;
        [self done];
    });
    
    [self wait:2];
    
    XCTAssertEqual(asynCount, 2, @"Two async waits did not happen");
}

- (void)timerRun
{
    [self done];
}

@end
