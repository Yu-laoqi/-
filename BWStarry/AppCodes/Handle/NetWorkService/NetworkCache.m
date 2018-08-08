//
//  NetworkCache.m
//  BWStarry
//
//  Created by 尹晓腾 on 2018/6/11.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "NetworkCache.h"
#import "YYCache.h"


@implementation NetworkCache

#pragma mark --------- 第三方对象的初始化 -----------
// 用于缓存数据的第三方的对象
static YYCache *_dataCache;
// 用于缓存数据的文件名称
static NSString *const NetworkResponseCache = @"NetworkResponseCache";

// 类的初始化方法
+(void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

#pragma mark --------- 对外接口实现 -----------
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize
{
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache
{
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    // 如果没有参数，直接返回网址字符串
    if(!parameters){
        return URL;
    };
    
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    
    return cacheKey;
}


@end










