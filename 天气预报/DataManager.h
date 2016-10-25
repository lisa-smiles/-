//
//  DataManager.h
//  天气预报
//
//  Created by lisa on 2016/10/21.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+ (NSArray *)getAllCitygroups;
+ (NSArray *)getDailyData;
@end
