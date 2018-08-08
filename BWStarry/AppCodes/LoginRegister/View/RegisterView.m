//
//  RegisterView.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "RegisterView.h"
typedef enum {
    TextFieldType_Account=150,
    TextFieldType_Phone,
    TextFieldType_SMS,
    TextFieldType_Password,
    TextFieldType_PasswordConfirm
    
}TextFieldType;


@interface RegisterView()<UITextFieldDelegate>
{
    int _leftSeconds;//倒计时剩余时间
    NSTimer *_myTimer;//定时器
    
}




@property(nonatomic,strong)UIImageView *backImgView;//背景图
@property(nonatomic,strong)UIButton *backBtn;//返回按钮
@property(nonatomic,strong)UITextField *accountTF;//账号输入框
//@property(nonatomic,strong)UITextField *phonewordTF;//手机号输入框
@property(nonatomic,strong)UITextField *smsCodeTF;//短信
@property(nonatomic,strong)UIButton *getSmsCodeBtn;//获取短信验证码
@property(nonatomic,strong)UITextField *passpwdTF;//
@property(nonatomic,strong)UITextField *passwordTF;//请输入手机号
@property(nonatomic,strong)UITextField *passwordConfirmTF;//密码确认
@property(nonatomic,strong)UIButton *registerBtn;//注册按钮
@end

@implementation RegisterView

