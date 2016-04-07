//
//  ShowFangCell.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/10.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
// 随机色

#import "ShowFangCell.h"
#import "ShowFangModel.h"

@interface ShowFangCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *spend;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *hot;

@property (weak, nonatomic) IBOutlet UILabel *beautyHair;
@property (weak, nonatomic) IBOutlet UILabel *beautyJia;
@property (weak, nonatomic) IBOutlet UILabel *cengKaNum;
@property (weak, nonatomic) IBOutlet UILabel *shaiKaNum;
@property (weak, nonatomic) IBOutlet UILabel *activetyNum;

@end

@implementation ShowFangCell

-(void)setModel:(ShowFangModel *)model
{
    _model = model;
//    图片
    self.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_model.icon]];
    self.icon.layer.cornerRadius = 8;
    self.icon.layer.masksToBounds = YES;
//    店名
    self.name.text = _model.name;
//    平均消费
    self.spend.text = [NSString stringWithFormat:@"平均消费%@元",_model.spend];
//    距离
    self.distance.text = [NSString stringWithFormat:@"距离:%@m",_model.distance];
//    人气
    self.hot.text = [NSString stringWithFormat:@"人气:%@",_model.hot];
//    美发
    self.beautyHair.layer.cornerRadius = 5;
    self.beautyHair.backgroundColor = [UIColor orangeColor];
    self.beautyHair.layer.masksToBounds = YES;
//    美甲
    self.beautyJia.layer.cornerRadius = 5;
    self.beautyJia.backgroundColor = [UIColor orangeColor];
    self.beautyJia.layer.masksToBounds = YES;
//    蹭卡
    self.cengKaNum.text = [NSString stringWithFormat:@" 蹭卡:%@张 ",_model.cengKaNum];
    self.cengKaNum.layer.cornerRadius = 5;
    self.cengKaNum.backgroundColor = [UIColor darkGrayColor];
    self.cengKaNum.layer.masksToBounds = YES;
//    晒卡
    self.shaiKaNum.text = [NSString stringWithFormat:@" 晒卡:%@张 ",_model.shaiKaNum];
    self.shaiKaNum.layer.cornerRadius = 5;
    self.shaiKaNum.backgroundColor = [UIColor darkGrayColor];
    self.shaiKaNum.layer.masksToBounds = YES;
//    活动
    self.activetyNum.text = [NSString stringWithFormat:@" 活动:%@个 ",_model.activetyNum];
    self.activetyNum.layer.cornerRadius = 5;
    self.activetyNum.backgroundColor = [UIColor darkGrayColor];
    self.activetyNum.layer.masksToBounds = YES;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTabelview:(UITableView *)tabelview
{
    static NSString * ID = @"shawfangcell";
    ShowFangCell * cell = [tabelview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
