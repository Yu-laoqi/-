//
//  URLservice.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/23.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "URLservice.h"
#import "HTTPService.h"
#import "User.h"
#import "News.h"
#import "NetworkData.h"
//登录URL地址
#define URL_LOGIN @"http://py.cmshop.net/tPyshApplyController.do?login"

#define URL_SMS @"http://py.cmshop.net/tPyshApplyController.do?getyanzhengma"
//注册
#define URL_Register @"http://py.cmshop.net/tPyshApplyController.do?register"
#define URL_FINISH_INFO @"http://py.cmshop.net/tPyshApplyController.do?finishinfo"
//新闻
#define URL_NEWS @"http://py.cmshop.net/tPyshNewnoticController.do?godongtai2"

@implementation URLservice
//登录
-(void)loginWithAccount:(NSString *)acc paaword:(NSString *)pwd completion:(URLServicePass)completion{
   //先把参数做成字典
    NSDictionary *dic=@{
                        @"wxaccount":acc,
                        @"password":pwd
                        
                        };
    //调用请求
    [[[HTTPService alloc]init] POST:URL_LOGIN params:dic completion:^(id jsonData, BOOL success) {
        if (!success) {
            return ;
        }
      //接收到HTTPService返回的Json数据之后回调的代码块
        NSLog(@"%@",jsonData);
        //找到resultcode对应的数据，如果不是0，表示有错误，将错误信息errmsg回传
        if ([jsonData[@"resultcode"]intValue]!=0) {
            completion(jsonData[@"errmsg"],NO);
            return ;
        }
        //如果resultcode为0.但是Data对应的是空字符串，
        if (jsonData[@"data"]==nil || [jsonData[@"data"]isEqual:[NSNull null]]||[jsonData[@"data"]isEqual:@""]) {
            completion(@"账号密码错误",NO);
            return;
        }
        //如果data字段对应的是一个字典，表示登录成功，需要把字典封装为一个MOdel对象，将MOdel对象回传给黑Controller
        NSDictionary *dataDic=jsonData[@"data"];
        User *u=[[User alloc]init];
        //u.accessToken=dataDic[@"accessToken"];
        [u setValuesForKeysWithDictionary:dataDic];
        completion(u,YES);
        
    }];
  
}
//获取验证码
-(void)getSmsCodeWithPhone:(NSString *)phone completion:(URLServicePass)com{
    //将参数做成字典
    NSDictionary *dic=@{@"telphone":phone};
    
    [[[HTTPService alloc]init]POST:URL_SMS params:dic completion:^(id jsonData, BOOL success) {
        if (!success) {
            return ;
        }
       //先得到Json数据中的resultCode字段
        NSString *resultcode=jsonData[@"resultcode"];
        //如果不是0.表示发生错误，将错误信息回传给Controller
        if ([resultcode intValue]!=0) {
            com(jsonData[@"errmsg"],NO);
            return ;
        }
        //如果不是0，表示成功
        com(jsonData,YES);
    
    }];
     }
//注册
-(void)registerWithAccount:(NSString *)acc phone:(NSString *)phone smsCode:(NSString *)sms password:(NSString *)pwd completion:(URLServicePass)com{
    
    //  将参数做成字典
    NSDictionary *paramDic=@{
                             @"wxaccount":acc,
                             @"telphone":phone,
                             @"password":pwd,
                             @"yzm":sms
                             
                             };
    //如果发生错误
    [[[HTTPService alloc] init]POST:URL_Register params:paramDic completion:^(id jsonData, BOOL success) {
        if (!success) {
            return ;
        }
        NSLog(@"%@",jsonData);
        if ([jsonData[@"resultcode"]intValue]!=0) {
            com(jsonData[@"errmsg"],NO);
            return ;
        }
        //成功
        com(@"注册成功",YES);
    }];
}
//修改个人信息
-(void)updataLoginUser:(User *)usr completion:(URLServicePass)com{
    //参数字典
    NSDictionary *paramDic=@{
                             @"usreid":usr.id,
                             @"name":usr.name,
                             @"nicheng":usr.nicheng,
                             @"email":usr.email,
                             @"address":usr.address,
                             @"accessToken":usr.accessToken
                             };
    //POST请求网络数据
    [[[HTTPService alloc]init] POST:URL_FINISH_INFO params:paramDic completion:^(id jsonData, BOOL success) {
        if (!success) {
            return ;
        }
        
            if ([jsonData[@"resultcode"] intValue] != 0) {
                com(jsonData[@"errmsg"],NO);
                return ;
            }
            //将data字段对应的字典封装为User对象，回传给Controller
            NSDictionary *dataDic = jsonData[@"data"];
        
            User *u =[[User alloc]init];
            [u setValuesForKeysWithDictionary:dataDic];
            u.accessToken = usr.accessToken;
            com(u,YES);
            //   NSLog(@"%@",jsonData);
    }];
    
}
//获取新闻
-(void)getNewsDataWithChangeID:(NSString *)ID completion:(URLServicePass)com{
    //(1)参数字典
    NSDictionary *paramDic= @{@"style2":ID};
    //(2)get请求网络数据
    [[[NetworkData alloc]init] GET:URL_NEWS params:paramDic cacheType:ClientReturnCacheDataThenLoad completion:^(id jsonData, BOOL success) {
        if (!success) {
            return ;
        }
        
        if ([jsonData[@"resultcode"] intValue] != 0) {
            com(jsonData[@"errmsg"],NO);
            return ;
        }

        //获取result字段对应的数组
        NSArray *resultArr =  jsonData[@"data"];
        //
        NSMutableArray *newArr =[[NSMutableArray alloc]init];
        //遍历
        for (NSDictionary *dic in resultArr) {
            News *one = [News createNewWitnDictionary:dic];
            [newArr addObject:one];
        }
        com(newArr,YES);
    }];
    
    
}

@end
