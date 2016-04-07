//
//  ShowKeVC.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/10.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "ShowKeVC.h"
#import "ShowKeCell.h"
#import "ShowKeModel.h"

@interface ShowKeVC ()
{
    UIRefreshControl * refreshControl;
}
@property (nonatomic, strong) NSArray * array ;


@end

@implementation ShowKeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    下拉刷新
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.tableView.tableFooterView = [[UITableView alloc] init];
}
- (void)refreshAction:(id)sender{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

-(NSArray *)array
{
    if (_array == nil) {
        _array = [[NSArray alloc] init];
        NSString * path = [[NSBundle mainBundle]pathForResource:@"Near.plist" ofType:nil];
        NSArray * arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * muArr = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
            ShowKeModel * model = [ShowKeModel dateWithDict:dict];
            [muArr addObject:model];
        }];
        _array = muArr;
    }
    return _array;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowKeCell * cell = [ShowKeCell cellWithTableView:tableView];
    cell.model = self.array[indexPath.row];
    return cell;
}
//      tableView返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
@end
