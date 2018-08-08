//
//  PersonView.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/6/5.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@protocol PresonalViewDelegate<NSObject>
//修改个人信息
-(void)updataPersonalMessageWithUser:(User *)newUser;
@end

@interface PersonView : UIView
@property(nonatomic,weak)id<PresonalViewDelegate>delegate;
-(void)initUIWithUser:(User *)usr;//给UI控件赋值
-(void)handleUpdataUser;//执行更新用户信息
@end
