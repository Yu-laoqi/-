//
//  UIView+ShowAlert.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/18.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShowAlert)
//实用UIAlertController做提示框
-(void)showAlertWithMessage:(NSString *)msg hide:
(NSTimeInterval)seconds;
//实用MBProgressHUD做提示框
-(void)showMBHudWithMessage:(NSString *)msg hide:
(NSTimeInterval)seconds;
//显示MBProgressHUD样式的菊花等待指示器
-(void)showMBProgressHUD;
//隐藏MBProgressHUD样式的菊花等待指示器
-(void)hideMBProgressHUD;
@end
