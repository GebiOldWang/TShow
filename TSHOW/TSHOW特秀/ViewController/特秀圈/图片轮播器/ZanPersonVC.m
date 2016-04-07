//
//  ZanPersonVC.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds

#define col 3;

#import "ZanPersonVC.h"
#import "TSActiveModel.h"

@interface ZanPersonVC ()
{
    int i ;
}

@end

@implementation ZanPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = [NSString stringWithFormat:@"%ld个人赞",self.Array.count];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    i = 0;
    [self.Array enumerateObjectsUsingBlock:^(TSActiveModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
//        背景view
        CGFloat VW = Frame.size.width/3;
        NSInteger x = i%3 ;
        CGFloat VX = x * VW ;
        NSInteger y = i/3 ;
        CGFloat VY = y * VW + 64;
        UIView * backView = [[UIView alloc] init];
        backView.frame = CGRectMake(VX, VY, VW, VW+20);
//        backView.backgroundColor = [UIColor grayColor];
//        图片
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(VW/2-40, VW/2-30, 80, 80)];
        image.image = [UIImage imageNamed:model.icon];
        image.layer.cornerRadius = 40;
        image.layer.masksToBounds = YES;
//        用户昵称
        UILabel * label = [[UILabel alloc] init];
        CGFloat maxY = CGRectGetMaxY(image.frame);
        label.frame = CGRectMake(image.frame.origin.x, maxY+5, 80, 16);
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor purpleColor];
        label.text = model.name;
        label.textAlignment = 1;
        
        [backView addSubview:label];
        [backView addSubview:image];
        [self.view addSubview:backView];
        i = i + 1;
    }];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
