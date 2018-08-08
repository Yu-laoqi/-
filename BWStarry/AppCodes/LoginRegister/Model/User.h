//
//  User.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property(nonatomic,strong)NSString *accessToken;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *applypost;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *compny;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *fee;
@property(nonatomic,strong)NSString *fee_state;
@property(nonatomic,strong)NSString *headimg;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *nicheng;
@property(nonatomic,strong)NSString *position;
@property(nonatomic,strong)NSString *poststyle;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *sheng;
@property(nonatomic,strong)NSString *sort;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *uploadimg;
@property(nonatomic,strong)NSString *wxaccount;
//@property(nonatomic,strong)NSString *errmsg;
//@property(nonatomic,strong)NSString *resultcode;
//@property(nonatomic,strong)NSString *methodname;


@end
