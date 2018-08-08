//
//  RegisterView.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <UIKit/UIKit.h>
//声明协议
@protocol RegisterViewDelegate<NSObject>
//返回登录视图
-(void)backToLoginView;
//获取验证码
-(void)getSMSCodeWithPhone:(NSString *)phoneNum;
//注册anniu
-(void)registerWitnAccoiunt:(NSString *)acc
                            phone:(NSString *)phone
                         password:(NSString *)pwd
                              yzm:(NSString *)smsCode;

@end
@interface RegisterView : UIView
@property(nonatomic,weak)id<RegisterViewDelegate> delegate;
//恢复获取短信验证吗按钮状态
-(void)resetGetSMSCodeButton;


@end
//声明协议

