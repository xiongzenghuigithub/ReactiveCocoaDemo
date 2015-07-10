//
//  Test3ViewModel.h
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/24.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "RVMViewModel.h"

@interface Test3ViewModel : RVMViewModel 

//向外界公开暴露可以订阅的信号对象
@property (nonatomic, strong, readonly) RACSubject *fetchListSignal;

//Api方法
- (RACSignal *)fetchListFromServer;

//提供给控制器的tableview的数据源
- (NSInteger)sectionCount;
- (NSInteger)rowCountInSection:(NSInteger)section;
- (id)dataAtIndexPath:(NSIndexPath *)indexPath;


@end
