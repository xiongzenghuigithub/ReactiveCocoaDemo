//
//  DemoViewController.m
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/25.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "DemoViewController.h"
#import "Test3ViewModel.h"

@interface DemoViewController ()

@property (nonatomic, strong) Test3ViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)bindDataSourceFromVieModel {
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark - 一个TableView里面有多种类型的cell

/*
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 取出当前cell显示的数据对象
    id data = [_viewModel dataAtIndexPath:indexPath];
    
    //2. 根据数据对象的类型，获取对应类型的cell对象
    id cell = nil;
    
    if ([data isKindOfClass:[类型1 Class]]) {
        cell = [self cellForRating:value indexPath:indexPath];
    } else if ([data isKindOfClass:[类型2 Class]]) {
        cell = [self detailCellForKey:key value:value];
    }
    
    //3.
    //cell 设置数据
    
    //4.
    return cell;
}

- (Cell1 *)cellForRating:(NSNumber *)rating
                    indexPath:(NSIndexPath *)indexPath
{
    // 创建类型1的cell
}

- (Cell2 *)detailCellForKey:(NSString *)key
                                value:(id)value
{
    // 创建类型2的cell
}
 */

@end
