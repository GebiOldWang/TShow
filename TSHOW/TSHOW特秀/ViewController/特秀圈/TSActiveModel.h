//
//  TSActiveModel.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/7.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSActiveModel : NSObject

@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * picture;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) CGFloat height;
/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)dateWithDict:(NSDictionary *)dict;

@end
