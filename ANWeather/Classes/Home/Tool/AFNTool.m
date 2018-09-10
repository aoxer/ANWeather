//
//  AFNTool.m
//
//  Created by 小华 on 2018/8/17.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "AFNTool.h"

@implementation RequestDataModel

@end

@implementation AFNTool


/**
 http管理者

 @return manager
 */
+(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    // 超时时间
    //manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    
    // 声明获取到的数据格式
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    return manager;
}



/**
 POST请求

 @param url
 @param parames 字典参数
 @param success 成功
 @param failure 失败
 */
+(void)postWithURl:(NSString *)url parameters:(NSDictionary *)parames success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFNTool manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        
    [manager POST:url parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        }
    }];
    
}


/**
 GET请求
 
 @param url
 @param parames 字典参数
 @param success 成功
 @param failure 失败
 */
+(void)getWithURl:(NSString *)url parameters:(NSDictionary *)parames success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFNTool manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [manager GET:url parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        }
    }];
    
}

+(void)reqGetWithURl:(NSString *)url
       parameters:(RequestDataModel *)model
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFNTool manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [manager GET:url parameters:model.keyValues progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        }
    }];
    
}

+ (NSString *)getSignKeyWithDict:(NSDictionary *)dict
{
    //把签名文件先清除
    NSMutableDictionary *mDic=[NSMutableDictionary dictionaryWithDictionary:dict];
    if (mDic[@"sign"]) {
        mDic[@"sign"]=nil;
    }
    ANLog(@"%@",mDic);
    
    // 构造最后的签名
    NSArray *array = [mDic allKeys];
    NSMutableArray *copyArray = [NSMutableArray new];
    
    // 剔除值为空的键 这一步就包括了sign
    for (NSString *string in array) {
        
        NSString *str=[NSString stringWithFormat:@"%@",mDic[string]];
        
        if ([str isEqualToString:@""] || str == nil) {
            continue;
        }
        [copyArray addObject:string];
    }
    
    // 将获得的数组按照字母顺序进行排序
    [copyArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableArray *section = [NSMutableArray new];
    for (NSString *key in copyArray) {
        NSString *sec = [NSString stringWithFormat:@"%@=%@", key, mDic[key]];
        [section addObject:sec];
    }
    NSString *joindString = [section componentsJoinedByString:@"&"];
    
    // totalString
    NSString *finalString = [NSString stringWithFormat:@"%@", joindString];
    NSString *ret = [finalString MD5];
    
    return ret;
    
}



@end
