//
//  AppDelegate.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/3.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWIntroductionViewController.h"
#import "UnLoginHomePageViewController.h"
#import "myViewController.h"
#import "LoginHomePageViewController.h"
#import "LoginAPICmd.h"

@interface AppDelegate () <APICmdApiCallBackDelegate>

@property (nonatomic, strong) ZWIntroductionViewController *introduceVC;
@property (nonatomic, strong) UnLoginHomePageViewController *UnLoginHomePageVC;

@property (nonatomic, strong) UIButton *enterBtn;
@property (strong, nonatomic) myViewController* viewController;

//登录
@property (nonatomic, strong) LoginAPICmd *loginAPICmd;


@end

@implementation AppDelegate

#pragma mark - life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.viewController = [[myViewController alloc] init];
    self.viewController.view.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = self.viewController;
    
    
    [self.window makeKeyAndVisible];
    
    if (![Tool getUserInfo] || [[Tool getUserInfo] isKindOfClass:[NSNull class]] || [[Tool getUserInfo] count] == 0) {
        //表示没有用户，则登录
        [self appLogin];
    }else{
        [self.loginAPICmd loadData];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    NSDictionary *tempDict = (NSDictionary *)responseData;
    
    if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
        
        [self appLogin];
        
    }else{
        
        [Tool setUserInfoWithDict:@{@"id":tempDict[@"id"],@"username":[Tool getUserInfo][@"username"],@"password":[Tool getUserInfo][@"password"]}];
        
        //登录成功
        LoginHomePageViewController *loginHomePageVC = [[LoginHomePageViewController alloc] init];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginHomePageVC];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:loginNav];
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    
    //登录
    [self appLogin];
    
}

#pragma mark - event response

#pragma mark - private method


//App登陆
-(void)appLogin
{
    
    if (![Tool getUserInfo] || [[Tool getUserInfo] isKindOfClass:[NSNull class]] || [[Tool getUserInfo] count] == 0) {
        [self introduceView];
    }else{
        [self showHomePage];
    }
    
    /*
    //判断是否第一次启动
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        [self introduceView];
        
    }else{
        
        [self showHomePage];
    }
    */
}

- (void)introduceView {
    
    NSArray *coverImageNames = @[@"guide_1", @"guide_2", @"guide_3"];
    
    self.introduceVC = [[ZWIntroductionViewController alloc] initWithCoverImgNames:coverImageNames backgroundImageNames:nil enterBtn:self.enterBtn kipButton:nil];
    
    __weak AppDelegate *weakSelf = self;
    self.introduceVC.didSelectedEnter = ^() {
        
        [weakSelf.introduceVC.view removeFromSuperview];
        [weakSelf showHomePage];
        
        
    };
    
    /**
     *  如果欢迎页有跳过时使用该回调
     */
    //    self.introduceVC.didSkipedEnter = ^() {
    //        [weakSelf.introduceVC.view removeFromSuperview];
    //        [weakSelf showHomePage];
    //    };
    
    [self.window addSubview:self.introduceVC.view];
    
}

- (void)showHomePage {
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.UnLoginHomePageVC];
    
}

#pragma mark - getters and setters

- (UIButton *)enterBtn {
    if (!_enterBtn) {
        
        CGFloat imgWith = kScreenWidth * 0.65;
        
        _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterBtn.frame = CGRectMake((kScreenWidth - imgWith)/2 + imgWith/2, kScreenHeight * 0.55, imgWith, 45);
        _enterBtn.backgroundColor = [UIColor clearColor];
        [_enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterBtn setTitle:@"开启财富之旅" forState:UIControlStateNormal];
        _enterBtn.layer.cornerRadius = 4;
        _enterBtn.layer.borderWidth = 1;
        _enterBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _enterBtn;
}

- (UnLoginHomePageViewController *)UnLoginHomePageVC {
    if (!_UnLoginHomePageVC) {
        _UnLoginHomePageVC = [[UnLoginHomePageViewController alloc] init];
    }
    return _UnLoginHomePageVC;
}

- (LoginAPICmd *)loginAPICmd {
    if (!_loginAPICmd) {
        _loginAPICmd = [[LoginAPICmd alloc] init];
        _loginAPICmd.delegate = self;
        _loginAPICmd.path = API_Login;
        
    }
    _loginAPICmd.reformParams = @{@"username":[Tool getUserInfo][@"username"],
                                  @"password":[Tool getUserInfo][@"password"]};
    return _loginAPICmd;
}

@end
