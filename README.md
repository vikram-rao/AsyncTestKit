AsyncTestKit
============

Perform asynchronous calls in tests without terminating the tests and performing asserts in the asynchronous callbacks. Finally send a signal to end the wait. The wait for async calls also takes a timeout in seconds so the wait is not indefinite.

Example:

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
    
    [self wait:4]; //Wait 4 seconds
}

@end
```

