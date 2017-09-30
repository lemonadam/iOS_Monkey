//
//  ViewController.m
//  OCMonkeyExample
//
//  Created by gogleyin on 27/03/2017.
//
//

#import "ViewController.h"
#import "Macros.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width)/4,self.view.frame.size.height - 80,80,80);
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:60];
    [self.view addSubview:button];
    button.layer.cornerRadius = 40;
    button.tag = 1010;
    [button addTarget:self
               action:@selector(dismiss)
     forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
    _agent = [[AgentForHost alloc] initWithDelegate:self];
    [_agent connectToLocalIPv4AtPort:2345];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewController:(NSString *)vc didAppearAnimated:(BOOL)animated
{
    NSLog(@"%@ [%@ viewDidAppear:%@", prefix, vc, animated ? @"Yes" : @"No");
}

- (BOOL)naviCtrl:(NSString *)naviCtrl shouldPushViewController:(NSString *)pushedVC animated:(BOOL)animated
{
    NSLog(@"%@ [%@ pushViewController:%@ animated:%@]", prefix, naviCtrl, pushedVC, animated ? @"Yes" : @"No");
    return NO; // The pushedVC will not get pushed into naviCtrl.
}

- (BOOL)naviCtrl:(NSString *)naviCtrl shouldPopViewControllerAnimated:(BOOL)animated
{
    NSLog(@"%@ [%@ popViewController:%@]", prefix, naviCtrl, animated ? @"Yes" : @"No");
    return NO; // The pushedVC will not get pushed into naviCtrl.
}

- (BOOL)naviCtrl:(NSString *)naviCtrl shouldPopToRootViewControllerAnimated:(BOOL)animated
{
    NSLog(@"%@ [%@ popToRootViewControllerAnimated:%@]", prefix, naviCtrl, animated ? @"Yes" : @"No");
    return NO;
}

- (BOOL)naviCtrl:(NSString *)naviCtrl shouldPopToViewController:(NSString *)toVC animated:(BOOL)animated
{
    NSLog(@"%@ [%@ popToViewController:%@ animated: %@] ==> %@", prefix, naviCtrl, toVC, animated ? @"Yes" : @"No");
    return NO;
}

- (void)naviCtrl:(NSString *)naviCtrl initWithRootViewController:(NSString *)vc
{
    NSLog(@"%@ [%@ initWithRootViewController:%@]", prefix, naviCtrl, vc);
}

- (void)naviCtrl:(NSString *)naviCtrl setViewControllers:(NSArray<NSString *>*)VCs animated:(BOOL)animted
{
    NSLog(@"%@ [%@ setViewControllers:%@]", prefix, naviCtrl, VCs);
}


@end
