//
//  ActiveDetailCell.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/11.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "ActiveDetailCell.h"
#import "ActiveDetailModel.h"

@interface ActiveDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation ActiveDetailCell

-(void)setModel:(ActiveDetailModel *)model
{
    _model = model;
    _img.image = [UIImage imageNamed:_model.icon];
    _img.layer.cornerRadius = 25;
    _img.layer.masksToBounds = YES;
    
    _name.text = _model.name;
    _time.text = _model.time;
    _text.text = _model.text;
    [_text sizeToFit];
    
    CGFloat imgY = CGRectGetMaxY(_img.frame) + 5;
    CGFloat textY = CGRectGetMaxY(_text.frame) + 5;
    
    CGFloat MAXY = (imgY > textY) ? imgY : textY ;
    _model.cellHeight = MAXY;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableview:(UITableView *)tableview
{
    static NSString * ID = @"activeDetailcell";
    ActiveDetailCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
