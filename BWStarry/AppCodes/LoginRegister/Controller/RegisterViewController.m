//
//  RegisterViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"

#import "URLservice.h"
@interface RegisterViewController ()<RegisterViewDelegate>
@property(nonatomic,strong)RegisterView *rView;
@end

@implementation RegisterViewController
#pragma mark     ----RegisterViewDelegate---
//返回登录视图
-(void)backToLoginView{
    //
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
//获取验证码
-(void)getSMSCodeWithPhone:(NSString *)phoneNum{
    NSLog(@"向手机号%@发送验证码",phoneNum);
    //NSString *str=
    
    [[[URLservice alloc]init]getSmsCodeWithPhone:phoneNum completion:^(id data, BOOL success) {
        NSLog(@"%@",data);
        if (success==NO) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.rView showMBHudWithMessage:data hide:2.0];
                //a将获取阳证吗的按钮恢复可用状态
                [self.rView resetGetSMSCodeButton];
            });
        }
        
        
    }];
    
}
//注册
-(void)registerWitnAccoiunt:(NSString *)acc
                      phone:(NSString *)phone
                   password:(NSString *)pwd
                        yzm:(NSString *)smsCode{
    
    [[[URLservice alloc]init] registerWithAccount:acc phone:phone smsCode:smsCode password:pwd completion:^(id data, BOOL success) {
        if (!success) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.rView showMBHudWithMessage:data hide:2.0];
                
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.rView showMBHudWithMessage:data hide:2.0];
            //2秒后自动返回上一视图控制器
            [self performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:nil afterDelay:2.0];
        });
    }];
    
}

#pragma mark  ---VIew实例化------
- (RegisterView *)rView{
    if (!_rView) {
        _rView=[[RegisterView alloc]initWithFrame:self.view.frame];
        _rView.delegate=self;
    }
    return _rView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.view=self.rView;
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
