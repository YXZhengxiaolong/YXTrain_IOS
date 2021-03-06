//
//  CourseLocalListViewController_17.m
//  TrainApp
//
//  Created by 郑小龙 on 2017/8/3.
//  Copyright © 2017年 niuzhaowang. All rights reserved.
//

#import "CourseRecordListViewController_17.h"
#import "CourseListFilterView_17.h"
#import "CourseListHeader_17.h"
#import "CourseListCell_17.h"
#import "CourseListFormatModel_17.h"
#import "VideoCourseDetailViewController.h"
#import "CourseHistoryViewController_17.h"
#import "YXCourseDetailPlayerViewController_17.h"
#import "CourseCenterConditionRequest_17.h"
#import "CourseCenterListFetcher_17.h"
@interface CourseRecordListViewController_17 ()
@end

@implementation CourseRecordListViewController_17

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    CourseCenterListFetcher_17 *fetcher = [[CourseCenterListFetcher_17 alloc]init];
    fetcher.status = @"0";
    fetcher.tab = @"my";
    fetcher.stageID = self.courseType.typeID;
    fetcher.study = @"0";
    fetcher.segment = @"0";
    self.dataFetcher = fetcher;
    self.bIsGroupedTableViewStyle = YES;
    [super viewDidLoad];
    self.navigationItem.title = @"看课记录";
    self.view.backgroundColor = [UIColor colorWithHexString:@"dfe2e6"];
    [self setupLayout];
}

- (void)setupUI {
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"dfe2e6"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 104.0f;
    [self.tableView registerClass:[CourseListCell_17 class]
           forCellReuseIdentifier:@"CourseListCell_17"];
    [self.tableView registerClass:[YXSectionHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"YXSectionHeaderFooterView"];

    self.emptyView.title = @"没有符合条件的课程";
    self.emptyView.imageName = @"没有符合条件的课程";
    [self setupObservers];
}
- (void)setupLayout {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setupObservers{
    WEAK_SELF
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:kRecordReportSuccessNotification object:nil]subscribeNext:^(id x) {
        STRONG_SELF
        NSNotification *noti = (NSNotification *)x;
        NSString *course_id = noti.userInfo.allKeys.firstObject;
        NSString *record = noti.userInfo[course_id];
        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CourseListRequest_17Item_Objs *course = (CourseListRequest_17Item_Objs *)obj;
            if ([course.objID isEqualToString:course_id]) {
                course.timeLength = record;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                *stop = YES;
            }
        }];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count > 0 ? 1 : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseListCell_17 *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseListCell_17" forIndexPath:indexPath];
    CourseListRequest_17Item_Objs *obj = self.dataArray[indexPath.row];
    obj.timeLengthSec = obj.timeLength;//课程中心使用timeLength字段
    cell.course = obj;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YXCourseDetailPlayerViewController_17 *vc = [[YXCourseDetailPlayerViewController_17 alloc] init];
    vc.course = [CourseListFormatModel_17 formatModel:self.dataArray[indexPath.row]];
    vc.fromWhere = VideoCourseFromWhere_Record;
    vc.isHiddenTestBool = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YXSectionHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YXSectionHeaderFooterView"];
    return headerView;
}
@end
