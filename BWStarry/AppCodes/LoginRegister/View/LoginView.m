//
//  LoginView.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "LoginView.h"

//添加类的延展,声明私有属性和方法
@interface LoginView()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *backImgView;//背景图
@property(nonatomic,strong)UIButton *backBtn;//返回按钮
@property(nonatomic,strong)UITextField *accountTF;//账号输入框
@property(nonatomic,strong)UITextField *passwordTF;//密码输入框
@property(nonatomic,strong)UIButton *forGotPwdBtn;//忘记密码按钮
@property(nonatomic,strong)UIButton *loginBtn;//登录按钮
@property(nonatomic,strong)UIButton *registerBtn;//注册按钮
@property(nonatomic,strong)UIView *thirdLoginView;//第三方登录视图

@end


@implementation LoginView
#pragma mark------控件实例化-----
//背景图
- (UIImageView *)backImgView{
    if (!_backImgView) {
        _backImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)];
        _backImgView.image=[UIImage imageNamed:@"登录"];
    }
    
    return _backImgView;
}
//返回按钮
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame=CGRectMake(20, STATUS_BAR_HEIGHT+10, 20, 25);
        [_backBtn setImage:[UIImage imageNamed:@"navigationItem_back"] forState:UIControlStateNormal];
        
        [_backBtn addTarget:self action:@selector(backBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
    
}


//账号文本输入框
- (UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF=[[UITextField alloc]initWithFrame:CGRectMake(20, self.backBtn.frame.origin.y+self.backBtn.frame.size.height+FIT_X(80), SCR_W-40, FIT_X(60))];
        //背景图
        _accountTF.background=[UIImage imageNamed:@"登录_03"];
        
        //提示文本
     //   _accountTF.placeholder=@"请输入账号";
       //添加带格式的提示文本
        _accountTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入手机号／账号" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:FONT_FIT(18)]
                                                                                                                        
                                                                                                                        }];
        _accountTF.textAlignment=NSTextAlignmentCenter;
        _accountTF.textColor=[UIColor whiteColor];
        _accountTF.delegate=self;
        
    }
    
    return  _accountTF;
}
//密码输入框
- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF=[[UITextField alloc]initWithFrame:CGRectMake(20, self.accountTF.frame.origin.y+self.accountTF.frame.size.height+FIT_X(10), SCR_W-40, FIT_X(60))];
        //背景图
        _passwordTF.background=[UIImage imageNamed:@"登录_07"];
        //添加带格式的提示文本
        _passwordTF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入手密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                                             NSFontAttributeName:[UIFont systemFontOfSize:FONT_FIT(18)]
                                                                                                             
                                                                                                             }];
        
        
        _passwordTF.secureTextEntry=YES;//密文输入
        _passwordTF.textAlignment=NSTextAlignmentCenter;
        _passwordTF.textColor=[UIColor whiteColor];
        _passwordTF.delegate=self;
        
    }
    return  _passwordTF;
}
//登录按钮
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame=CGRectMake(55, self.passwordTF.frame.origin.y+self.passwordTF.frame.size.height+FIT_X(25), SCR_W-110, FIT_X(55));
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTintColor:[UIColor whiteColor]];
        _loginBtn.titleLabel.font=[UIFont systemFontOfSize:FONT_FIT(22)];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"登录_11"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
         
    }
    return _loginBtn;
}
- (UIButton *)forGotPwdBtn{
    if (!_forGotPwdBtn) {
        _forGotPwdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _forGotPwdBtn.frame=CGRectMake(self.loginBtn.frame.origin.x+self.loginBtn.frame.size.width-100, self.loginBtn.frame.origin.y+self.loginBtn.frame.size.height+FIT_X(15), 100, 30);
        [ _forGotPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forGotPwdBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_forGotPwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forGotPwdBtn addTarget:self action:@selector(forgotDidPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _forGotPwdBtn;
    
}
//注册按钮
- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame=CGRectMake(0, 0, 100, 40);
        _registerBtn.center=CGPointMake(SCR_W/2, SCR_H-BottomSafeArea-FIT_X(60+50+30+20));
         [_registerBtn setTitle:@"--注册--" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
    
}

//第三方登录视图
- (UIView *)thirdLoginView{
    if (!_thirdLoginView) {
        _thirdLoginView=[[UIView alloc]initWithFrame:CGRectMake(20, 0, SCR_W-80, 60)];
        _thirdLoginView.center=CGPointMake(SCR_W/2, SCR_H-BottomSafeArea-FIT_X(60+30));
        _thirdLoginView.backgroundColor=[UIColor clearColor];
        //图片数组
        NSArray *immArr=@[@"登录_15",@"登录_17",@"登录_19"];
        //计算出间隔距离
        CGFloat dis=(SCR_W-80-immArr.count*60)/(immArr.count +1);
        //添加三个按钮子视图
        for (int i=0; i<immArr.count; i++) {
            UIButton  *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(dis +i *(dis+60), 0, 60, 60);
            btn.tag=ThirdLoginType_WeiBo+i;
            [btn setImage:[UIImage imageNamed:immArr[i]] forState:UIControlStateNormal];
            
            [_thirdLoginView addSubview:btn];
            [btn addTarget:self action:@selector(thirdLoginBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return _thirdLoginView;
    
}
#pragma Mark-----UITextFieldDelegate----
//点击键盘是哪个return按钮触发的回调
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
#pragma mark--- 触摸回调方法----
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //先从父类中的方法，在调用子类
    [super touchesBegan:touches withEvent:event];
    //
//    [self.accountTF resignFirstResponder];
//    [self.passwordTF resignFirstResponder];
//
    [self endEditing:YES];

}

#pragma mark-----初始化入口---
- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview: self.backImgView];//背景图
        [self addSubview:self.backBtn];
        [self addSubview:self.accountTF];//账号输入框
        [self addSubview:self.passwordTF];
        [self addSubview:self.loginBtn];
        [self addSubview:self.forGotPwdBtn];
        [self addSubview:self.registerBtn];
        [self addSubview:self.thirdLoginView];//第三方按钮
    }
    
    return self;
}

#pragma mark---   控件触发方法------
//返回按钮触发方法
-(void)backBtnDidPress:(id)sender{
    
    [self.delegate shutLoginViewAndGoBack];//协议中方法的调用
    
}

//登录按钮触发方法
- (void)loginBtnDidPress:(id)sender{
    //如果账号密码为空，给客户提示，跳出该方法调用
    if (self.accountTF.text.length==0||self.passwordTF.text.length==0) {
      //系统自带
      // [self showAlertWithMessage:@"账号密码不可为空" hide:2.0];
        //第三方
        [self showMBHudWithMessage:@"账号密码不可以为空" hide:2.0];
        return;
    }
    
    //让Controller对象执行协议中登录的方法
    [self.delegate handleLoginWithAccount:self.accountTF.text password:self.passwordTF.text];
    
}


//忘记密码按钮触发
-(void)forgotDidPress:(id)sender{
    
    [self.delegate gotoForgotPwdController];
    
}
//注册按钮触发方法
-(void)registerBtnDidPress:(id)sender{
    
    [self.delegate registrerBtnDidController];
}
//第三方登录按钮触发
-(void)thirdLoginBtnDidPress:(UIButton *)sender{
    
[self.delegate handleThirdLoginWithType:(ThirdLoginType)sender.tag];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