#pragma   mark  ------ 实例化控件    ----
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview: self.backImgView];//背景图
        [self addSubview:self.backBtn];
        [self addSubview:self.accountTF];//账号输入框
        [self addSubview:self.smsCodeTF];//短信kuang
        [self addSubview:self.getSmsCodeBtn];//获取验证码
        [self addSubview:self.registerBtn];//zhuce
        [self addSubview:self.passwordTF];//密码
        [self addSubview:self.passpwdTF];
        [self addSubview:self.passwordConfirmTF];//密码确认
    }
    return self;
}
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
        _accountTF=[[UITextField alloc]initWithFrame:CGRectMake(20, self.backBtn.frame.origin.y+self.backBtn.frame.size.height+FIT_X(30), SCR_W-40, FIT_X(60))];
        _accountTF.background=[UIImage imageNamed:@"快速注册_04"];
        _accountTF.placeholder=@"请输入用户账号";
        //将枚举常量值赋值给tag
        _accountTF.tag=TextFieldType_Account;
        _accountTF.delegate=self;
        _accountTF.backgroundColor=[UIColor whiteColor];
        _accountTF.textAlignment=NSTextAlignmentCenter;
        _accountTF.textColor=[UIColor blackColor];
        
    }
    return  _accountTF;
}
//添加手机输入文本框
- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF=[[UITextField alloc]initWithFrame:CGRectMake(20, self.accountTF.frame.origin.y+self.accountTF.frame.size.height+FIT_X(10), SCR_W-40, FIT_X(60))];
         _passwordTF.background=[UIImage imageNamed:@"快速注册_04"];
        _passwordTF.placeholder=@"请输入手机号";
        _passwordTF.keyboardType=UIKeyboardTypePhonePad;
        _passwordTF.delegate=self;
        _passwordTF.tag=TextFieldType_Phone;
        _passwordTF.backgroundColor=[UIColor whiteColor];
        _passwordTF.textAlignment=NSTextAlignmentCenter;
        _passwordTF.textColor=[UIColor blackColor];
        
            }
    return  _passwordTF;
}
//输入验证码框
- (UITextField *)smsCodeTF{
    if (!_smsCodeTF) {
        _smsCodeTF=[[UITextField alloc]initWithFrame:CGRectMake(20, self.passwordTF.frame.origin.y+self.passwordTF.frame.size.height+FIT_X(10), SCR_W/2-40, FIT_X(60))];
        _smsCodeTF.tag=TextFieldType_SMS;
        _smsCodeTF.delegate=self;
        _smsCodeTF.keyboardType=UIKeyboardTypeNumberPad;
        _smsCodeTF.backgroundColor=[UIColor whiteColor];
        _smsCodeTF.textAlignment=NSTextAlignmentCenter;
        _smsCodeTF.textColor=[UIColor blackColor];
    }
    return _smsCodeTF;
}
//获取验证码按钮
- (UIButton *)getSmsCodeBtn{
    if (!_getSmsCodeBtn) {

        if (!_getSmsCodeBtn) {
            _getSmsCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            _getSmsCodeBtn.frame=CGRectMake(SCR_W-(SCR_W/2)+20, self.passwordTF.frame.origin.y+self.passwordTF.frame.size.height+FIT_X(10), SCR_W/2-40, FIT_X(60));
            [ _getSmsCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            _getSmsCodeBtn.backgroundColor=[UIColor greenColor];
            [_getSmsCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_getSmsCodeBtn addTarget:self action:@selector(getSmsCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        return  _getSmsCodeBtn;
        
        
    }
    return _getSmsCodeBtn;
}
//输入密码
- (UITextField *)passpwdTF{
    
    if (!_passpwdTF) {
        _passpwdTF=[[UITextField alloc]initWithFrame:CGRectMake(20, self.smsCodeTF.frame.origin.y+self.smsCodeTF.frame.size.height+FIT_X(10), SCR_W-40, FIT_X(60))];
        _passpwdTF.placeholder=@"请输入密码";
        _passpwdTF.tag=TextFieldType_Password;
        _passpwdTF.delegate=self;
        _passpwdTF.secureTextEntry=YES;
        _passpwdTF.background=[UIImage imageNamed:@"快速注册_15"];
        _passpwdTF.backgroundColor=[UIColor whiteColor];
        _passpwdTF.textAlignment=NSTextAlignmentCenter;
        _passpwdTF.textColor=[UIColor blackColor];
        
    }
    return _passpwdTF;
    
}
//密码确认
- (UITextField *)passwordConfirmTF{
    if (!_passwordConfirmTF) {
        if (!_passwordConfirmTF) {
            _passwordConfirmTF=[[UITextField alloc]initWithFrame:CGRectMake(20, self.passpwdTF.frame.origin.y+self.passpwdTF.frame.size.height+FIT_X(10), SCR_W-40, FIT_X(60))];
            _passwordConfirmTF.backgroundColor=[UIColor whiteColor];
           _passwordConfirmTF.background=[UIImage imageNamed:@"快速注册_15"];
            _passwordConfirmTF.delegate=self;
            _passwordConfirmTF.tag=TextFieldType_PasswordConfirm;
            _passwordConfirmTF.textAlignment=NSTextAlignmentCenter;
            _passwordConfirmTF.textColor=[UIColor blackColor];
            
        }
    }
    return _passwordConfirmTF;
}

//注册按钮
- (UIButton *)registerBtn{
        if (!_registerBtn) {
            _registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            _registerBtn.frame=CGRectMake(20, self.passwordConfirmTF.frame.origin.y+self.passwordConfirmTF.frame.size.height+FIT_X(10), SCR_W-40, FIT_X(60));
            [ _registerBtn setTitle:@"注册" forState:UIControlStateNormal];
            _registerBtn.backgroundColor=[UIColor greenColor];
            [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
        [_registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    return _registerBtn;
    
}

#pragma mark----  对外的jie口----
//恢复获取短信验证吗按钮状态
-(void)resetGetSMSCodeButton{
    
    //停止定时器
    [_myTimer invalidate];
    _myTimer=nil;
    //设置按钮的标题为“重新获取验证码”
    [self.getSmsCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    //恢复按钮的可用状态和 透明度
    self.getSmsCodeBtn.enabled=YES;
    self.getSmsCodeBtn.alpha=1.0;
    //将静态局部变量的值重新设置为60
    _leftSeconds=30;
}


#pragma   mark  ------ 控件触发事件   ----
//获取验证码触发按钮触发
-(void)getSmsCodeBtn:(UIButton *)sender{
    //没有输入手机号提示
    if (self.passwordTF.text.length==0) {
        [self showMBHudWithMessage:@"手机号不可为空" hide:2.0];
        return;
    }
    //如果输入手机号，明显是一个错误的手机号
    if (![self.passwordTF.text isCorrectPhoneNumber]) {
        [self showMBHudWithMessage:@"请输入正确的手机号" hide:2.0];
        return;
    }
    //让当前的Button处于不可用状态，同时设置透明度，变得更透明
   // self.getSmsCodeBtn.enabled=NO;
    sender.enabled=NO;//一样
    sender.alpha=0.4;
    [sender setTitle:@"30" forState:UIControlStateNormal];
    //给剩余的时间初始值
    _leftSeconds=30;
    
    //开启一个定时器,定时改变btn的标题
    _myTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDidHandle:) userInfo:nil repeats:YES];
    
    //让Controller调用获取短信验证码的接口
    [self.delegate getSMSCodeWithPhone: self.passwordTF.text];
}
//触摸定时器方法
-(void)timerDidHandle:(NSTimer *)sender{

    _leftSeconds--;
    NSString *leftSecondsStr=[NSString stringWithFormat:@"%02d",_leftSeconds];
    [self.getSmsCodeBtn setTitle:leftSecondsStr forState:UIControlStateNormal];
    if (_leftSeconds==0) {
        [self resetGetSMSCodeButton];
    }
    
}
//注册按钮触发方法
-(void)registerBtn:(UIButton *)sender{
     NSLog(@"点击了注册按钮");
    //只要有控件信息为空，提示客户
    if (self.accountTF.text.length==0||
        self.passpwdTF.text.length==0||
        self.smsCodeTF.text.length==0||self.passwordTF.text.length==0||self.passwordConfirmTF.text.length==0) {
        
        [self showAlertWithMessage:@"注册信息不可为空" hide:2.0];
        return;//表示从整个registerBtn方法结束
    }
    //密码与确认密码不一致，提示用户
    if (![self.passpwdTF.text isEqualToString:self.passwordConfirmTF.text]) {
        [self showAlertWithMessage:@"密码不一致" hide:2.0];
        return;
        
    }
    //让controller执行注册操作
    [self.delegate registerWitnAccoiunt:self.accountTF.text phone:self.passpwdTF.text password:self.passwordConfirmTF.text yzm:self.smsCodeTF.text];
    
}
//点击return按钮键盘隐藏
 
//返回按钮触发
-(void)backBtnDidPress:(id)sender{
    [self.delegate backToLoginView];
    
}
#pragma   mark   ------ init     -   ---

#pragma mark--- 触摸回调方法----
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //先从父类中的方法，在调用子类
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    
}

#pragma   mark------UItextFieldDelegate----
//点击键盘是哪个return按钮触发的回调
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//隐藏键盘
    return YES;
    
}

//根据当前输入字符是否可以显示在textField控件上的回调方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//     NSLog(@"原文本%@",textField.text);
//     NSLog(@"变化的范围///////%lu%lu",(unsigned long)range.location,(unsigned long)range.length);
//     NSLog(@"变化的文本%@",string);
//
    
    //得到当前文本框输入的字符串
    NSMutableString *currentStr=[[NSMutableString alloc]initWithString:textField.text];
    [currentStr replaceCharactersInRange:range withString:string];
//    NSLog(@"当前文本框中显示的文本%@",currentStr);
    //如果是账号，密码,确认密码限定16位
    if (textField.tag==TextFieldType_Account||textField.tag==TextFieldType_Password||textField.tag==TextFieldType_PasswordConfirm) {
        return currentStr.length<=16;
        
    }else if (textField.tag==TextFieldType_Phone){
        return currentStr.length<=11;
        
    }else {
        return currentStr.length<=6;
        
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
