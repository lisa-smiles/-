//
//  NetworkingManager.m
//  天气预报
//
//  Created by lisa on 2016/10/22.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import "NetworkingManager.h"
#import "AFNetworking.h"

@implementation NetworkingManager
+ (void)sendGetRequestWithUrl:(NSString *)urlStr Withparameters:(NSDictionary *)parmaDict WithSuccessBlock:(successBlock)success withFailuerBlock:(failuerBlock)failuer {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:parmaDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failuer(error);
    }];
}
@end
