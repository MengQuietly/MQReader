//
//  MQNetworking.h
//  MQReader
//
//  Created by Meng on 2018/5/7.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

// 性别
typedef NS_ENUM(NSUInteger, MQGenderType) {
    MQGenderTypeFemale, //女
    MQGenderTypeMale, // 男
    MQGenderTypePicture, // 理想
};

typedef NS_ENUM(NSUInteger, MQRequestType) {
    MQRequestTypePost,
    MQRequestTypeGet
};


// 成功，失败 block
typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailBlock)(NSError *error);

@interface MQNetworking : NSObject

#pragma mark - baisi
+ (void) request:(MQRequestType)method urlString:(NSString *)urlString  parameters:(id)parameters finished:(void(^)(id ,NSError *))finished;
+ (void)netrequest:(MQRequestType)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished;

#pragma mark - MengTX
/** GET 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2*/
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/** POST 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - myone3

// 排行榜列表
+ (void)requestRankWithFindBook:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
// 排行榜列表-item点击
+ (void)requestSearchTypeRankWithGender:(MQGenderType) genderType findType:(NSString *)findType major:(NSString *) itemStr successBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
// 分类
+ (void)requestCategoryWithSuccessBook:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

@end
