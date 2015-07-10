//
//  TestViewModel.m
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/24.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "TestViewModel.h"

@implementation TestViewModel

- (instancetype)initWithWeather:(TCWeather *)weather
{
    self = [super init];
    if (nil == self) { return nil; }
    
    _cityName = [weather.locationName copy];
    _condition = [weather.condition copy];
    _iconName = [weather.imageName copy];
    _currentTemperature = [weather.temperature copy];
    _minTemperature = [weather.tempLow copy];
    _maxTemperature = [weather.tempHigh copy];
    
    return self;
}

- (NSUInteger)hash
{
    return (
            self.cityName.hash ^
            self.condition.hash ^
            self.iconName.hash ^
            self.currentTemperature.hash ^
            self.maxTemperature.hash ^
            self.minTemperature.hash
            );
}

@end
