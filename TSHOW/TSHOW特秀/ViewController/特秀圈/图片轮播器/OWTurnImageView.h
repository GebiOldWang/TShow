//
//  OWTurnImageView.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/9.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

typedef void (^ClickBlock)(NSInteger index) ;

#import <UIKit/UIKit.h>

@interface OWTurnImageView : UIView

+ (instancetype)TurnView;

/** 图片名字 */
@property (nonatomic, strong) NSArray *imageNames;
/** 其他圆点颜色 */
@property (nonatomic, strong) UIColor *otherColor;
/** 当前圆点颜色 */
@property (nonatomic, strong) UIColor *currentColor;

//@property (nonatomic, copy) void (^ClickBlock)(NSInteger index);
@property (nonatomic, copy) ClickBlock block;

- (void)loadDataSource:(NSArray *)imageArray ClickImg:(ClickBlock)block;

@end
