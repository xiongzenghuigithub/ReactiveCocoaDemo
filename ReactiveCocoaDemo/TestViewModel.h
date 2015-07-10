//
//  TestViewModel.h
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/24.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "RVMViewModel.h"
#import "TCWeather.h"

@interface TestViewModel : RVMViewModel

//封装成一个实体类？
@property (nonatomic, readonly, copy) NSString *cityName;
@property (nonatomic, readonly, copy) NSString *condition;
@property (nonatomic, readonly, copy) NSString *iconName;
@property (nonatomic, readonly, copy) NSNumber *currentTemperature;
@property (nonatomic, readonly, copy) NSNumber *minTemperature;
@property (nonatomic, readonly, copy) NSNumber *maxTemperature;

- (instancetype)initWithWeather:(TCWeather *)weather;

@end
