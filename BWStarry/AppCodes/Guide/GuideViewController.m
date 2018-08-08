//
//  GuideViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"
@interface GuideViewController ()<ImageScrollViewDelegate>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *imgNameArr=@[@"1",@"3",@"2"];
    
    ImageScrollView *guideSc=[[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H) style:ImageScrollType_Guide images:imgNameArr confirmBtnTitle:@"立即体验" confirmBtnTitleColor:[UIColor redColor] confirmBtnFrame:CGRectMake(SCR_W-100-20, 30, 100, 40) autoScrollTimeInterval:0 delegate:self];
    
    [self.view addSubview:guideSc];
    
    //添加分页控件
    [guideSc addPageControlToSuperView:self.view];
}
//立即体验
- (void)experienceDidHandle{
    //（1）切换窗口的根视图控制器
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController=app.sideMenu;
    
    //(2)将当前App的版本号持久化
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:CURRENT_VERSION forKey:SAVE_VERSION];
    [ud synchronize];
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
