//
//  TSNearViewController.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/10.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds

#import "TSNearViewController.h"
#import "ShowFangVC.h"
#import "ShowKeVC.h"

@interface TSNearViewController ()
{
    ShowFangVC * showFang;
    ShowKeVC * showKe;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) UIView *segmentSelectedBar;

@end

@implementation TSNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settingSegmentController];
    [self.segmentView addSubview:self.segmentSelectedBar];
    [self clickSegment:self.segment];
}
- (IBAction)clickSegment:(UISegmentedControl *)sender {
    [self animationSelectedBar:(int)sender.selectedSegmentIndex];
    if (sender.selectedSegmentIndex == 0) {
        showFang = [[ShowFangVC  alloc] init];
        showFang.view.frame = CGRectMake(0, 34, Frame.size.width, self.view.frame.size.height-34);
        [self.view addSubview:showFang.view];
        [self addChildViewController:showFang];
        
        [showKe.view removeFromSuperview];
        [showKe removeFromParentViewController];
    }else{
        showKe = [[ShowKeVC  alloc] init];
        showKe.view.frame = CGRectMake(0, 34, Frame.size.width,self.view.frame.size.height-34);
        [self.view addSubview:showKe.view];
        [self addChildViewController:showKe];
        
        [showFang.view removeFromSuperview];
        [showFang removeFromParentViewController];
    }
}
-(void)settingSegmentController{
    //    设置选中和未选中时字体的颜色和大小
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:TSRGBColor(128, 128, 128)};
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: TSRGBColor(128, 128, 128)};
    [self.segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    [self.segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    
    [self.segment setTintColor:[UIColor clearColor]];
    [self.segment setBackgroundColor:[UIColor clearColor]];
}
#pragma mark - 底部选中条

-(UIView *)segmentSelectedBar{
    CGRect imageFrame = [[UIScreen mainScreen]bounds];
    if (_segmentSelectedBar == nil) {
       UIView * segmentSelectedBar = [[UIView alloc]initWithFrame:CGRectMake(0, 32, imageFrame.size.width / 2, 2)];
        segmentSelectedBar.backgroundColor = [UIColor clearColor];
        //        添加一个view
        CGFloat blueW = segmentSelectedBar.frame.size.width * 0.8;
        CGFloat blueH = segmentSelectedBar.frame.size.height;
        CGFloat blueX = (segmentSelectedBar.frame.size.width-blueW)/2;
        CGFloat blueY = 0;
        UIView * blueView = [[UIView alloc] initWithFrame:CGRectMake(blueX, blueY, blueW, blueH)];
        blueView.backgroundColor = TSRGBColor(128, 128, 128);
        [segmentSelectedBar addSubview:blueView];
        _segmentSelectedBar = segmentSelectedBar;
        [self.segmentView addSubview:_segmentSelectedBar];
    }
    return _segmentSelectedBar;
}


#pragma mark - 选中条动画

-(void)animationSelectedBar:(int)selectedIndex{
    float x =self.segmentSelectedBar.frame.size.width * selectedIndex;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.segmentSelectedBar.frame = CGRectMake(x , self.segmentSelectedBar.frame.origin.y, self.segmentSelectedBar.frame.size.width, self.segmentSelectedBar.frame.size.height);
    }];
}



@end
