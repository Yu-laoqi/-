//
//  User.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "User.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation User

-(BOOL)isEqual:(id)object{
    //如果参数object不是本类或本类的子类的对象，直接返回NO，表示不一致
    if (![object isKindOfClass:[User class]]) {
        return NO;
    }
    User *otherUser = (User *)object;
    //定义变量。保存属性的个数
    unsigned int count;
    //获取对象包含的所有属性列表指针
    Ivar *Ivars = class_copyIvarList([self class], &count);
    //遍历每一个属性
    for (int i = 0; i<count; i++) {
        //根据下标获取某个属性的指针
        Ivar ivar = Ivars[i];
        //得到属性的名称字符串
        const char* ivarname = ivar_getName(ivar);
        //转换为OC字符串
        NSString *ivarkey = [NSString stringWithUTF8String:ivarname];
        //使用kvc获取self和otherUser的valuede值，判断是否一致，如果不一致，返回NO，继续执行循环
        if (![[self valueForKey:ivarkey]isEqual:[otherUser valueForKey:ivarkey]]) {
            free(Ivars);
            return NO;
        }
    }
    free(Ivars);
    return YES;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
  //定义一个变量
    unsigned int count;
    
    Ivar *ivars=class_copyIvarList([self class], &count);
    
    for (int i=0; i<count; i++) {
        
        Ivar ivar=ivars[i];
       // const char *ivarName=ivar_getName(ivar);
        //将其转换为OC字符串
        NSString *key=[NSString stringWithUTF8String:ivar_getName(ivar)];
        //通过key获取值
        NSString *value=[self valueForKey:key];
        //归档
        [aCoder encodeObject:value forKey:key];
        //
    }
        //释放指针
         free(ivars);
}

//返归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        //定义变量，用于保存所有属性的个数
        unsigned int count;
        //获取所有属性的列表
        Ivar *ivarList=class_copyIvarList([self class], &count);
        //遍历
        for (int i=0; i<count; i++) {
            //通过下表获取到某一个属性指针
            Ivar ivar=ivarList[i];
            //获取到属性的名称的字符串
            NSString *key=[NSString stringWithUTF8String:ivar_getName(ivar)];
            //凡归档
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        //释放指针
        free(ivarList);
    }
    
    return self;
}

@end
