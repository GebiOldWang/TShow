//
//  UIBarButtonItem+Extension.h
//  TShow特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
