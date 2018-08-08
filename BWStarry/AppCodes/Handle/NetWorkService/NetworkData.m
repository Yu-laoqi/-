//
//  NetworkData.m
//  BWStarry
//
//  Created by 尹晓腾 on 2018/6/11.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "NetworkData.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "NetworkCache.h"

// 整个应用程序的窗口
#define APP_Window [(AppDelegate *)[UIApplication sharedApplication].delegate window]

@implementation NetworkData

#pragma mark ---------------- 错误提示UI ------------------
// 判断有没有网络连接
-(BOOL)isConnectNetWork {
    // 判断网络状态，如果没有网络，给客户提示，退出方法调用
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable && [Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable) {
        [self showMBHudWithMessage:@"网络连接失败，请检查您的网络设置" hide:2.5];
        return NO;
    }
    return YES;
}


// 使用MBProgressHUD做提示框
-(void)showMBHudWithMessage:(NSString *)msg hide:(NSTimeInterval)seconds {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:APP_Window];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = msg;
        [APP_Window addSubview:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:seconds];
    });
}

// 显示MBProgressHUD样式的菊花等待指示器
-(void)showMBProgressHUD {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 做一个等待指示器
        MBProgressHUD *hud = [[MBProgressHUD  alloc] initWithView:APP_Window];
        [APP_Window addSubview:hud];
        hud.tag = 888;
        hud.removeFromSuperViewOnHide = YES;
        [hud show:YES];
    });
}

// 隐藏MBProgressHUD样式的菊花等待指示器
-(void)hideMBProgressHUD{
    
    // 回到UI主线程，
    dispatch_async(dispatch_get_main_queue(), ^{
        // 得到hud的内存
        MBProgressHUD *hud = (MBProgressHUD *)[APP_Window viewWithTag:888];
        [hud hide:YES];
        hud = nil;
    });
}
#pragma mark ------ AFHTTPSessionManager对象 ---------
// 单例，获取AFHttpSession对象
-(AFHTTPSessionManager *)sharedSessionManager {
    static AFHTTPSessionManager *rManager = nil;
    static dispatch_once_t once;
    // 只执行一次的代码块
    dispatch_once(&once, ^{
        rManager = [AFHTTPSessionManager manager];
        // JSON响应器，得到的数据是解析OK的json数据，不用自己再用NSJSONSerilaizer解析二进制数据
        rManager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 设置可以响应的数据格式
        rManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil];
        // 设置超时时长
        [rManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        rManager.requestSerializer.timeoutInterval = 20.f;
        [rManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        //AF自动处理返回null对象的异常
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)rManager.responseSerializer;
        response.removesKeysWithNullValues = YES;
    });
    return rManager;
}


#pragma mark -------- 实例化Network对象的类方法 ---------
// 实例化该类对象的类方法
+(instancetype)getInstance {
    NetworkData *net = [[NetworkData alloc] init];
    return net;
}

#pragma mark ------------- 获取缓存数据 -----------------
// 获取缓存数据
-(void)getCacheData:(ClientRequestCachePolicy)cacheType url:(NSString *)url params:(NSDictionary *)params completion:(NetworkDataPass)completion {
    
    // 获取cache数据
    id cacheObject = [NetworkCache httpCacheForURL:url parameters:params];
    
    // 如果没有网络，将缓存数据返回给controller，并不再请求数据
    if (![self isConnectNetWork]) {
        completion(cacheObject ? cacheObject : nil ,YES);
        self.reloadNetWorkData = NO;
        return;
    }
    
    // 有网络，如果没有缓存数据,请求网络数据
    if (!cacheObject) {
        self.reloadNetWorkData = YES;
        return;
    }
    // 有网络并且有缓存数据，根据不同的缓存策略执行不同操作
    switch (cacheType) {
        case ClientReloadIgnoringLocalCacheData:  // 忽略缓存，重新请求网络数据
        {
            self.reloadNetWorkData = YES;
        }
            break;
        case ClientReturnCacheDataDontLoad: //有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式)
        {
            completion(cacheObject,YES);  // 将数据回传给controller
            self.reloadNetWorkData = NO;
        }
            break;
        case ClientReturnCacheDataElseLoad: //有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
        {
            completion(cacheObject,YES);
            self.reloadNetWorkData = NO;
        }
            break;
        case ClientReturnCacheDataThenLoad: //有缓存就先返回缓存，然后马上再同步请求数据
        {
            completion(cacheObject,YES);
            self.reloadNetWorkData = YES;
        }
            break;
        default:
            break;
    }
}

#pragma mark ------- 对外接口: GET/POST请求网络数据 -------
// 使用GET方式请求网络数据
-(void)GET:(NSString *)urlStr params:(NSDictionary *)paramDic completion:(NetworkDataPass)pass {
    
    // 网络连接判断
    if (![self isConnectNetWork]) {
        return;
    }

    // 指示器开始转动
    [self showMBProgressHUD];
    
    // 使用AFNetworking的GET方式请求网络数据
    [[self sharedSessionManager] GET:urlStr parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        // 停止菊花转动
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideMBProgressHUD];
        });
        
        if (responseObject) {
            // 将json数据缓存
            [NetworkCache setHttpCache:responseObject URL:urlStr parameters:paramDic];
        }
        
        // 将json数据返回
        pass(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 停止菊花转动,给出错误提示
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideMBProgressHUD];
            [self showMBHudWithMessage:@"网络数据错误" hide:2.0];
        });
        // 返回错误
        pass(error,NO);
    }];
}

// 添加了缓存策略的GET请求
-(void)GET:(NSString *)urlStr params:(NSDictionary *)paramDic cacheType:(ClientRequestCachePolicy)cacheType completion:(NetworkDataPass)pass {
    
    // 获取缓存数据
    [self getCacheData:cacheType url:urlStr params:paramDic completion:pass];
    // 如果不需要请求网络数据，结束
    if (!self.reloadNetWorkData) {
        return;
    }
    // 如果需要请求网络数据
    [self GET:urlStr params:paramDic completion:pass];
}

// 使用POST方式请求网络数据
-(void)POST:(NSString *)urlStr params:(NSDictionary *)paramDic completion:(NetworkDataPass)pass {
    
    // 网络连接判断
    if (![self isConnectNetWork]) {
        return;
    }
    
    // 等待指示器开始转动
    [self showMBProgressHUD];

    // 使用AFNetworking的GET方式请求网络数据
    [[self sharedSessionManager] GET:urlStr parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 停止菊花转动
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideMBProgressHUD];
        });
        // 将json数据返回
        pass(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 停止菊花转动,给出错误提示
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideMBProgressHUD];
            [self showMBHudWithMessage:@"网络数据错误" hide:2.0];
        });
        // 返回错误
        pass(error,NO);
    }];
}

// 添加了缓存策略的POST请求
-(void)POST:(NSString *)urlStr params:(NSDictionary *)paramDic cacheType:(ClientRequestCachePolicy)cacheType completion:(NetworkDataPass)pass {
    
    [self getCacheData:cacheType url:urlStr params:paramDic completion:pass];
    if (!self.reloadNetWorkData) {
        return;
    }
    [self POST:urlStr params:paramDic completion:pass];
}
@end




