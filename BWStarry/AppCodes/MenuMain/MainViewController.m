//
//  MainViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "MainViewController.h"
#import "NewsViewController.h"//新闻
#import "GoodsListViewController.h"//商城
#import "LiveListViewController.h"//直播
@interface MainViewController ()
@property(nonatomic,strong)UITabBarController *tabBarCtl;
@end

@implementation MainViewController
//根据不同的参数
-(UINavigationController *)creatNavWithControllerName:(NSString *)cName
    titlt:(NSString *)title
    imgName:(NSString *)name
    selectImgName:(NSString *)selName{
    
    //根据类的名称的字符串得到一个类的对象
    UIViewController *VC=[[NSClassFromString(cName)alloc]init];
    //设置导航标题
    VC.navigationItem.title=title;
    UINavigationController *Nav=[[UINavigationController alloc]initWithRootViewController:VC];
    Nav.tabBarItem=[[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:name] selectedImage:[UIImage imageNamed:selName]];
    return Nav;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *newsNav=[self creatNavWithControllerName:@"NewsViewController" titlt:@"新闻" imgName:@"TabBar_home_1@2x" selectImgName:@"TabBar_home_2@2x"];
    
   UINavigationController *goodsNav=[self creatNavWithControllerName:@"GoodsListViewController" titlt:@"商城" imgName:@"TabBar_shopCenter_1" selectImgName:@"TabBar_shopCenter_2"];
    
    UINavigationController *LiveNav=[self creatNavWithControllerName:@"LiveListViewController" titlt:@"直播" imgName:@"TabBar_dynamic_1" selectImgName:@"TabBar_dynamic_2"];
    
    self.tabBarCtl=[[UITabBarController alloc]init];
    self.view.backgroundColor=[UIColor whiteColor]; self.tabBarCtl.viewControllers=@[newsNav,goodsNav,LiveNav];
    //
    [self.view addSubview:self.tabBarCtl.view];
    
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
