//
//  NetworkingManager.h
//  天气预报
//
//  Created by lisa on 2016/10/22.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id responseObject);
typedef void(^failuerBlock)(NSError *err);
@interface NetworkingManager : NSObject

+ (void)sendGetRequestWithUrl:(NSString *)urlStr Withparameters:(NSDictionary *)parmaDict WithSuccessBlock:(successBlock)success withFailuerBlock:(failuerBlock)failuer;

@end
