//
//  AppDelegate.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/10.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"//引导页
#import "LeftManuViewController.h"//左ce菜单
#import "MainViewController.h"//主视图
@interface AppDelegate ()
@property(nonatomic,strong)GuideViewController *guideVC;//引导页
@end

@implementation AppDelegate
#pragma mark ---属性实例化----
//引导页
- (GuideViewController *)guideVC{
    if (_guideVC==nil) {
        _guideVC=[[GuideViewController alloc]init];
      
    }
    
    
    return _guideVC;
}
//抽屉视图
- (RESideMenu *)sideMenu{
    if (!_sideMenu) {
        //内容视图
        MainViewController *mainVC=[[MainViewController alloc]init];
        LeftManuViewController *left=[[LeftManuViewController alloc]init];
        //抽屉视图实例化
        _sideMenu=[[RESideMenu alloc]initWithContentViewController:mainVC leftMenuViewController:left rightMenuViewController:nil];
        _sideMenu.backgroundImage=[UIImage imageNamed:@"Stars@2x"];
        //设置内容视图控制器是否可以缩放
        _sideMenu.scaleContentView=NO;
        //设置内容视图zaiX轴与中心点的距离
         _sideMenu.contentViewInPortraitOffsetCenterX=FIT_X(130);
    }
    
    return _sideMenu;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //获取上次运行时持久化的版本号数据
    NSString *savedVersion=[[NSUserDefaults standardUserDefaults]objectForKey:SAVE_VERSION];
    //如果数据不存在，表示是首次安装应用程序并运行
    if (savedVersion==nil) {
        //将引导页作为窗口的根视图控制器
        self.window.rootViewController=self.guideVC;
    }
    //持久化的版本号数据存在
    else{
        //持久化的版本号与当前的版本号一致，表示没有更新
        if ([savedVersion isEqualToString:CURRENT_VERSION]) {
            
        self.window.rootViewController=self.sideMenu;
            
        }else{
            //不一致，表示更新了
        self.window.rootViewController=self.guideVC;

        }
        
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
