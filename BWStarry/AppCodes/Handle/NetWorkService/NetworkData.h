//
//  NetworkData.h
//  BWStarry
//
//  Created by 尹晓腾 on 2018/6/11.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义一个用于网络数据回传的Block类型
typedef void(^NetworkDataPass)(id,BOOL);

// 定义表示缓存策略的枚举
typedef NS_ENUM(NSUInteger, ClientRequestCachePolicy){
    ClientReturnCacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据
    ClientReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    ClientReturnCacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    ClientReturnCacheDataDontLoad,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};

@interface NetworkData : NSObject

// 判断是否需要重新请求网络数据的符号
@property(nonatomic,assign)BOOL reloadNetWorkData;

// 实例化NetworkData对象的类方法
+(instancetype)getInstance;


/**
 * 使用GET方式请求网络数据
 * 参数 1 - urlStr : 网址字符串
 * 参数 2 - paramDic : 参数字典
 * 参数 3 - pass : 用于回传数据的代码块
 */
-(void)GET:(NSString *)urlStr params:(NSDictionary *)paramDic completion:(NetworkDataPass)pass;

/**
 * 使用GET方式请求网络数据，带缓存策略
 * 参数 1 - urlStr : 网址字符串
 * 参数 2 - paramDic : 参数字典
 * 参数 3 - cacheType : 缓存策略
 * 参数 4 - pass : 用于回传数据的代码块
 */
-(void)GET:(NSString *)urlStr params:(NSDictionary *)paramDic cacheType:(ClientRequestCachePolicy)cacheType completion:(NetworkDataPass)pass;

/**
 * 使用POST方式请求网络数据
 * 参数 1 - urlStr : 网址字符串
 * 参数 2 - paramDic : 参数字典
 * 参数 3 - pass : 用于回传数据的代码块
 */
-(void)POST:(NSString *)urlStr params:(NSDictionary *)paramDic completion:(NetworkDataPass)pass;

/**
 * 使用POST方式请求网络数据,带缓存策略
 * 参数 1 - urlStr : 网址字符串
 * 参数 2 - paramDic : 参数字典
 * 参数 3 - cacheType : 缓存策略
 * 参数 4 - pass : 用于回传数据的代码块
 */
-(void)POST:(NSString *)urlStr params:(NSDictionary *)paramDic cacheType:(ClientRequestCachePolicy)cacheType completion:(NetworkDataPass)pass;
@end








