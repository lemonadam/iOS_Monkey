//
//  Monkey.h
//  OCMonkey
//
//  Created by gogleyin on 02/03/2017.
//
//

#import <Foundation/Foundation.h>
#import "RandomAction.h"
#import <CoreGraphics/CoreGraphics.h>
#import "XCUIApplication.h"

@interface Monkey : NSObject

-(instancetype)initWithBundleID:(NSString*)bundleID;
-(void)run:(int)steps;
-(void)run_init;
-(void)tapAtTouchLocationsdivCGFloatx:(CGFloat)x divCGFloaty: (CGFloat)y
                         numberOfTaps:(int)taps;
-(void)pressAtTouchLocationsdivCGFloatx:(CGFloat)x divCGFloaty: (CGFloat)y
                            forDuration:(CGFloat)sleep;
-(void)dragCGFloatx1:(CGFloat)x1 divCGFloaty1: (CGFloat)y1 divCGFloatx2: (CGFloat)x2 divCGFloaty2: (CGFloat)y2
         forDuration:(CGFloat)sleep;
-(void)run_end;
-(void)run_login_aweme:(int)steps;
-(void)run_callback;
-(void)run;
//-(void)addAction:(ActionBlock)action ;
-(void)addAction:(ActionBlock)action withWeight:(double)weight;
-(void)addAction:(ActionBlock)action withInterval:(int)interval;
-(CGPoint)randomPoint;
-(CGPoint)divCGFloatx:(CGFloat)x divCGFloaty: (CGFloat)y;
-(CGPoint)randomPointInRect:(CGRect)rect;
-(CGPoint)randomPointAvoidingPanelAreas;
-(CGRect)randomRect;
-(CGRect)randomRectWithSizeFraction:(CGFloat)sizeFraction;

@property (readonly) int actionCounter;
@property (nonatomic, readonly) XCUIApplication *testedApp;

@end
