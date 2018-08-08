//
//  News.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property(nonatomic,copy)NSString *accountid;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *STYLE;
@property(nonatomic,copy)NSString *style2;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *txturl;
@property(nonatomic,copy)NSString *updateName;
@property(nonatomic,copy)NSString *uploadimgurl;
@property(nonatomic,copy)NSString *createName;
//类方法，用于创建一个News对象，并对其属性做好赋值
+(News *)createNewWitnDictionary:(NSDictionary *)dic;

@end
