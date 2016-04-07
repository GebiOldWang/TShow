//
//  TSActiveCell.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/7.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds

#import "TSActiveCell.h"
#import "TSActiveModel.h"

@interface TSActiveCell()
{
    int i ;
    int j ;
}


@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic, weak) UIButton * imgBtn;

@property (nonatomic, weak) UIView *picView;

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;

@end

@implementation TSActiveCell

-(void)setModel:(TSActiveModel *)model
{
    _model = model;
    _iconImg.layer.cornerRadius = 25;
    _iconImg.layer.masksToBounds = YES;
    _iconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_model.icon]];
    _name.text = [NSString stringWithFormat:@"%@",_model.name];
    _time.text = [NSString stringWithFormat:@"%@",_model.time];
    _text.text = [NSString stringWithFormat:@"%@",_model.text];
    [_text sizeToFit];
    
    [_guanzhuBtn addTarget:self action:@selector(clickguanzhu:) forControlEvents:UIControlEventTouchUpInside];
//    对图片进行判断
    NSArray * picArr = [NSArray arrayWithObject:_model.picture][0];
//    是否有配图
    if (picArr.count) {
        NSMutableArray * picNameArr = [NSMutableArray array];
        [picArr enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * nameStr = dict[@"picname"];
            [picNameArr addObject:nameStr];
        }];
//    图片数组
        self.arr = picNameArr;
//        定义picView的大小
        i = 0 ;
        j = 0 ;
        CGFloat margin = 3;
        CGFloat picViewH = 0;
        CGFloat W = 0;
        if (self.arr.count == 1){//  宽等于高
            picViewH = Frame.size.width;
            W = picViewH;
        }else if (self.arr.count == 4){//   宽等于屏幕宽－margin/2
            picViewH = Frame.size.width;
            W = (picViewH - margin)/2;
        }else if (self.arr.count == 2){
            picViewH = (Frame.size.width - margin)/2;
            W = picViewH;
        }else if (self.arr.count == 3){
            picViewH = (Frame.size.width - margin * 2)/3;
            W = picViewH;
        }else if (self.arr.count == 5 || self.arr.count == 6){
            picViewH =(Frame.size.width - margin * 2)/3 * 2 +margin;
            W = (Frame.size.width - margin * 2)/3;
        }else { //  7.8.9
            picViewH = Frame.size.width;
            W = (Frame.size.width - margin * 2)/3;
        }
//      定义图片组容器大小
        CGFloat labelMXY = CGRectGetMaxY(self.text.frame) + 10;
        UIView * picView = [[UIView alloc] initWithFrame:CGRectMake(0, labelMXY, Frame.size.width,picViewH)];
        picView.backgroundColor = [UIColor whiteColor];
//        遍历数组
        if ((self.arr.count <= 9)&&(self.arr.count != 4)) {
            [self.arr enumerateObjectsUsingBlock:^(NSString * pic, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton * imgBtn = [[UIButton alloc] init];
                imgBtn.tag = i;
//                分行  分列
                NSInteger row = i / 3;
                CGFloat Y = row * (W +margin);
                NSInteger col = i % 3;
                CGFloat X = col * (W +margin);
                
                imgBtn.frame = CGRectMake(X, Y, W, W);
                [imgBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",pic]] forState:UIControlStateNormal];
                [imgBtn addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
                i += 1;
                self.imgBtn = imgBtn;
                [picView addSubview:self.imgBtn];
            }];
        }else if (self.arr.count == 4){// 特殊情况4张图
            [self.arr enumerateObjectsUsingBlock:^(NSString * pic, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton * imgBtn = [[UIButton alloc] init];
                imgBtn.tag = j;
                
                NSInteger row = j / 2;
                CGFloat Y = row * (W +margin);
                NSInteger col = j % 2;
                CGFloat X = col * (W +margin);
                
                imgBtn.frame = CGRectMake(X , Y, W, W);
                [imgBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",pic]] forState:UIControlStateNormal];
                [imgBtn addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
                
                j += 1;
                self.imgBtn = imgBtn;
                [picView addSubview:self.imgBtn];
            }];
        }
        self.picView = picView;
        [self addSubview:self.picView];
        
        self.model.cellHeight = CGRectGetMaxY(self.picView.frame) + 20;
    }else{
//        没有配图
        self.model.cellHeight = CGRectGetMaxY(self.text.frame) + 20;
    }
}

-(void)clickImage:(UIButton *)sender{
    !_Clickblock ? : _Clickblock (sender.tag);
}

-(void)ClickImageIndex:(ClickImageBlock)block
{
    self.Clickblock = block;
}

-(NSArray *)arr
{
    if (_arr == nil ){
        _arr = [[NSArray alloc] init];
    }
    return _arr;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)Clickguanzhu:(ClickGuanzhu)block
{
    _ClickBtn = block;
}
-(void)clickguanzhu:(UIButton *)sender
{
    !_ClickBtn? : _ClickBtn(random());
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tabelView
{
    static NSString * ID = @"TSActivecell";
    TSActiveCell * cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
