//
//  ActitvityCommentFooterView.h
//  TrainApp
//
//  Created by 郑小龙 on 16/11/8.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ActitvitySeeAllCommentReplyBlock) (void);
@interface ActitvityCommentFooterView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *childNum;

- (void)setActitvitySeeAllCommentReplyBlock:(ActitvitySeeAllCommentReplyBlock)block;
@end
