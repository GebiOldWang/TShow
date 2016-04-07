//
//  TSActiveModel.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/7.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TSActiveModel.h"

@implementation TSActiveModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)dateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
