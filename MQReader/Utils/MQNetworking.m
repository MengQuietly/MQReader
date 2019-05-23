//
//  MQNetworking.m
//  MQReader
//
//  Created by Meng on 2018/5/7.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQNetworking.h"
#import <AFNetworking.h>
#import "MQAPIConstants.h"
#import <AFNetworkActivityIndicatorManager.h>




@implementation MQNetworking

///getNetWorkStatus
+(void)getNetWorkStatus {
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *mangerStatus = [AFNetworkReachabilityManager sharedManager];
    //开启监听，记得开启，不然不走block
    [mangerStatus startMonitoring];
    
    __weak typeof(self) weakSelf = self;
    //2.监听改变
    [mangerStatus setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ((status == -1) || (status == 0)) {
            
            // 取消之前的所有请求，manager 还可以发请求 （注意：控制器销毁时调用）
            [[MQNetworking AFHTTPSessionManager].tasks makeObjectsPerformSelector:@selector(cancel)];
            //弹出提示框
            [strongSelf showWarningView];
            return;
        }
    }];
}

#pragma mark---网络断开时弹出提示框
+(void)showWarningView {
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络断开，请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    [alter show];
}
#pragma mark---alertView点击事件
+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        NSLog(@"取消");
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

+ (AFHTTPSessionManager *)AFHTTPSessionManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
//        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"]; // @"text/html" && @"text/plain"
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"isfree"];
        [manager.requestSerializer setValue:@"1234491385" forHTTPHeaderField:@"freeappid"];
    });
    
    return manager;
}


#pragma mark - baisi
+ (void) request:(MQRequestType)method urlString:(NSString *)urlString  parameters:(id)parameters finished:(void(^)(id ,NSError *))finished{
    
    AFHTTPSessionManager *manager = [MQNetworking AFHTTPSessionManager];
    
    // 取消之前的所有请求，manager 还可以发请求 （注意：控制器销毁时调用）
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    // 取消请求后，manager 再也不可用发请求了
//    [self.manager invalidateSessionCancelingTasks:YES];
    
}
+ (void)netrequest:(MQRequestType)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished{
    AFHTTPSessionManager *manager = [MQNetworking AFHTTPSessionManager];
    
    
}

#pragma mark - MengTX
/** GET 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2*/
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    
    
}

/** POST 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    
}


#pragma mark - myone3

+ (NSString *)urlWithApi:(NSString *)api {
    return [NSString stringWithFormat:@"%@%@", MQServerAddress, api];
}

+ (void)postWithApi:(NSString *)api success:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    AFHTTPSessionManager *manager = [MQNetworking AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [manager POST:[MQNetworking urlWithApi:api] parameters:nil constructingBodyWithBlock:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DDLogDebug(@"operation = %@, error = %@", task, error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}

+ (void)getWithURI:(NSString *)api success:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    AFHTTPSessionManager *manager = [MQNetworking AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [manager GET:[MQNetworking urlWithApi:api] parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"=GET 获取的数据==========%@",responseObject);
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DDLogDebug(@"operation = %@, error = %@", task, error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}

#pragma mark - 分类
+ (void)requestCategoryWithSuccessBook:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    [MQNetworking getWithURI:MQCategoryShow success:successBlock fail:failBlock];
}

#pragma mark - 找书-排行榜
+ (void)requestRankWithFindBook:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    [MQNetworking getWithURI:MQFindRank success:successBlock fail:failBlock];
}

//MQFindRankWithType

// 男 潜力榜 周榜 http://api.zhuishushenqi.com/ranking/54d42e72d9de23382e6877fb?isfree=1&freeappid=1234491385
// 男 潜力榜 月榜 http://api.zhuishushenqi.com/ranking/564eee3ea82e3ada6f14b195?isfree=1&freeappid=1234491385
// 男 潜力榜 总榜 http://api.zhuishushenqi.com/ranking/564eeeabed24953671f2a577?isfree=1&freeappid=1234491385

//女 好评榜 周榜 http://api.zhuishushenqi.com/ranking/5a684551fc84c2b8efaab179?isfree=1&freeappid=1234491385

// 排行榜列表-item 类型筛选 点击
+ (void)requestRankWithGender:(MQGenderType) genderType findType:(NSString *)findType major:(NSString *) itemStr successBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    
    NSString *genderTypeStr = @"male";
    if (genderType == MQGenderTypeMale) {
        genderTypeStr = @"female";
    }else if (genderType == MQGenderTypePicture) {
        genderTypeStr = @"picture";
    }else{
        genderTypeStr = @"male";
    }
    
    [MQNetworking getWithURI:[NSString stringWithFormat:@"%@/%@", MQCategories, genderTypeStr] success:successBlock fail:failBlock];
    
    
}

// 排行榜列表-item点击
+ (void)requestSearchTypeRankWithGender:(MQGenderType) genderType findType:(NSString *)findType major:(NSString *) itemStr successBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    
    NSString *genderTypeStr = @"male";
    if (genderType == MQGenderTypeMale) {
        genderTypeStr = @"female";
    }else if (genderType == MQGenderTypePicture) {
        genderTypeStr = @"picture";
    }else{
        genderTypeStr = @"male";
    }
    
    [MQNetworking getWithURI:[NSString stringWithFormat:@"%@/%@", MQCategories, genderTypeStr] success:successBlock fail:failBlock];
    
    
}



@end
