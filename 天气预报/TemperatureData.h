//
//  TemperatureData.h
//  天气预报
//
//  Created by lisa on 2016/10/22.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemperatureData : NSObject
//城市名字
@property (nonatomic, strong) NSString *cityName;
//天气图标url对应string
@property (nonatomic, strong) NSString *iconUrlStr;
//当前天气的描述
@property (nonatomic, strong) NSString *weatherDesc;
//当前天气的温度
@property (nonatomic, strong) NSString *weatherTemp;
//最高温度
@property (nonatomic, strong) NSString *maxTemp;
//最低温度
@property (nonatomic, strong) NSString *minTemp;

+ (TemperatureData *)getTemperatureData:(id)responseObject;

@end
