//
//  SessionManager.m
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/23.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager

+ (instancetype)sharedManager {
    static SessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SessionManager alloc] init];
    });
    return manager;
}

- (RACSignal *)login {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //请求服务器，json -》 User实体类对象
        User *user = [[User alloc] init];
        user.uid = @"137248395";
        user.name = @"zhangsan001";
        
        [subscriber sendNext:user];
        
        return nil;
    }];
}

- (RACSignal *)loadCacheMessage {
    return nil;
}

- (RACSignal*)loadAfterMessage:(id)lastMessage {
    return nil;
}

- (RACSignal *)fetchNews {
    return nil;
}

- (RACSignal *)fetchTopics {
    return nil;
}

@end
