//
//  PushDongTaiVC.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/13.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds
#define viewW [UIScreen mainScreen].bounds.size.width
#define viewH [UIScreen mainScreen].bounds.size.height

#import "PushDongTaiVC.h"
#import "VerticalButton.h"
#import <POP.h>
#import "TZImagePickerController.h"
#import "AFNetworking.h"


static CGFloat const AnimationDelay = 0.1;
static CGFloat const SpringFactor = 10;

@interface PushDongTaiVC ()<TZImagePickerControllerDelegate>

@end

@implementation PushDongTaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (viewH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (viewW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        VerticalButton *button = [[VerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - viewH;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = SpringFactor;
        anim.springSpeed = SpringFactor;
        anim.beginTime = CACurrentMediaTime() + AnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = viewW * 0.5;
    CGFloat centerEndY = viewH * 0.2;
    CGFloat centerBeginY = centerEndY - viewH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * AnimationDelay;
    anim.springBounciness = SpringFactor;
    anim.springSpeed = SpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            TSLog(@"发视频");
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //    }
            //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
            //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
            //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            [[UIApplication  sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
        } else if (button.tag == 1) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
            // You can get the photos by block, the same as by delegate.
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray *photos, NSArray *assets) {
                TSLog(@"%@",photos);
                UIImage * image = (UIImage *)photos.firstObject;
                NSData *data = UIImagePNGRepresentation(image);
                //
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
                [manager POST:@"http://192.168.1.79/texiu/index.php/ios/Publish/save" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    // 上传文件
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                    [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/png"];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                    NSLog(@"%@",responseObject[@"success"]);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * error) {
                    NSLog(@"%@",error);
                }];
                
            }];
            [[UIApplication  sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }];
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + viewH;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * AnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                //                if (completionBlock) {
                //                    completionBlock();
                //                }
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
    
    //    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    //
    //    anim.springBounciness = 20;
    //    anim.springSpeed = 20;
    //    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    //
    //    [self.sloganView pop_addAnimation:anim forKey:nil];
    
    //    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //    anim.beginTime = CACurrentMediaTime() + 1.0;
    //    anim.springBounciness = 20;
    //    anim.springSpeed = 20;
    //    anim.fromValue = @(self.sloganView.layer.position.y);
    //    anim.toValue = @(300);
    //    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
    //        XMGLog(@"-----动画结束");
    //    };
    //    [self.sloganView.layer pop_addAnimation:anim forKey:nil];
}


@end
