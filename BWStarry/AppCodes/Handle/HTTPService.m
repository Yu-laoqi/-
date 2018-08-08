//
//  HTTPService.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/24.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "HTTPService.h"
#import "AppDelegate.h"
#import "UIView+ShowAlert.h"
//整个应用程序代理的hong
#define App_Delegate  (AppDelegate *)[UIApplication sharedApplication].delegate


@implementation HTTPService
#pragma mark -----私有方法----
//判断有没有网络连接
-(BOOL)isConnectNetWork{
    //先去判断网络状态，没有网络提示，退出方法调用
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable&&[Reachability reachabilityForLocalWiFi].currentReachabilityStatus==NotReachable) {
        [[App_Delegate window]showMBHudWithMessage:@"网络连接失败，请检查您的网络" hide:3.0];
        
        return NO;
        
    }
    
    return YES;
    
}
#pragma mark -----对外的接口----
-(void)GET:(NSString *)urlStr params:(NSDictionary *)parmarDic completion:(HTTPServicePass)pass{
    //网络连接判断
    if (![self isConnectNetWork]) {
        return;
    }
    //指示器开始转动
    [[App_Delegate window]showMBProgressHUD];
    //(1)做一个字符串，将网址字符串作为初始值
    NSMutableString *urlString=[[NSMutableString alloc]initWithString:urlStr];
    //(2)如果参数字典不为空,将所有参数拼街到网址字符串上
    if (parmarDic != nil && parmarDic.count !=0) {
        if ([urlString containsString:@"?"]) {
            [urlString appendString:@"&"];
        }else{
            [urlString appendString:@"?"];
            
        }
        
        //遍历参数字典，拼街道网址字符串上
        for (NSString *key in parmarDic) {
            [urlString appendFormat:@"%@=%@&",key,parmarDic[key]];
        }
        //把最后一个&号去掉
        [urlString deleteCharactersInRange:NSMakeRange(urlString.length-1, 1)];
        
    }
    //(3)对带汉子的网址字符串做处理，这个方法只对带汉字的字符串做编码，如果字符串本身都是英文字符，此方法不会做任何处理
    //假设网址字符串“http：www。baidu。com／content=IphoneX”
    urlString =[[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]] mutableCopy];
    //（4）URL对象
    NSURL *url=[NSURL URLWithString:urlString];
    //（5）封装为请求对象
    NSURLRequest *req=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5.0];
    //(6)请求服务器数据
    [[[NSURLSession sharedSession]dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //停止菊花
        dispatch_async(dispatch_get_main_queue(), ^{
            [[App_Delegate window]hideMBProgressHUD ];
            
        });
        //如果服务器连接失败，给客户提示
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[App_Delegate window]showMBHudWithMessage:@"服务器错误！" hide:2.0 ];
            });
            return ;
        }
        //json解析
        NSError *jsonError=nil;
        id obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (jsonError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[App_Delegate window]showMBHudWithMessage:@"网络数据错误" hide:2.0];
                
            });
            return;
        }
      //  NSLog(@"%@",obj);
        //将obj数据回传给URLService
        pass(obj,YES);
        
    }]resume] ;
    
}
//使用POST方式请求网络数据
-(void)POST:(NSString *)urlStr params:(NSDictionary *)parmarDic completion:(HTTPServicePass)pass{
    //网络连接判断
    if (![self isConnectNetWork]) {
        return;
    }
    //等待指示器开始转动
    [[App_Delegate window]showMBProgressHUD];
    
    
    //（1）网址字符串做成URL对象
        NSURL *url=[NSURL URLWithString:urlStr];
        //（2）实例化
        NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
        //(3)设置请求方式
        [req setHTTPMethod:@"POST"];
    
    if (parmarDic !=nil && parmarDic.count!=0) {
        
        //（4）jiang请求方式做成一个字符串
        NSMutableString *paramStr=[[NSMutableString alloc]init];
        
    for (NSString *key in parmarDic) {
        //把&符号干掉
        [paramStr appendFormat:@"%@=%@&",key,parmarDic[key]];
    }
    
    [paramStr deleteCharactersInRange:NSMakeRange(paramStr.length-1, 1)];
    
             //（5）将参数字符串转化为二进制数据
        NSData *paramData=[paramStr dataUsingEncoding:NSUTF8StringEncoding];
        //（）6jiang请求参数添加到请求对象的请求体中
        [req setHTTPBody:paramData];
        
    }
        //()7实例化会话对象
        NSURLSession *session=[NSURLSession sharedSession];
        //(8)请求网络会话得到一个网络获取任务对象
        //NSURLSessionDownloadTask;
        //NSURLSessionUploadTask;
    
        NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            //隐藏转动的菊花
            [[App_Delegate window]hideMBProgressHUD];
                 });
            //判断服务器错误
            if (error !=nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
               
                    [[App_Delegate window]showMBHudWithMessage:@"服务器连接失败！" hide:2.0 ];
     });
                return ;
            }
    
            NSError *jsonError=nil;
            //服务器返回数据所做的回调代码
            id obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonError !=nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                [[App_Delegate window]showMBHudWithMessage:@"JSON解析错误" hide:2.0 ];
                });
                return ;
    
            }
           // NSLog(@"%@",obj);
            //调用BLock类型的参数,实际上做了一个BLock函数的调用,将数据回传给URLService
            pass(obj,YES);
    
        }];
        //开启线程(9)
        [dataTask resume];
    
    
    //将参数拼成一个字典
//    NSDictionary *paramDic=@{@"wxaccount":acc,@"password":pwd};
//
//    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
//
//
//    //
//    [manager POST:URL_LOGIN parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
//        //停止菊花
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [hud hide:YES];
//            hud=nil;
//        });
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        //停止菊花.会给客户提示，服务器就错误
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [hud hide:YES];
//            hud=nil;
//
//            MBProgressHUD *hud2=[[MBProgressHUD alloc]initWithWindow:[App_Delegate window]];
//            hud2.mode=MBProgressHUDModeText;
//            hud2.removeFromSuperViewOnHide=YES;
//            hud2.labelText=@"服务器连接错误";
//            [[App_Delegate window] addSubview:hud2];
//            [hud2 show:YES];
//            [hud2 hide:YES afterDelay:2.0];
//
//        });
//
//    }];
//
    
}

@end
