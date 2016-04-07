//
//  TSActiveHeadView.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
typedef void (^FocusBlock)();
typedef void (^ZanBlock)();

#import <UIKit/UIKit.h>
#import "TSActiveModel.h"

@interface TSActiveHeadView : UIView

@property (nonatomic, weak) TSActiveModel * model;

@property (nonatomic, strong) NSArray * zanPicArr;
//  关注
@property (nonatomic, copy) FocusBlock focusblock;
//  赞
@property (nonatomic, copy) ZanBlock zanblock;

@property (nonatomic, copy) void (^heightBlock)(CGFloat height);

-(void)ClickGuanzhu:(FocusBlock)block;
-(void)ClickZan:(ZanBlock)block;

+ (instancetype)headview;

@end
