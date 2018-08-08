//
//  BaseViewController.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/16.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <UIKit/UIKit.h>

//自定义一个枚举.表示Controller属于抽屉的左侧菜单还是内容
typedef  enum {
    
    MenuType_Content=100,//菜单内容组
    MenuType_left,//抽屉菜单
    
}MenuType;

@interface BaseViewController : UIViewController
-(instancetype)initWithMenuType:(MenuType)type;
//添加
-(void)addShaeritem;

@end





