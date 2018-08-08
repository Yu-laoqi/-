//
//  LoginViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterViewController.h"
#import "URLservice.h"
@interface LoginViewController ()<LoginViewDelegate>
@property(nonatomic,strong)LoginView *loginView;

@end

@implementation LoginViewController
#pragma mark---- 类方法-----
//
+ (instancetype)getInstance{
    
    return [[LoginViewController alloc]init];
    
}

//
- (LoginView *)loginView{
    if (!_loginView) {
        _loginView=[[LoginView alloc]initWithFrame:self.view.frame];
        _loginView.delegate=self;
    }
    
    return _loginView;
}
#pragma mark--------LoginVieweDelegate--------
//关闭登录视图的方法
- (void)shutLoginViewAndGoBack{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
//执行登录
- (void)handleLoginWithAccount:(NSString *)acc password:(NSString *)pwd{
    
    NSLog(@"在Controller中打印--账号%@ ， 密码%@执行登录",acc,pwd);
    [[[URLservice alloc]init]loginWithAccount:acc paaword:pwd completion:^(id data, BOOL success) {
        
        
       // NSLog(@"登录控制器中打印数据--%@",data);
        if (success==NO) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            [self.loginView showMBHudWithMessage:data hide:3.0];
                  });
            return ;
        }
        
        //将登录人信息持久化
        User *u=(User *)data;
        [[UserDBService sharedDistance]saveLoginUser:u ];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        //回到上一控制器
        [self dismissViewControllerAnimated:YES completion:nil];
              });
        
    }];
     }
//进行密码忘记
- (void)gotoForgotPwdController{
    

    NSLog(@"忘记密码，进入找回视图");
    
}

//注册登录
-(void)registrerBtnDidController{
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];

    
}

//执行第三方登录
- (void)handleThirdLoginWithType:(ThirdLoginType)type
{
    
    switch (type) {
        case ThirdLoginType_WeiBo:
            NSLog(@"实用微博第三方登录");
            break;
        case ThirdLoginType_QQ:
            NSLog(@"实用QQ第三方登录");
            break;
        case ThirdLoginType_WeChat:
            NSLog(@"实用微信第三方登录");
            break;
            
        default:
            break;
    }
}



#pragma mark---------View   Load--------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view=self.loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
