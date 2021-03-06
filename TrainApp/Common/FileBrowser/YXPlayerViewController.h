//
//  YXPlayerViewController.h
//  YanXiuApp
//
//  Created by Lei Cai on 5/26/15.
//  Copyright (c) 2015 yanxiu.com. All rights reserved.
//

#import "YXBaseViewController.h"
#import "YXPlayProgressDelegate.h"
#import "YXFileFavorWrapper.h"
#import "YXBrowserExitDelegate.h"

@interface YXPlayerDefinition : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *url;
@end


@interface YXPlayerViewController : YXBaseViewController
@property (nonatomic, assign) CGFloat preProgress;

@property (nonatomic, assign) BOOL bIsLocalFile;
@property (nonatomic, strong) NSString *videoUrl;

@property (nonatomic, weak) id<YXPlayProgressDelegate> delegate;

@property (nonatomic, strong) NSArray *definitionArray;
@property (nonatomic, strong) YXPlayerDefinition *defaultDefinition;// 不需要再设置，播放器内部会记录

@property (nonatomic, strong) YXFileFavorWrapper *favorWrapper;

@property (nonatomic, assign) BOOL isPreRecord;
@property (nonatomic, copy) void(^deleteHandle)(UIButton *item);

@property (nonatomic, weak) id<YXBrowserExitDelegate> exitDelegate;

@property (nonatomic, assign) YXSourceType sourceType;

@property (nonatomic, strong) NSMutableArray<__kindof YXFileVideoClassworkItem *> *classworkMutableArray;
@property (nonatomic, assign) BOOL forcequizcorrect;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *reportString;

- (void)backAction;
@end
