//
//  TemperatureData.m
//  天气预报
//
//  Created by lisa on 2016/10/22.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import "TemperatureData.h"

@implementation TemperatureData
+ (TemperatureData *)getTemperatureData:(id)responseObject {
    return [[self alloc] getTmperatureData:responseObject];
}

- (TemperatureData *)getTmperatureData:(id)responseObject {
    NSString *currentTemperature = responseObject[@"data"][@"current_condition"][0][@"temp_C"];
    self.weatherTemp = [NSString stringWithFormat:@"%@˚",currentTemperature];
    self.weatherDesc = responseObject[@"data"][@"current_condition"][0][@"weatherDesc"][0][@"value"];
    self.iconUrlStr = responseObject[@"data"][@"current_condition"][0][@"weatherIconUrl"][0][@"value"];
    self.maxTemp = responseObject[@"data"][@"weather"][0][@"maxtempC"];
    self.minTemp = responseObject[@"data"][@"weather"][0][@"mintempC"];
    
    return self;
}
            
            
            
            
@end
