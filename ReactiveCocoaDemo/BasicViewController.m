//
//  BasicViewController.m
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/23.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "BasicViewController.h"
#import "SessionManager.h"

@interface BasicViewController ()

@property (nonatomic, strong) SessionManager *manager;

@property (nonatomic, strong) RACCommand *loginCommand;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) NSString *value2;
@property (nonatomic, copy) NSString *value3;
@property (nonatomic, copy) NSString *value4;

@end

@implementation BasicViewController {
    UIButton *button;
    UITextField *txtfiled1;
    UITextField *txtfiled2;
    UITextField *txtfiled3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    txtfiled1 = [[UITextField alloc] init];
    txtfiled2 = [[UITextField alloc] init];
    txtfiled3 = [[UITextField alloc] init];
    txtfiled1.layer.borderWidth = 1;
    txtfiled2.layer.borderWidth = 1;
    txtfiled3.layer.borderWidth = 1;
    [self.view addSubview:txtfiled1];
    [self.view addSubview:txtfiled2];
    [self.view addSubview:txtfiled3];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(@44);
    }];
    
    [txtfiled1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(button.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [txtfiled2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(txtfiled1.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [txtfiled3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(txtfiled2.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [self makeSingnal];
}

- (void)makeSingnal {
//    [self observeInstanceProperties];
//    [self combineSignal];
//    [self buttonSignal];
//    [self command];
//    [self mergeArraySignals];
//    [self flattenMapNewSignal];
//    [self notification];
}

- (void)observeInstanceProperties {
    //1. 直接观测改变后，消费信号
//    [RACObserve(self, value) subscribeNext:^(id x) {
//        
//    }];
    
    //2. 观测到改变后，使用filter方法，过滤没用的值
    [[RACObserve(self, value) filter:^BOOL(NSString *newValue) {
        return [newValue hasPrefix:@"j"];
    }] subscribeNext:^(id x) {
        NSLog(@"newValue = %@\n", x);
    }];
    
    //3. 组合观测属性值
    [RACSignal combineLatest:@[RACObserve(self, value2),
                               RACObserve(self, value3),
                               RACObserve(self, value4)]
                      reduce:^id(NSString *txt1, NSString *txt2, NSString *txt3){
                          BOOL flag = (txt1.length == 5 && txt2.length == 5 && txt3.length == 5);
                          if (flag) {
                              return @YES;
                          } else {
                              return @NO;
                          }
                      }];
}

- (void)combineSignal {
    //当右侧信号管道中得数据，符合一定规则时，将reduce回调返回的值，赋值给左侧 button的enabled属性
    RAC(button, enabled) = [RACSignal combineLatest:@[txtfiled1.rac_textSignal,
                                                      txtfiled2.rac_textSignal,
                                                      txtfiled3.rac_textSignal]
                                             reduce:^id(NSString *txt1, NSString *txt2, NSString *txt3){
                                                 BOOL flag = (txt1.length == 5 && txt2.length == 5 && txt3.length == 5);
                                                 if (flag) {
                                                     self.value = [NSString stringWithFormat:@"%@%@%@", txt1, txt2, txt3];
                                                     return @YES;
                                                 }else {
                                                     return @NO;
                                                 }
                                             }];
}

- (void)buttonSignal {
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"button click .... \n");
    }];
}

- (void)command {
    @weakify(self);
    
    //1. 创建RACCommand对象
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^(id sender) {
        @strongify(self);
        
        //调用Api方法，返回一个RACSignal信号对象
        return [self.manager login];
    }];
    
    //2. 消费RACCommand对象的信号对象
    [self.loginCommand.executionSignals subscribeNext:^(RACSignal *signal) {
        [signal subscribeCompleted:^{
            NSLog(@"Logged in successfully!");
        }];
    }];
}

- (void)mergeArraySignals {
    
    //将两个信号对象，合并成一个新的信号对象
    [[RACSignal merge:@[
                        [self.manager fetchNews],
                        [self.manager fetchTopics]
                       ]]
        subscribeNext:^(id value) {
            NSLog(@"合并后的新的信号对象的管道数据 = %@\n", value);
        }];
}

- (void)flattenMapNewSignal {
    
    //1. 原始网络请求信号对象
    RACSignal *signal =  [self.manager login];
    
    //2. 创建一个新的信号对象，
    //数据List1【将所有从缓存加载的数据】
    //数据List2【网络请求信号对象的数据】
    //将List1与List2进行合并，放到这个新的信号对象的管道中
    
    RACSignal *flattenMap1Signal = [signal flattenMap:^RACStream *(User *user) {//信号对象中取出User对象
        
                                        //得到User对象的缓存数据List信号对象
                                        return [self.manager loadCacheMessage];
                                    }];
    
    //3.取出最后一条Message对象，放到一个新的信号对象
    RACSignal *flattenMap2Signal = [flattenMap1Signal flattenMap:^RACStream *(NSArray *dataList) {
        return [self.manager loadAfterMessage:[dataList lastObject]];
    }];
    
    //4. 得到最新信号对象的数据
    [flattenMap2Signal subscribeNext:^(NSArray *newMessages) {
        NSLog(@"New messages: %@", newMessages);
    } completed:^{
        NSLog(@"Fetched all messages.");
    }];
    
}

- (void)notification {
    RAC(button, enabled) = [NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil];
}

- (void)mapValue {
    
    //对某个信号对象的管道数据，进行修改加工，返回新的值
    
    [RACObserve(self, value2) map:^id(NSString *value) {
        return [value stringByAppendingString:@"修改后的值"];
    }];
}

- (void)serverRequest {
    
    //1. 获取当前登录用户对象的信号对象
    RACSignal *signal = [self.manager login];
    
    //2. then 返回一个新的信号对象
    RACSignal *mergeCacheDataSignal = [signal flattenMap:^RACStream *(User *loginUser) {
        //取出当前登录User对象的本次缓存的meesageList
        return [self.manager loadCacheMessage];
    }];
    
    //3. flattenMap 对给定的信号对象的管道数据，进行加工修改
    RACSignal *flattenMapSiganl = [mergeCacheDataSignal flattenMap:^RACStream *(NSArray *cacheMessages) {
        
        //取出之前信号对象的管道数据，进行修改处理
        id lastMsg = cacheMessages.lastObject;
        
        //将修改后的数据，放到另一个新创建的信号对象的管道中去
        return [self.manager loadAfterMessage:lastMsg];
    }];
    
    //4. 消费信号
    [flattenMapSiganl subscribeNext:^(id x) {
        NSLog(@"获取到得管道数据 = %@\n", x);
    } error:^(NSError *error) {
        NSLog(@"获取到得管道数据 = %@\n", error);
    } completed:^{
        NSLog(@"信号消费完毕\n");
    }];
}


- (void)bindDataFromManager {
    
    //将viewModel对象或manager对象 属性的值，绑定给其他对象的属性
    
    RAC(self, value) = RACObserve(self.manager, listCount);
    
}

@end
