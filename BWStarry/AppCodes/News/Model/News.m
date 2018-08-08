//
//  News.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "News.h"

@implementation News
+(News *)createNewWitnDictionary:(NSDictionary *)dic{
    News *one = [[News alloc]init];
    [one setValuesForKeysWithDictionary:dic];
    return one;
    
}
//如果使用KVC给属性赋值，发现没有此属性名称，会回调此方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    }
    else if ([key isEqualToString:@"style"]){
        [self setValue:value forKey:@"STYLE"];
        
    }
}

@end
