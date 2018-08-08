//
//  PersonalViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/14.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonView.h"
@interface PersonalViewController ()<PresonalViewDelegate>
@property(nonatomic,strong)PersonView *pView;
@end

@implementation PersonalViewController
- (PersonView *)pView{
    if (!_pView) {
        _pView=[[PersonView alloc]initWithFrame:self.view.frame];
        _pView.delegate =self;
    }
    return _pView;
}
//当Controller
- (void)loadView{
    [super loadView];
    self.view =self.pView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor=[UIColor redColor];
    self.navigationItem.title=@"个人信息";
    //导航按钮、
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交修改" style:UIBarButtonItemStylePlain target:self action:@selector(updataUser)];
    
}
//提交修改
-(void)updataUser{
    [self.pView handleUpdataUser];
    
}
//执行操作
- (void)updataPersonalMessageWithUser:(User *)newUser{
    [[[URLservice alloc]init]updataLoginUser:newUser completion:^(id data, BOOL success) {
            if (success == NO) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.pView showMBHudWithMessage:data hide:2.6];
                });
                return ;
            }
        //如果成功，重新将User持久化
        [[UserDBService sharedDistance]saveLoginUser:(User *)data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.pView showMBHudWithMessage:@"修改成功" hide:2.2];
            //（3）时间过后触发方法
            [self performSelector:@selector(goBack) withObject:nil afterDelay:2.2];
        });
        
        
    }];
    
}
//返回上一视图
-(void)goBack{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    
    [self.pView initUIWithUser:[[UserDBService sharedDistance]getLoginUser]];
    
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
