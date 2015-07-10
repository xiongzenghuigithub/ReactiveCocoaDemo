//
//  SessionManager.h
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/23.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "User.h"

@interface SessionManager : AFHTTPSessionManager

@property (nonatomic, assign) NSInteger listCount;

+ (instancetype)sharedManager;

- (RACSignal*)login;

//加载User对象的缓存数据List
- (RACSignal*)loadCacheMessage;

- (RACSignal*)loadAfterMessage:(id)lastMessage;

- (RACSignal*)fetchNews;
- (RACSignal*)fetchTopics;

@end
