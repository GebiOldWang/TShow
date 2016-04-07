//
//  ShowFangCell.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/10.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowFangModel;

@interface ShowFangCell : UITableViewCell

@property (nonatomic, copy) ShowFangModel * model;

+(instancetype)cellWithTabelview:(UITableView *)tabelview;

@end
