//
//  LoginView.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <UIKit/UIKit.h>
//第三方登录方式的枚举类型
typedef enum{
    ThirdLoginType_WeiBo=100,
    ThirdLoginType_QQ,
    ThirdLoginType_WeChat
}ThirdLoginType;


//声明协议
@protocol LoginViewDelegate<NSObject>
//关闭当前视图
-(void)shutLoginViewAndGoBack;
//执行登录
-(void)handleLoginWithAccount:(NSString *)acc password:(NSString *)pwd;
//忘记密码
-(void)gotoForgotPwdController;
//注册登录
-(void)registrerBtnDidController;
//执行第三方登录
-(void)handleThirdLoginWithType:(ThirdLoginType)type;

@end
@interface LoginView : UIView
@property(nonatomic,weak)id<LoginViewDelegate> delegate;


@end
