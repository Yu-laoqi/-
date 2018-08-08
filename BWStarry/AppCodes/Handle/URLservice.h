//
//  URLservice.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/23.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;//表示只引用类名，不会吧类的实现文件置换到此位置，在。m中还需使用#import导入User头文件以使用其中的属性和方法

typedef  void(^URLServicePass)(id,BOOL);
@interface URLservice : NSObject
//登录
-(void)loginWithAccount:(NSString *)acc paaword:(NSString *)pwd completion:(URLServicePass)completion;
//获取验证码
-(void)getSmsCodeWithPhone:(NSString *)phone completion:(URLServicePass)com;
//注册
-(void)registerWithAccount:(NSString *)acc phone:(NSString *)phone smsCode:(NSString *)sms password:(NSString *)pwd completion:(URLServicePass)com;
//修改个人信息
-(void)updataLoginUser:(User *)usr completion:(URLServicePass)com;
//找回密码

//获取新闻、
-(void)getNewsDataWithChangeID:(NSString *)ID completion:(URLServicePass)com;
//根据商品id获取商品详情
//商品搜索接口
//将商品数据展示接口
//地址列表接口
//地址添加接口
//地址删除接口


@end
