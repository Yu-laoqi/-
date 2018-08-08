//
//  HTTPService.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/24.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义回传网络数据的BLock类型
typedef void(^HTTPServicePass)(id,BOOL);

@interface HTTPService : NSObject
-(void)GET:(NSString *)urlStr params:(NSDictionary *)parmarDic completion:(HTTPServicePass)pass;
//使用POST方式请求网络数据
-(void)POST:(NSString *)urlStr params:(NSDictionary *)parmarDic completion:(HTTPServicePass)pass;



@end
