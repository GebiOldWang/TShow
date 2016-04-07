//
//  TSActiveCell.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/7.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
typedef void (^ClickImageBlock)(NSInteger index);
typedef void (^ClickGuanzhu)(NSInteger index);

#import <UIKit/UIKit.h>
@class TSActiveModel;

@interface TSActiveCell : UITableViewCell

@property (nonatomic, copy) TSActiveModel * model;
//  点击图片
@property (nonatomic, copy) ClickImageBlock Clickblock;
//  点击关注
@property (nonatomic, copy) ClickGuanzhu ClickBtn;

+(instancetype)cellWithTableView:(UITableView *)tabelView;

-(void)ClickImageIndex:(ClickImageBlock)block;
-(void)Clickguanzhu:(ClickGuanzhu)block;

@property (nonatomic, strong) NSArray * arr;

@end
