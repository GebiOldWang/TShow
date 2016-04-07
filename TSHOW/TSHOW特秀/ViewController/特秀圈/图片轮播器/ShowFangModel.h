//
//  ShowFangModel.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/10.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowFangModel : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *spend;
@property (copy, nonatomic) NSString *distance;

@property (copy, nonatomic) NSString *hot;
@property (copy, nonatomic) NSString *cengKaNum;
@property (copy, nonatomic) NSString *shaiKaNum;
@property (copy, nonatomic) NSString *activetyNum;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)dateWithDict:(NSDictionary *)dict;

@end
