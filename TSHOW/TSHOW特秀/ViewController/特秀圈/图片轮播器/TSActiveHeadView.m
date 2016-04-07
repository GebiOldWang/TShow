//
//  TSActiveHeadView.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds

#import "TSActiveHeadView.h"

@interface TSActiveHeadView ()

{
    int i ;
}

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UIView *zanView;

@property (nonatomic, strong) NSArray * zanArray;
@property (weak, nonatomic) IBOutlet UILabel *dianzanLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation TSActiveHeadView

-(void)setModel:(TSActiveModel *)model
{
    _model = model;
    _iconImg.layer.cornerRadius = 25;
    _iconImg.layer.masksToBounds = YES;
    _iconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_model.icon]];
    _name.text = [NSString stringWithFormat:@"%@",_model.name];
    _time.text = [NSString stringWithFormat:@"%@",_model.time];
//    
    _text.text = [NSString stringWithFormat:@"%@",_model.text];
    [_text sizeToFit];
    
    self.guanzhuBtn.layer.cornerRadius = 5;
    self.guanzhuBtn.layer.masksToBounds = YES;
    
    CGFloat maxY = CGRectGetMaxY(self.text.frame) +122;
    _model.height = maxY;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(NSArray *)zanArray
{
    if (_zanArray == nil) {
        _zanArray = self.zanPicArr;
    }
    return _zanArray;
}
-(void)setZanPicArr:(NSArray *)zanPicArr
{
    _zanPicArr = zanPicArr;
    i = 0;
    self.dianzanLabel.text = [NSString stringWithFormat:@"%ld人点赞",self.zanArray.count];
    [self.zanArray enumerateObjectsUsingBlock:^(NSString * picname, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView * zanimg = [[UIImageView alloc] init];
        zanimg.layer.cornerRadius = 15;
        zanimg.layer.masksToBounds = YES;
        CGFloat margin = 8;
        CGFloat X = i * 30 + margin * (i +1);
        zanimg.frame = CGRectMake( X, 37, 30, 30);
        zanimg.image = [UIImage imageNamed:picname];
        [self.zanView addSubview:zanimg];
        
        if (i == (int)Frame.size.width/38) {
            i = (int)Frame.size.width/38;
        }else
            i = i + 1;
    }];
}

+(instancetype)headview
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TSActiveHeadView" owner:nil options:nil] lastObject];
}
-(IBAction)Clickguanzhubtn:(UIButton *)sender{
    if (_focusblock) {
        _focusblock();
    }
}
- (IBAction)chankanZan:(UIButton *)sender {
    if (_zanblock) {
        _zanblock();
    }
}

-(void)ClickZan:(ZanBlock)block
{
    _zanblock = block;
}
-(void)ClickGuanzhu:(FocusBlock)block
{
    _focusblock = block;
}


@end
