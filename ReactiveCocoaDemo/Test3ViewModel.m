//
//  Test3ViewModel.m
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/24.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "Test3ViewModel.h"
#import <YTKRequest.h>

@implementation Test3ViewModel

- (instancetype)init {
    self = [self init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    //初始化信号
    _fetchListSignal = [[RACSubject subject] setNameWithFormat:@"信号对象的名字"];
}

//外界都可以调用，但是一个调用后，希望其他人可以同时也作出响应
- (RACSignal *)fetchListFromServer {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        YTKRequest *request = [[YTKRequest alloc] init];
        
        [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            //成功回调
            [subscriber sendNext:[request responseJSONObject]];
            
            //同时将服务器数据存入外界公开订阅的信号，以便其他信号订阅者同时做出响应
            [_fetchListSignal sendNext:[request responseJSONObject]];
            
            //发送完毕
            [subscriber sendCompleted];
            
        } failure:^(YTKBaseRequest *request) {
            
            //失败回调
            [subscriber sendError:request.requestOperation.error];
        }];
        
        return nil;
    }];
}

@end
