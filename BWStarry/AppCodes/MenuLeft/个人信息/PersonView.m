//
//  PersonView.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/6/5.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "PersonView.h"
@interface PersonView()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *nameTF;
@property(nonatomic,strong)UITextField *accountTF;
@property(nonatomic,strong)UITextField *phoneTF;//名称
@property(nonatomic,strong)UITextField *nichengTF;//
@property(nonatomic,strong)UIView *sexSelectView;//性别
@property(nonatomic,strong)UITextField *addressTF;//地址
@property(nonatomic,strong)UITextField *emailTF;//


@end

@implementation PersonView
//私有方法，用于创建文本控件
-(UITextField *)createTFWithOriginalY:(CGFloat)y title:(NSString *)title
{
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(20, y, SCR_W-40, 60)];
    tf.placeholder = title;
    tf.borderStyle = UITextBorderStyleLine;
    tf.delegate = self;
    tf.textAlignment = NSTextAlignmentCenter;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    return  tf;
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    
}
#pragma mark ----控件实例化===
- (UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF=[self createTFWithOriginalY:100 title:@"手机号"];
        _phoneTF.enabled = NO;
    }
    return _phoneTF;
}
- (UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [self createTFWithOriginalY:self.phoneTF.frame.origin.y +self.phoneTF.frame.size.height +20 title:@"账号"];
        _accountTF.enabled =NO;
    }
    return _accountTF;
}
- (UITextField *)nameTF{
    if (!_nameTF) {
        _nameTF = [self createTFWithOriginalY:self.accountTF.frame.origin.y +self.accountTF.frame.size.height +20 title:@"姓名"];
    }
    return _nameTF;
}
- (UITextField *)nichengTF{
    if (!_nichengTF) {
        _nichengTF = [self createTFWithOriginalY:self.nameTF.frame.origin.y +self.nameTF.frame.size.height +20 title:@"昵称"];
    }
    return _nichengTF;
}
- (UIView *)sexSelectView{
    if (!_sexSelectView) {
        _sexSelectView = [[UIView alloc]initWithFrame:CGRectMake(20, self.nichengTF.frame.origin.y +self.nichengTF.frame.size.height +20, SCR_W - 40, 60)];
        _sexSelectView.backgroundColor= UIColor.redColor;
    }
    return  _sexSelectView;
}

- (UITextField *)addressTF{
    if (!_addressTF) {
        _addressTF = [self createTFWithOriginalY:self.sexSelectView.frame.origin.y +self.sexSelectView.frame.size.height +20 title:@"地址"];
    }
    return _addressTF;
}

- (UITextField *)emailTF{
    if (!_emailTF) {
        _emailTF = [self createTFWithOriginalY:self.addressTF.frame.origin.y +self.addressTF.frame.size.height +20 title:@"邮箱"];
    }
    return _emailTF;
}
#pragma mark ------ init---------
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.phoneTF];
        [self addSubview:self.addressTF];
        [self addSubview:self.nameTF];
        [self addSubview:self.nichengTF];
        [self addSubview:self.sexSelectView];
        [self addSubview:self.emailTF];
        [self addSubview:self.accountTF];
        
    }
    return self;
}
- (void)initUIWithUser:(User *)usr{
    self.phoneTF.text = usr.telphone;
    self.accountTF.text = usr.wxaccount;
    self.nameTF.text = usr.name;
    self.nichengTF.text = usr.nicheng;
    self.addressTF.text = usr.address;
    self.emailTF.text =usr.email;
}
-(void)handleUpdataUser//执行更新用户信息
{
    //获取登录人的信息
    User *u=[[UserDBService sharedDistance] getLoginUser];
    u.name = STRING_EMPIY(self.nameTF.text);
    
    u.nicheng = STRING_EMPIY(self.nichengTF.text);
    u.address = STRING_EMPIY(self.addressTF.text);
    u.email = STRING_EMPIY(self.emailTF.text);
    
    [self.delegate updataPersonalMessageWithUser:u];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
