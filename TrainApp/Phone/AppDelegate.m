//
//  AppDelegate.m
//  TrainApp
//
//  Created by niuzhaowang on 16/6/13.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import <MSDynamicsDrawerViewController.h>
#import "AppDelegate.h"
#import "YXAppStartupManager.h"
#import "YXTestViewController.h"
#import "YXProjectMainViewController.h"
#import "YXSideMenuViewController.h"
#import "YXNavigationController.h"
#import "YXDrawerViewController.h"
#import "YXLoginViewController.h"

#import "YXUserProfileRequest.h"
#import "YXLoginViewController.h"
#import "YXUserManager.h"
#import "YXDatumGlobalSingleton.h"
#import "YXPromtController.h"
#import "YXInitRequest.h"
#import "YXGuideViewController.h"
#import "YXGuideModel.h"

@interface AppDelegate ()<YXLoginDelegate>

@property (strong, nonatomic) YXDrawerViewController *drawerVC;
@property (strong, nonatomic) YXLoginViewController *loginVC;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[YXAppStartupManager sharedInstance] setupForAppdelegate:self withLauchOptions:launchOptions];
    //键盘自动控制
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    [[YXInitHelper sharedHelper] requestCompeletion:nil];
    
    [self setupUI];
    return YES;
}

- (void)setupUI {
    [YXNavigationBarController setup];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    if ([YXConfigManager sharedInstance].testFrameworkOn.boolValue) {
        YXTestViewController *vc = [[YXTestViewController alloc] init];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    }else{
        NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
        NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:versionKey];
        if ([currentVersion compare:lastVersion] != NSOrderedSame) {
            YXGuideViewController *vc = [[YXGuideViewController alloc] init];
            vc.guideDataArray = [self configGuideArray];
            vc.startMainVCBlock = ^{
                [self startRootVC];
            };
            self.window.rootViewController = vc;
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else {
            [self startRootVC];
        }
    }
    [self.window makeKeyAndVisible];
}

- (void)startRootVC {
    if ([[YXUserManager sharedManager] isLogin]) {
        self.window.rootViewController = [self rootDrawerViewController];
        [self requestCommonData];
    } else
    {
        self.loginVC = [[YXLoginViewController alloc] init];
        self.window.rootViewController = [[YXNavigationController alloc] initWithRootViewController:self.loginVC];
    }
}

- (YXDrawerViewController *)rootDrawerViewController {
    
    YXSideMenuViewController *menuVC = [[YXSideMenuViewController alloc]init];
    YXProjectMainViewController *projectVC = [[YXProjectMainViewController alloc]init];
    YXNavigationController *projectNavi = [[YXNavigationController alloc]initWithRootViewController:projectVC];
    
    YXDrawerViewController *drawerVC = [[YXDrawerViewController alloc]init];
    drawerVC.drawerViewController = menuVC;
    drawerVC.paneViewController = projectNavi;
    drawerVC.drawerWidth = [UIScreen mainScreen].bounds.size.width * 600/750;
    return drawerVC;
}

- (void)requestCommonData
{
	//@weakify(self);
	[[YXUserProfileHelper sharedHelper] requestCompeletion:^(NSError *error) {
		//@strongify(self);
		[[YXDatumGlobalSingleton sharedInstance] getDatumFilterData:nil];
	}];
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

#pragma mark - ApiStubForTransfer

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	return NO;
}

// 9.0
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
	return NO;
}

#pragma mark - YXLoginDelegate

- (void)loginSuccess
{
    self.window.rootViewController = [self rootDrawerViewController];
    [self requestCommonData];
}

- (void)logoutSuccess {
    if ([self.window.rootViewController isKindOfClass:[YXDrawerViewController class]]) {
        self.loginVC = [[YXLoginViewController alloc] init];
        self.window.rootViewController = [[YXNavigationController alloc] initWithRootViewController:self.loginVC];
    }
}

- (void)tokenInvalid {
    [[YXUserManager sharedManager] resetUserData];
    [YXPromtController showToast:@"帐号授权已失效，请重新登录" inView:self.window];
    if ([self.window.rootViewController isKindOfClass:[YXDrawerViewController class]]) {
        self.loginVC = [[YXLoginViewController alloc] init];
        self.window.rootViewController = [[YXNavigationController alloc] initWithRootViewController:self.loginVC];
    }
}

- (NSArray *)configGuideArray {
    YXGuideModel *model_1 = [self guideModelWithImageName:@"" title:@"yiyi" isShowButton:NO];
    YXGuideModel *model_2 = [self guideModelWithImageName:@"" title:@"erer" isShowButton:NO];
    YXGuideModel *model_3 = [self guideModelWithImageName:@"" title:@"sansan" isShowButton:NO];
    YXGuideModel *model_4 = [self guideModelWithImageName:@"" title:@"sisi" isShowButton:YES];
    NSArray *guideArry = @[model_1,model_2,model_3,model_4];
    return guideArry;
}

- (YXGuideModel *)guideModelWithImageName:(NSString *)name title:(NSString *)titile isShowButton:(BOOL)isShowButton {
    YXGuideModel *model =[[YXGuideModel alloc] init];
    model.guideTitle = titile;
    model.guideImageString = name;
    model.isShowButton = isShowButton;
    return model;
}

@end
