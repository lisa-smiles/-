//
//  DataManager.m
//  天气预报
//
//  Created by lisa on 2016/10/21.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import "DataManager.h"
#import "CityGroups.h"
@implementation DataManager

static NSArray *_cityGroupsArray = nil;
+ (NSArray *)getAllCitygroups {
    if (!_cityGroupsArray) {
        _cityGroupsArray = [[self alloc] getCityGroups];;
    }
    return _cityGroupsArray;
}

- (NSArray *)getCityGroups {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
    NSArray *cityGroupArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *dic in cityGroupArray) {
        CityGroups *cityGroup = [CityGroups new];
        [cityGroup setValuesForKeysWithDictionary:dic];
        [mutArray addObject:cityGroup];
    }
    return [mutArray copy];
}


@end
