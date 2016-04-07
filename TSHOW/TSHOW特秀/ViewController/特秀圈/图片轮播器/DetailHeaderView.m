//
//  DetailHeaderView.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    DetailHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[DetailHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel * timeTitle = [[UILabel alloc] init];
        timeTitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:timeTitle];
        self.timeTitle = timeTitle;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 1.设置frame
    self.timeTitle.frame = CGRectMake(12, 0, self.bounds.size.width-20, self.bounds.size.height);
    self.timeTitle.font = [UIFont systemFontOfSize:13];
}


@end
