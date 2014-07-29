AsyncTestKit
============

XCTest framework tests have no api to wait for asynchronous calls to complete and thus giving no chance for asserts after the asynchronous calls are done. This is important in an integration or system test involving network calls or multi-threaded invocations. 

Using AsyncTestKit, perform asynchronous calls in tests without terminating the tests and performing asserts in the asynchronous callbacks. Finally send a signal to end the wait. The wait for async call takes a timeout in seconds so the wait is not indefinite and test fails on timeout.

Example:(Check the tests in the source for more examples)

```
//Import AsyncTestKit
#import <AsyncTestKit/AsyncTestKit.h>

//Inherit from AsyncTestCase class instead of XCTestCase
@interface MyAsyncTests : AsyncTestCase

@end

@implementation MyAsyncTests

- (void) testAsyncCall
{
    id sut;
    [sut performAsyncCall:^{
        [self done]; //Signal that test can terminate
    }]
    
    [self wait:4]; //Wait for 4 seconds. Fails if [self done] is not called on or before 4 seconds.
}

@end
```

