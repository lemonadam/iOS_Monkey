//
//  MonkeyRunner.m
//  MonkeyRunner
//
//  Created by ws on 02/03/2017.
//
//xcodebuild test -scheme 'MonkeyRunner' -destination "platform=iOS,id=3d4e6c08281b295628dbaa8530d62a17833498a3" -resultBundlePath "/Users/wangshuai/work/git/ios_monkey_lemon/report/3d4e6c08281b295628dbaa8530d62a17833498a3"


#import <XCTest/XCTest.h>
#import "Monkey.h"
#import "Monkey+XCUITestPrivate.h"
#import "Monkey+XCUITest.h"

@interface MonkeyRunner : XCTestCase

@end

@implementation MonkeyRunner

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testRunner {
    
    NSString *iestools= @"com.ss.iphone.xxxx";
    NSString *aweme = @"com.ss.iphone.xxxx";
    NSString *testApp = @"com.blueshadow.OCMonkeyExample";
    Monkey *monkey = [[Monkey alloc] initWithBundleID:testApp];
    [monkey addDefaultXCTestPrivateActions];
    [monkey addXCTestTapAlertAction:100];
    sleep(5);
    [monkey run_init];
    [monkey run_callback];
    [monkey run:200];
    [monkey run_end];
    
    

}
- (void)DIStestRunner_second {
    NSString *iestools= @"com.ss.ixxxxuse";
    NSString *aweme = @"com.ss.ipxxxxouse";
    NSString *testApp = @"com.blueshadow.OCMonkeyExample";
    Monkey *monkey = [[Monkey alloc] initWithBundleID:aweme];
    [monkey addDefaultXCTestPrivateActions];
    [monkey addXCTestTapAlertAction:100];
    [monkey run_init];
    [monkey run_callback];
//    [monkey tapAtTouchLocationsdivCGFloatx:200 divCGFloaty:300 numberOfTaps:1];
//    [monkey tapAtTouchLocationsdivCGFloatx:100 divCGFloaty:300 numberOfTaps:5];
    [monkey pressAtTouchLocationsdivCGFloatx:200 divCGFloaty:300  forDuration:4];
    [monkey pressAtTouchLocationsdivCGFloatx:200 divCGFloaty:200  forDuration:3];
    [monkey dragCGFloatx1:100 divCGFloaty1:100 divCGFloatx2:200 divCGFloaty2:300 forDuration:2];

}






@end
