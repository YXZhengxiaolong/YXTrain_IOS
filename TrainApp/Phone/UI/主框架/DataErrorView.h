//
//  DataErrorView.h
//  TrainApp
//
//  Created by ZLL on 2016/11/3.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataErrorView : UIView
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, copy) void(^refreshBlock)(void);

//半屏视频界面专用
@property (nonatomic, assign) BOOL isVideo;
@end
