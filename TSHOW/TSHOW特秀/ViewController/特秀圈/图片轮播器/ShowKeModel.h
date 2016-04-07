//
//  ShowKeModel.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/10.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowKeModel : NSObject

@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * signtext;
@property (nonatomic, copy) NSString * gender;
@property (nonatomic, copy) NSString * distance;
@property (nonatomic, copy) NSString * constellation;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)dateWithDict:(NSDictionary *)dict;

@end
