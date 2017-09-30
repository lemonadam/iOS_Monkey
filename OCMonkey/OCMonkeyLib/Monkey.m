//
//  Monkey.m
//  OCMonkey
//
//  Created by gogleyin on 02/03/2017.
//
//

#import "Monkey.h"
#import "XCUIApplication.h"
#import "XCUIElement.h"
#import "XCUIApplication+Monkey.h"
#import "XCUIApplicationProcess.h"
#import "XCEventGenerator.h"
#import "RandomAction.h"
#import "RegularAction.h"
#import "Macros.h"
//#import "AgentForHost.h"


@interface Monkey()
@property NSString *testedAppBundleID;
@property (nonatomic) XCUIApplication *testedApp;
@property CGRect screenFrame;
@property (readwrite) int actionCounter;
@property double totalWeight;
@property NSMutableArray<RandomAction *> *randomActions;
@property NSMutableArray<RegularAction *> *regularActions;
//@property AgentForHost *appAgent;
@end

@implementation Monkey

-(id)initWithBundleID:(NSString*)bundleID
{
    if (self = [super init]) {
        _testedAppBundleID = bundleID;
        _testedApp = [[XCUIApplication alloc] initPrivateWithPath:nil bundleID:self.testedAppBundleID];
        _testedApp.launchEnvironment = @{@"maxGesturesShown": @5};
        
        
        /* Use _testedApp.frame will cause strange issue:
         * _testedApp.lastSnapshot will never change
         */
        _screenFrame = CGRectMake(0, 0, 375, 667);
        
        _actionCounter = 0;
        _regularActions = [[NSMutableArray alloc] init];
        _randomActions = [[NSMutableArray alloc] init];
    }
    return self;
}

-(XCUIApplication *)testedApp
{
    [_testedApp query];
    [_testedApp resolve];
    return _testedApp;
}

-(void)preRun
{
    //不知道要接入peertalk ，应该还没用上
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        _appAgent = [[AgentForHost alloc] initWithDelegate:self];
//        [_appAgent connectToLocalIPv4AtPort:2345 timeout:15];
//    });
    [_testedApp launch];
}

-(void)postRun
{
    [_testedApp terminate];
}

-(void)run:(int)steps
{
    for (int i = 0; i < steps; i++) {
        [NSThread sleepForTimeInterval:0.5];
        @autoreleasepool {
            [self actRandomly];
            [self actRegularly];
        }
    }
    
}



-(void)run_init{
    [self preRun];
}

-(void)run_end{
    [self postRun];
}

-(void)run_callback
{
//    [self preRun];
    sleep(3);
    [[XCUIDevice sharedDevice]pressButton:XCUIDeviceButtonHome];
    sleep(1);
    sleep(3);
//    NSString *state = [UIApplication sharedApplication].applicationState;
    
    
//    self.testedApp.browsers;
//    
//    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
//    XCUIDevice.shared().siriService.activate(voiceRecognitionText: "Open News")
//    [[XCUISiriService alloc]activateWithVoiceRecognitionText:@"Open 抖音短视频内测"];
//    sleep(5);
}



-(void)run_login_aweme:(int)steps
{

    sleep(3);
    [self.testedApp.tabBars.buttons[@"btn home add"] tap];
    [self.testedApp typeText:@"18201032691"];
    sleep(3);
    [self.testedApp.buttons[@"iconSignNext"] tap];
    sleep(3);
    [self.testedApp typeText:@"qwerty"];
    sleep(5);
    [self.testedApp.buttons[@"iconSignDone"] tap];

    sleep(5);
    
}

-(void)run
{
    [self preRun];
    
    while (YES) {
        @autoreleasepool {
            [self actRandomly];
            [self actRegularly];
        }
    }
    
//    [self postRun];
}

-(void)actRandomly
{
    double x = RandomZeroToOne * _totalWeight;
    for (RandomAction *action in _randomActions) {
        if (x < action.accumulatedWeight) {
            action.action();
            return;
        }
    }
}

-(void)actRegularly
{
    _actionCounter += 1;
    for (RegularAction *action in _regularActions) {
        if (_actionCounter % action.interval == 0) {
            action.action();
        }
    }
}

-(void)addAction:(ActionBlock)action withWeight:(double)weight
{
    _totalWeight += weight;
    [_randomActions addObject:[[RandomAction alloc] initWithWeight:_totalWeight action:action]];
}

-(void)addAction:(ActionBlock)action  withInterval:(int)interval
{
    [_regularActions addObject:[[RegularAction alloc] initWithInterval:interval action:action]];
}



-(CGPoint)randomPoint
{
    return [self randomPointInRect:_screenFrame];
}

-(CGPoint)divCGFloatx:(CGFloat)x divCGFloaty: (CGFloat)y
{
    CGPoint p; p.x = x; p.y = y; return p;
    
}

