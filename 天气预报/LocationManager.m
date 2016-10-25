//
//  LocationManager.m
//  天气预报
//
//  Created by lisa on 2016/10/22.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import "LocationManager.h"
#import <UIKit/UIKit.h>//判断版本时用

@interface LocationManager()<CLLocationManagerDelegate>
@property(nonatomic, strong) CLLocationManager *manager;
@property(nonatomic, copy) void(^saveLocation)(double lat, double lon);

@end
@implementation LocationManager

//一个类的唯一一个实例对象
+ (id)sharedLocationManager {
    static LocationManager *locationManager = nil;
    if (!locationManager) {
        locationManager = [[LocationManager alloc]init];
    }
    return locationManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [CLLocationManager new];
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            [self.manager requestWhenInUseAuthorization];
        }
        self.manager.delegate = self;
    }
    return self;
}

+ (void)getUserLocation:(void (^)(double, double))locationBlock {
    LocationManager *locationManager = [LocationManager sharedLocationManager];
    [locationManager getUserLocations:locationBlock];
}

- (void)getUserLocations:(void(^)(double, double))locationBlock {
    if ([CLLocationManager locationServicesEnabled]) {
        return;
    }
    _saveLocation = [locationBlock copy];
    self.manager.distanceFilter = 500;
    [self.manager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    _saveLocation(location.coordinate.latitude, location.coordinate.longitude);
}
@end
