//
//  TabBarViewController.m
//  TShow特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TabBarViewController.h"
#import "TSTabBar.h"

#import "TSCircleNAVC.h"
#import "FindNAVC.h"
#import "MessageNAVC.h"
#import "MineNAVC.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UINavigationBar appearance];
    
    self.tabBar.barTintColor = TSRGBColor(246, 246, 246);
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    TSCircleNAVC  * oneNAV = [storyboard instantiateViewControllerWithIdentifier:@"TSCircle"];
    FindNAVC  * twoNAV = [storyboard instantiateViewControllerWithIdentifier:@"Find"];
    MessageNAVC  * threeNAV = [storyboard instantiateViewControllerWithIdentifier:@"Message"];
    MineNAVC  * fourNAV = [storyboard instantiateViewControllerWithIdentifier:@"Mine"];
    
    
//    [self addChildViewController:oneNAV];
    [self setupChildVc:oneNAV title:@"特秀圈" image:@"bottom_3" selectedImage:@"bottom_4"];
    
    [self setupChildVc:twoNAV title:@"发现" image:@"bottom_1" selectedImage:@"bottom_2"];
    
    [self setupChildVc:threeNAV title:@"消息" image:@"bottom_7" selectedImage:@"bottom_8"];
    
    [self setupChildVc:fourNAV title:@"我的" image:@"bottom_9" selectedImage:@"bottom_10"];
    
    // 更换tabBar
    //    self.tabBar = [[XMGTabBar alloc] init];
    [self setValue:[[TSTabBar alloc] init] forKeyPath:@"tabBar"];
    

}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
//    vc.view.backgroundColor = TSGlobalBg;
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:vc];
}


@end