-(CGPoint)randomPointInRect:(CGRect)rect
{
    return CGPointMake(rect.origin.x + RandomZeroToOne * rect.size.width,
                       rect.origin.y + RandomZeroToOne * rect.size.height);
}

-(CGPoint)randomPointAvoidingPanelAreas
{
    CGFloat topHeight = 30;
    CGFloat bottomHeight = 25;
    CGRect frameWithoutTopAndBottom = CGRectMake(0,
                                                 topHeight,
                                                 _screenFrame.size.width,
                                                 _screenFrame.size.height - topHeight - bottomHeight);
    return [self randomPointInRect:frameWithoutTopAndBottom];
}

-(CGRect)randomRect
{
    return [self rectAround:[self randomPoint] inRect:_screenFrame];
}

-(CGRect)randomRectWithSizeFraction:(CGFloat)sizeFraction
{
    return [self rectAround:[self randomPoint] sizeFraction:sizeFraction inRect:_screenFrame];
}

-(CGRect)rectAround:(CGPoint)point inRect:(CGRect)inRect
{
    return [self rectAround:point sizeFraction:3 inRect:inRect];
}


-(CGRect)rectAround:(CGPoint)point sizeFraction:(float)sizeFraction inRect:(CGRect)inRect
{
    CGFloat size = MIN(_screenFrame.size.width, _screenFrame.size.height) / sizeFraction;
    CGFloat x0 = (point.x - _screenFrame.origin.x) * (_screenFrame.size.width - size) / _screenFrame.size.width + _screenFrame.origin.x;
    CGFloat y0 = (point.y - _screenFrame.origin.y) * (_screenFrame.size.height - size) / _screenFrame.size.width  + _screenFrame.origin.y;
    return CGRectMake(x0, y0, size, size);
}

-(void)tapAtTouchLocationsdivCGFloatx:(CGFloat)x divCGFloaty: (CGFloat)y
                         numberOfTaps:(int)taps
{
    UIInterfaceOrientation orientationValue = UIInterfaceOrientationPortrait;
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    CGPoint point = [self divCGFloatx:x divCGFloaty:y];
    [locations addObject:[NSValue valueWithCGPoint:point]];
    NSLog(@"point: {%.1f, %.1f}", point.x, point.y);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    XCEventGeneratorHandler handlerBlock = ^(XCSynthesizedEventRecord *record, NSError *commandError) {
        if (commandError) {
            NSLog(@"Failed to perform step: %@", commandError);
        }
        dispatch_semaphore_signal(semaphore);
    };
    
    [[XCEventGenerator sharedGenerator] tapAtTouchLocations:locations
                                               numberOfTaps:taps
                                                orientation:orientationValue
                                                    handler:handlerBlock];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

-(void)pressAtTouchLocationsdivCGFloatx:(CGFloat)x divCGFloaty: (CGFloat)y
                            forDuration:(CGFloat)sleep
{
    UIInterfaceOrientation orientationValue = UIInterfaceOrientationPortrait;
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    CGPoint point = [self divCGFloatx:x divCGFloaty:y];
    [locations addObject:[NSValue valueWithCGPoint:point]];
    NSLog(@"point: {%.1f, %.1f}", point.x, point.y);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[XCEventGenerator sharedGenerator] pressAtPoint:point
                                         forDuration:sleep
                                         orientation:orientationValue
                                             handler:^(XCSynthesizedEventRecord *record, NSError *commandError) {
                                                 if (commandError) {
                                                     NSLog(@"Failed to perform step: %@", commandError);
                                                 }
                                                 dispatch_semaphore_signal(semaphore);
                                             }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

-(void)dragCGFloatx1:(CGFloat)x1 divCGFloaty1: (CGFloat)y1 divCGFloatx2: (CGFloat)x2 divCGFloaty2: (CGFloat)y2
        forDuration:(CGFloat)sleep
{
    UIInterfaceOrientation orientationValue = UIInterfaceOrientationPortrait;
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    CGPoint start = [self divCGFloatx:x1 divCGFloaty:y1];
    [locations addObject:[NSValue valueWithCGPoint:start]];
    CGPoint end = [self divCGFloatx:x2 divCGFloaty:y2];
    [locations addObject:[NSValue valueWithCGPoint:end]];
//    NSLog(@"point: {%.1f, %.1f}", point.x, point.y);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[XCEventGenerator sharedGenerator] pressAtPoint:start
                                         forDuration:sleep
                                         liftAtPoint:end
                                            velocity:1000
                                         orientation:orientationValue
                                                name:@"Monkey drag"
                                             handler:^(XCSynthesizedEventRecord *record, NSError *commandError) {
                                                 if (commandError) {
                                                     NSLog(@"Failed to perform step: %@", commandError);
                                                 }
                                                 dispatch_semaphore_signal(semaphore);
                                             }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}


@end
