//
//  Test2ViewModel.m
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/24.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "Test2ViewModel.h"
#import <YTKRequest.h>

@implementation Test2ViewModel

- (instancetype)init {
    self = [self init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    //1. 初始化command对象，使用一个信号来激活这个CMD
    _fetchListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self fetchListFromServer];
    }];
    
    //2. 设置当前ViewModel对象，被激活时候的回调操作
    [self.didBecomeActiveSignal subscribeNext:^(Test2ViewModel *viewModel) {
        [viewModel.fetchListCommand execute:nil];
    }];
}

- (RACSignal *)fetchListFromServer {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        YTKRequest *request = [[YTKRequest alloc] init];
        
        [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            //成功回调
            [subscriber sendNext:[request responseJSONObject]];
            [subscriber sendCompleted];
            
        } failure:^(YTKBaseRequest *request) {
            
            //失败回调
            [subscriber sendError:request.requestOperation.error];
        }];
        
        return nil;
    }];
}



@end
