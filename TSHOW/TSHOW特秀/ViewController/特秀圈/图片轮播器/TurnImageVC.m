//
//  TurnImageVC.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/11.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define viewW [UIScreen mainScreen].bounds.size.width
#define viewH [UIScreen mainScreen].bounds.size.height
#define Frame [UIScreen mainScreen].bounds

#import "TurnImageVC.h"

@interface TurnImageVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIScrollView * scrollview ;
@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation TurnImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:Frame];
    self.scrollview = scrollView;
    self.scrollview.backgroundColor = [UIColor blackColor];
    [self.scrollview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)]];
    //        取得点击的图片的路径
    for (int i=0; i< self.array.count; i++) {
        NSString * imgStr = self.array[i];
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.contentMode =  UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(viewW*i, (viewH-viewW)* 0.5, viewW, viewW);
//        点击事件的开启
        imageView.userInteractionEnabled = YES;
//        旋转
        UIRotationGestureRecognizer * rotaion =[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
        rotaion.delegate = self;
        [imageView addGestureRecognizer:rotaion];
//        放大缩小
        UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(fangda:)];
        pinch.delegate = self;
        [imageView addGestureRecognizer:pinch];
        
        [imageView setImage:[UIImage imageNamed:imgStr]];
        self.imageView = imageView;
        [self.scrollview addSubview:self.imageView];
    }
//设置图片左右滑动的范围
    self.scrollview.contentSize=CGSizeMake(viewW * self.array.count, viewH);
    self.scrollview.contentOffset=CGPointMake(self.index * viewW, 0);
//    分页
    self.scrollview.pagingEnabled = YES;
    [self.view addSubview:self.scrollview];
}

-(NSArray *)array
{
    if (_array == nil) {
        _array = [[NSArray alloc] init];
    }
    return _array;
}
-(void)fangda:(UIPinchGestureRecognizer *)pinch
{

    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    // 复位
    pinch.scale = 1;
 
}
// 是否允许同时支持多个手势，默认是不支持多个手势
// 返回yes表示支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// 默认传递的旋转的角度都是相对于最开始的位置
- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    // 复位
    rotation.rotation = 0;
    // 获取手势旋转的角度
    NSLog(@"%f",rotation.rotation);
}
-(void)touch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - <UIScrollViewDelegate>
/**
 这个方法的返回值决定了要缩放的内容(返回值只能是UIScrollView的子控件)
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
//    NSLog(@"缩放ing-----%f", scrollView.zoomScale);
}
@end
