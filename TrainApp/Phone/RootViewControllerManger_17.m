//
//  RootViewControllerManger_17.m
//  TrainApp
//
//  Created by 郑小龙 on 2017/11/14.
//  Copyright © 2017年 niuzhaowang. All rights reserved.
//

#import "RootViewControllerManger_17.h"
#import "MasterTabBarViewController_17.h"
#import "YXNavigationController.h"
#import "UITabBar+YXAddtion.h"
#import "MasterTabBarViewController_17.h"
#import "YXTabBarViewController_17.h"
@implementation RootViewControllerManger_17
- (void)showDrawerViewController:(__weak UIWindow *)window {
    MasterTabBarViewController_17 *tabVC  = (MasterTabBarViewController_17 *)window.rootViewController;
    if (tabVC.selectedViewController.presentedViewController) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kYXTrainPushNotification object:nil];
    }
    YXNavigationController *projectNavi = (YXNavigationController *)tabVC.selectedViewController;
    if ([projectNavi.viewControllers.lastObject isKindOfClass:[NSClassFromString(@"YXDynamicViewController") class]]){
        return ;
    }
    UIViewController *VC = [[NSClassFromString(@"YXDynamicViewController") alloc] init];
    [projectNavi pushViewController:VC animated:YES];
}
- (UIViewController *)rootViewController {
    if([LSTSharedInstance sharedInstance].trainManager.currentProject.role.integerValue == 99) {
        MasterTabBarViewController_17 *tabVC = [[MasterTabBarViewController_17 alloc] init];
        YXNavigationController *homeNav = [[YXNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"MasterHomeViewController_17") alloc]init]];
        
        YXNavigationController *examNav = [[YXNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"MasterExamViewController_17") alloc]init]];
        
        YXNavigationController *messageNav = [[YXNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"MasterMessageViewController_17") alloc]init]];
        
        YXNavigationController *mineNav = [[YXNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"MasterMainViewController_17") alloc]init]];
        [self setTabBarItem:homeNav title:@"首页" image:@"学习未选中" selectedImage:@"学习选中" tag:1];
        [self setTabBarItem:examNav title:@"考核" image:@"学习未选中" selectedImage:@"学习选中" tag:2];
        [self setTabBarItem:messageNav title:@"消息" image:@"消息动态未点" selectedImage:@"消息选中" tag:3];
        [self setTabBarItem:mineNav title:@"我" image:@"我未选中" selectedImage:@"我选中" tag:4];
        tabVC.viewControllers = @[homeNav,examNav,messageNav, mineNav];
        NSInteger redInteger = [LSTSharedInstance sharedInstance].redPointManger.showRedPointInteger;
        if (redInteger > 0) {
            if (redInteger > 99) {
                tabVC.viewControllers[1].tabBarItem.badgeValue = @"99+";
            }else {
                tabVC.viewControllers[1].tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)[LSTSharedInstance sharedInstance].redPointManger.showRedPointInteger];
            }
            [tabVC.tabBar hideBadgeOnItemIndex:2];
        }else if (redInteger == 0){
            [tabVC.tabBar showBadgeOnItemIndex:2];
            tabVC.viewControllers[1].tabBarItem.badgeValue = nil;
        }else {
            tabVC.viewControllers[1].tabBarItem.badgeValue = nil;
            [tabVC.tabBar hideBadgeOnItemIndex:2];
        }
        return tabVC;
    }else {
        YXTabBarViewController_17 *tabVC = [[YXTabBarViewController_17 alloc] init];
        UIViewController *learningVC = [[NSClassFromString(@"YXLearningViewController_17") alloc]init];
        YXNavigationController *learningNav = [[YXNavigationController alloc]initWithRootViewController:learningVC];
        UIViewController *messageVC = [[NSClassFromString(@"YXMessageViewController_17") alloc]init];
        YXNavigationController *messageNav = [[YXNavigationController alloc]initWithRootViewController:messageVC];
        UIViewController *mineVC = [[NSClassFromString(@"YXMineViewController_17") alloc]init];
        YXNavigationController *mineNav = [[YXNavigationController alloc]initWithRootViewController:mineVC];
        [self setTabBarItem:learningNav title:@"学习" image:@"学习未选中" selectedImage:@"学习选中" tag:1];
        [self setTabBarItem:messageNav title:@"消息" image:@"消息动态未点" selectedImage:@"消息选中" tag:2];
        [self setTabBarItem:mineNav title:@"我" image:@"我未选中" selectedImage:@"我选中" tag:3];
        tabVC.viewControllers = @[learningNav, messageNav, mineNav];
        NSInteger redInteger = [LSTSharedInstance sharedInstance].redPointManger.showRedPointInteger;
        if (redInteger > 0) {
            if (redInteger > 99) {
                tabVC.viewControllers[1].tabBarItem.badgeValue = @"99+";
            }else {
                tabVC.viewControllers[1].tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)[LSTSharedInstance sharedInstance].redPointManger.showRedPointInteger];
            }
            [tabVC.tabBar hideBadgeOnItemIndex:1];
        }else if (redInteger == 0){
            [tabVC.tabBar showBadgeOnItemIndex:1];
            tabVC.viewControllers[1].tabBarItem.badgeValue = nil;
        }else {
            tabVC.viewControllers[1].tabBarItem.badgeValue = nil;
            [tabVC.tabBar hideBadgeOnItemIndex:1];
        }
        return tabVC;
    }
}
- (void)setTabBarItem:(YXNavigationController *)navController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSUInteger)tag {
    navController.tabBarItem.title = title;
    if (image.length > 0) {
        navController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (selectedImage.length > 0) {
        navController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    navController.tabBarItem.tag = tag;
    [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} forState:UIControlStateSelected];
}
@end