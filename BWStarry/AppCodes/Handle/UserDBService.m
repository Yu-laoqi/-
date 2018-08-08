//
//  UserDBService.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/23.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "UserDBService.h"

#define USER_SAVE_KEY @"loginUser"
//静态全局变量
static UserDBService *_defaultUserDB=nil;
@implementation UserDBService
+(instancetype)sharedDistance{
    if (_defaultUserDB == nil) {
        _defaultUserDB=[[UserDBService alloc]init];
    }
    return _defaultUserDB;
}
//重写allocWithZone方法，防止外部类使用allow创建新的对象的内存
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (_defaultUserDB==nil) {
        _defaultUserDB=[super allocWithZone:zone];
    }
    return _defaultUserDB;
    
}
#pragma mark  对外接口----

//判断有无用户登录
-(BOOL)userhadlogin{
    return [[NSUserDefaults standardUserDefaults]objectForKey: USER_SAVE_KEY];
    
} 
//获取登录用户数据
-(User *)getLoginUser{
    NSData *uData=[[NSUserDefaults standardUserDefaults]objectForKey:USER_SAVE_KEY];
    User *u=[NSKeyedUnarchiver unarchiveObjectWithData:uData];
    return u;
}
//将登陆人信息持久化
-(void)saveLoginUser:(User *)loginUser;{
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:loginUser];
    
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:USER_SAVE_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//退出登录，清楚登录人信息
-(BOOL)clearLoginUser{
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:USER_SAVE_KEY];
    return [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
