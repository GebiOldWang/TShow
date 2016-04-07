//
//  TSTabBar.m
//  TShow特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TSTabBar.h"
#import "PushDongTaiVC.h"

@interface TSTabBar()

@property (nonatomic, weak) UIButton * addBtn;
@end


@implementation TSTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        UIButton * addBtn = [UIButton buttonWithType:0];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        addBtn.size = addBtn.currentBackgroundImage.size;
        [addBtn addTarget:self action:@selector(addActive) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        self.addBtn = addBtn;
    }
    return self;
}

- (void)addActive
{
    PushDongTaiVC * pushdongtai = [[PushDongTaiVC alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pushdongtai animated:NO completion:nil] ;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.addBtn.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.addBtn) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
    }
}

@end
