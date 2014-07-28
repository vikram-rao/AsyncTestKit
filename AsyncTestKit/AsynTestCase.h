//
//  AsynTestKit.h
//  AsynTestKit
//
//  Created by Vikram Rao on 28/07/14.
//  Copyright (c) 2014 Vikram Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface AsynTestCase : XCTestCase

-(void)wait:(int)timeOut;
-(void)done;

@end
