//
//  ShowKeCell.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/10.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "ShowKeCell.h"
#import "ShowKeModel.h"

@interface ShowKeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ageAndg;
@property (weak, nonatomic) IBOutlet UILabel *signtext;

@property (weak, nonatomic) IBOutlet UILabel *constellation;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIButton *guanzhu;

@end

@implementation ShowKeCell

-(void)setModel:(ShowKeModel *)model
{
    _model = model;
//     头像
    self.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_model.icon]];
    self.icon.layer.cornerRadius = 5;
    self.icon.layer.masksToBounds = YES;
//    昵称
    self.name.text = [NSString stringWithFormat:@"%@",_model.name];
//    性别+年龄标签
    self.ageAndg.text = [NSString stringWithFormat:@" %@ %@岁 ",_model.gender,_model.age];
    self.ageAndg.backgroundColor = [UIColor brownColor];
    self.ageAndg.layer.cornerRadius = 5;
    self.ageAndg.layer.masksToBounds = YES;
//    星座标签
    self.constellation.text = [NSString stringWithFormat:@" %@ ",_model.constellation];
    self.constellation.backgroundColor = [UIColor purpleColor];
    self.constellation.layer.cornerRadius = 5;
    self.constellation.layer.masksToBounds = YES;
//   签名
    self.signtext.text = [NSString stringWithFormat:@"签名:%@",_model.signtext];
//    距离
    self.distance.text = [NSString stringWithFormat:@"距离:%@m",_model.distance];
//    关注按钮
    self.guanzhu.layer.cornerRadius = 3;
    self.guanzhu.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tabelView
{
    static NSString * ID = @"showkecell";
    ShowKeCell * cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
