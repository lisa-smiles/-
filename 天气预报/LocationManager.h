//
//  LocationManager.h
//  天气预报
//
//  Created by lisa on 2016/10/22.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^saveLocationBlock)(double lat, double lon);
@interface LocationManager : NSObject

+ (void)getUserLocation:(void(^)(double lat, double lon))locationBlock;


@end
