//
//  TSActiveDitailVC.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/11.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds

#import "TSActiveDitailVC.h"
#import "ActiveDetailModel.h"
#import "ActiveDetailCell.h"
#import "DetailHeaderView.h"

#import "TSActiveHeadView.h"
#import "ZanPersonVC.h"

@interface TSActiveDitailVC ()

@property (nonatomic, strong) NSArray * array;

@property (nonatomic, strong) NSArray * headPicArray;

@end

@implementation TSActiveDitailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UITableView alloc] init];
    self.tableView.userInteractionEnabled = YES;
}

-(NSArray *)array
{
    if (_array == nil) {
        _array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Pinglun.plist" ofType:nil]];
        NSMutableArray * Array = [NSMutableArray array];
        [_array enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
            ActiveDetailModel * model = [ActiveDetailModel dateWithDict:dict];
            [Array addObject:model];
        }];
        _array = Array;
    }
    return _array;
}
-(NSArray *)headPicArray
{
    if (_headPicArray == nil) {
//        头像的数组
        NSMutableArray * picArr = [NSMutableArray array];
        [_array enumerateObjectsUsingBlock:^(ActiveDetailModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            [picArr addObject:model.icon];
        }];
        _headPicArray = picArr;
    }
    return _headPicArray;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    headview
    TSActiveHeadView * hhhview = [TSActiveHeadView headview];
    hhhview.model = self.model;
    [hhhview setZanPicArr:self.headPicArray];
    hhhview.frame = CGRectMake(0, 0, 320, hhhview.model.height);
    [self.tableView setTableHeaderView:hhhview];
//    关注
    [hhhview ClickGuanzhu:^{
        [[[UIActionSheet alloc] initWithTitle:@"提示" delegate:nil cancelButtonTitle:@"确定关注此人" destructiveButtonTitle:@"取消" otherButtonTitles:@"确定", nil] showInView:self.view];
    }];
//      跳转点赞人数的页面
    [hhhview ClickZan:^{
        ZanPersonVC * personVc = [[ZanPersonVC alloc] init];
        personVc.Array = self.array;
        [self.navigationController pushViewController:personVc animated:YES];
    }];
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActiveDetailCell * cell = [ActiveDetailCell cellWithTableview:tableView];
    cell.model = self.array[indexPath.row];
    return cell;
}
#pragma mark - tabelviewcell cellheight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSActiveModel * model = self.array[indexPath.row];
    return model.cellHeight;
}
#pragma mark - header delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DetailHeaderView * header = [DetailHeaderView headerViewWithTableView:tableView];
    header.timeTitle.text = @"评论x条";
    return header;
}
#pragma mark - header delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}



@end
