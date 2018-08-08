//
//  UIWindow+ShowAlert.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/24.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (ShowAlert)
//在window上显示一个文本样式的MBPres
-(void)showMBHudWithMessage:(NSString *)msg hide:
(NSTimeInterval)seconds;

//在window上显示一个等待只是的MBPres

@end
