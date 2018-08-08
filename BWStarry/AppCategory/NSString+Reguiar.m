//
//  NSString+Reguiar.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/20.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "NSString+Reguiar.h"

@implementation NSString (Reguiar)
//判断是否是正确的手机号
-(BOOL)isCorrectPhoneNumber{
    //正则语句
    NSString *regularStr=@"^((13[0-9]\\d{8})|(15[0-9]\\d{8})|(17[0-9]\\d{8})|(18[0-9]\\d{8})|(166\\d{8}))$";
    //谓词类来匹配正则
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularStr];
    //匹配
    return [pre evaluateWithObject:self];
}
//判断是否是正确色身份证号
-(BOOL)isCorrectCardID{
    //正则语句
    NSString *regularStr=@"";
    //谓词类来匹配正则
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularStr];
    //匹配
    return [pre evaluateWithObject:self];

}
//判断是否是正确的邮箱
-(BOOL)isCorrectEmail{
    //正则语句
    NSString *regularStr=@"";
    //谓词类来匹配正则
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularStr];
    //匹配
    return [pre evaluateWithObject:self];

}
//URL地址
-(BOOL)isCorrectURL{
    //正则语句
    NSString *regularStr=@"";
    //谓词类来匹配正则
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularStr];
    //匹配
    return [pre evaluateWithObject:self];

}

@end
