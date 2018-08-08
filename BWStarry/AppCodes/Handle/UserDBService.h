//
//  UserDBService.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/23.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDBService : NSObject
//单利接口
+(instancetype)sharedDistance;
//判断有无用户登录
-(BOOL)userhadlogin;
//获取登录用户数据
-(User *)getLoginUser;
//将登陆人信息持久化
-(void)saveLoginUser:(User *)loginUser;
//退出登录，清楚登录人信息
-(BOOL)clearLoginUser;

@end
