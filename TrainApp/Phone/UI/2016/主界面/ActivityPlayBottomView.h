//
//  ActivityPlayBottomView.h
//  TrainApp
//
//  Created by 郑小龙 on 16/11/7.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivitySlideProgressControl.h"
@interface ActivityPlayBottomView : UIView
@property (nonatomic, strong) UIButton *playPauseButton;
@property (nonatomic, strong) ActivitySlideProgressControl *slideProgressControl;
@property (nonatomic, strong) UIButton *rotateButton;
@property (nonatomic, strong) UIButton *definitionButton;
@property (nonatomic, assign) BOOL isShowDefinition;
@property (nonatomic, assign) BOOL isFullscreen;
@end
