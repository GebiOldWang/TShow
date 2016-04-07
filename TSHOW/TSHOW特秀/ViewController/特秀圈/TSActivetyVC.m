//
//  TSActivetyVC.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/9.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define viewW [UIScreen mainScreen].bounds.size.width
#define viewH [UIScreen mainScreen].bounds.size.height
#define Frame [UIScreen mainScreen].bounds

#import "TSActivetyVC.h"
#import "TSActiveModel.h"
#import "TSActiveCell.h"
#import "OWTurnImageView.h"
#import "TurnImageVC.h"

#import "TSActiveDitailVC.h"

@interface TSActivetyVC ()
{
    UIRefreshControl * refreshControl;
}
@property (nonatomic, strong) NSArray * array ;

@property (nonatomic, strong) NSMutableArray *picArray;


@end

@implementation TSActivetyVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    下拉刷新
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    //    轮播器
    OWTurnImageView * turnView = [OWTurnImageView TurnView];
    [turnView loadDataSource:self.picArray ClickImg:^(NSInteger index) {
        NSLog(@"%d",index);
    }];
    [self.tableView setTableHeaderView:turnView];
    
    self.tableView.tableFooterView = [[UITableView alloc] init];
}

- (void)refreshAction:(id)sender{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}
-(NSMutableArray *)picArray
{
    if (_picArray == nil) {
        _picArray = [NSMutableArray array];
        for (int i = 0; i <= 2; i++) {
            NSString * urlStr = [NSString stringWithFormat:@"IMG_026%i.png",i];
            [_picArray addObject:urlStr];
        };
    }
    return _picArray;
}

-(NSArray *)array
{
    if (_array == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Active.plist" ofType:nil];
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * muArr = [NSMutableArray array];
        [dictArray enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
            TSActiveModel * model = [TSActiveModel dateWithDict:dict];
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
    TSActiveCell * cell = [TSActiveCell cellWithTableView:tableView];
    [cell ClickImageIndex:^(NSInteger index) {
//    点击查看大图
        TurnImageVC * turnImage = [[TurnImageVC alloc] init];
        turnImage.array = cell.arr;
        turnImage.index = index;
        turnImage.view.frame = Frame;
        turnImage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [[UIApplication  sharedApplication].keyWindow.rootViewController presentViewController:turnImage animated:YES completion:nil];
    }];
    [cell Clickguanzhu:^(NSInteger index) {
        [[[UIActionSheet alloc] initWithTitle:@"提示" delegate:nil cancelButtonTitle:@"确定关注此人" destructiveButtonTitle:@"取消" otherButtonTitles:@"确定", nil] showInView:self.view];
    }];
    cell.model = self.array[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TSLog(@"%ld",indexPath.row);
    TSActiveCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    TSActiveDitailVC * detailVc = [[TSActiveDitailVC alloc] init];
    detailVc.model = cell.model;
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

//      tableView返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSActiveModel * model = self.array[indexPath.row];
    return model.cellHeight;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;// default is NO
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始摇动手机");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"stop");
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"你摇了你的手机" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"取消");
}

@end
