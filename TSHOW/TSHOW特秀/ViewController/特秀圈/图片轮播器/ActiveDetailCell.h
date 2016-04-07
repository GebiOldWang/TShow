//
//  ActiveDetailCell.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/11.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActiveDetailModel;

@interface ActiveDetailCell : UITableViewCell

@property (nonatomic, weak) ActiveDetailModel * model;

+(instancetype)cellWithTableview:(UITableView *)tableview;

@end
