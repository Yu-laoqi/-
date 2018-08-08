//
//  NSString+Reguiar.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/20.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Reguiar)
//判断是否是正确的手机号
-(BOOL)isCorrectPhoneNumber;
//判断是否是正确色身份证号
-(BOOL)isCorrectCardID;
//判断是否是正确的邮箱
-(BOOL)isCorrectEmail;
//URL地址
-(BOOL)isCorrectURL;
@end
