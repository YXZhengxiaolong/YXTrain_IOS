//
//  YXMySettingViewController.m
//  TrainApp
//
//  Created by 郑小龙 on 16/7/4.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "YXMySettingViewController.h"
#import "PersistentUrlDownloader.h"
#import "YXHelpViewController.h"
#import "YXAboutViewController.h"
#import "YXMySettingCell.h"
#import "YXWebSocketManger.h"
static  NSString *const trackPageName = @"设置页面";
@interface YXMySettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *_tableView;
    
    
    NSArray *_titleArray;
    
}
@end

@implementation YXMySettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithHexString:@"dfe2e6"];
    _titleArray = @[@[@"清空缓存",@"帮助与反馈",@"去AppStore评分",@"关于我们"],@[@"退出登录"]];
    [self setupUI];
    [self layoutInterface];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [YXDataStatisticsManger trackPage:trackPageName withStatus:YES];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [YXDataStatisticsManger trackPage:trackPageName withStatus:NO];
    self.navigationController.navigationBar.shadowImage = [UIImage yx_imageWithColor:[UIColor colorWithHexString:@"f2f6fa"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI setting
- (void)setupUI{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor colorWithHexString:@"eceef2"];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15.0f, 0.0f, 0.0f);
    _tableView.backgroundColor = [UIColor colorWithHexString:@"dfe2e6"];
    _tableView.layoutMargins = UIEdgeInsetsZero;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"staticString"];
    [_tableView registerClass:[YXMySettingCell class] forCellReuseIdentifier:@"YXMySettingCell"];
    [_tableView registerClass:[YXSectionHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"YXSectionHeaderFooterView"];
    [self.view addSubview:_tableView];
}

- (void)layoutInterface{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)_titleArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YXMySettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YXMySettingCell" forIndexPath:indexPath];
        [cell reloadWithText:_titleArray[indexPath.section][indexPath.row] imageName:@""];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"staticString" forIndexPath:indexPath];
        cell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0067be"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        UIView *selectedBgView = [[UIView alloc]init];
        selectedBgView.backgroundColor = [UIColor colorWithHexString:@"f2f6fa"];
        cell.selectedBackgroundView = selectedBgView;
        return cell;
    }
    
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 5.0f;
    }else{
        return 30.0f;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YXSectionHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YXSectionHeaderFooterView"];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
            {
                // 清sdwebimage
                [[SDImageCache sharedImageCache] clearDisk];
                [[SDImageCache sharedImageCache] clearMemory];
                
                // 清缓存
                NSString *dp = [BaseDownloader downloadFolderPath];
                [[NSFileManager defaultManager] removeItemAtPath:dp error:nil];
                
                [[QYSDK sharedSDK] cleanResourceCacheWithBlock:^(NSError *error) {
                    
                }];
                
                [self showToast:@"清除成功"];
                [YXDataStatisticsManger trackEvent:@"清理缓存" label:@"成功清理缓存" parameters:nil];
            }
                break;
            case 1:
            {
                [[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = [LSTSharedInstance sharedInstance].userManger.userModel.profile.head;
                QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
                sessionViewController.sessionTitle = @"手机研修";
                [self.navigationController pushViewController:sessionViewController animated:YES];
            }
                break;
            case 2:
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1012923844"]];
            }
                break;
            case 3:
            {
                YXAboutViewController *aboutVC = [[YXAboutViewController alloc] init];
                [self.navigationController pushViewController:aboutVC animated:YES];
            }
                break;
            default:
                break;
        }
        
    }else{
        [[LSTSharedInstance  sharedInstance].webSocketManger close];
        [[LSTSharedInstance sharedInstance].userManger logout];
        [YXDataStatisticsManger trackEvent:@"退出登录" label:@"成功登出" parameters:nil];
    }
}


@end
