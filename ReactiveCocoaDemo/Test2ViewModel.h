//
//  Test2ViewModel.h
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/24.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "RVMViewModel.h"

@interface Test2ViewModel : RVMViewModel

//服务器数据List
@property (nonatomic, copy, readonly) NSArray *dataList;

//加载服务器操作
@property (nonatomic, strong, readonly) RACCommand *fetchListCommand;


@end
