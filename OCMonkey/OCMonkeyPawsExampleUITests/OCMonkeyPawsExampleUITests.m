//
//  OCMonkeyPawsExampleUITests.m
//  OCMonkeyPawsExampleUITests
//
//  Created by wangshuai on 2017/5/22.
//
//

#import <XCTest/XCTest.h>

@interface OCMonkeyPawsExampleUITests : XCTestCase

@end

@implementation OCMonkeyPawsExampleUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[XCUIDevice sharedDevice]pressButton:XCUIDeviceButtonHome];
    sleep(1);
//    [[XCUIDevice sharedDevice]pressButton:XCUIDeviceButtonHome];
    sleep(3);
    
//    XCUIElementQuery *elementsQuery = app.scrollViews.otherElements;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    [[[XCUIApplication alloc] init].scrollViews.otherElements.icons[@"OCMonkeyPawsExample"] tap];
//    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
//    [elementsQuery.icons[@"抖音短视频内测"] tap];
    sleep(1);
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
//    XCUIApplication *app = app2;
    [[app.otherElements containingType:XCUIElementTypeButton identifier:@"+"].element tap];
    
    
    
    
    
}

@end
