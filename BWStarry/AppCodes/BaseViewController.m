//
//  BaseViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/16.
//  Copyright © 2018年 BW. All rights reserved.
//
 
#import "BaseViewController.h"

@interface BaseViewController (){
    MenuType _type;//表示控制器类型的枚举值
    UIButton *headBtn;
    
}
@property(nonatomic,strong)UIView *sharePopView;//分享视图
@end

@implementation BaseViewController


//重写init方法，使用alloc init 方式创建控制器对象时，对象的menutype默认都是抽屉内容样式
- (instancetype)init{
    self=[super init];
    if (self) {
        _type=MenuType_Content;//默认为内容样式
    }
    return self;
}


//实现init重载方法，使用alloc initWithMenutype方法创建对象时给type设置什么类型，对象就是什么类型
- (instancetype)initWithMenuType:(MenuType)type{
    self=[super init];
    if (self) {
        _type=type;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationItem_background"] forBarMetrics:UIBarMetricsDefault];
    //导航标签文本颜色
    self.navigationController.navigationBar.titleTextAttributes=@{
                                                                  NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                                  };
    //如果是导航的根，左侧添加一个头像按钮
    if (self.navigationController.viewControllers[0]==self) {
        //属于抽屉的内容视图，添加头像按钮
        if (_type==MenuType_Content) {
            
            [self addHeadImageButton];
        }else{
            
            [self addBackButton];
            
        }
        
    }else{
         //如果不是导航的根，左侧添加一个返回按钮
        //添加返回按钮
        [self addBackButton];
        
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetHeadImageButton) name:LogoutNotificationName object:nil];
   
}

-(void)resetHeadImageButton{
    //判断有无登录，没有登录，显示默认头像
    if (![[UserDBService sharedDistance]userhadlogin]) {
        [headBtn setImage:[UIImage imageNamed:@"背景2"] forState:UIControlStateNormal];
    }
    //登录
    else{
        //获取登录人信息
        User *u=[[UserDBService sharedDistance]getLoginUser];
        //获取头像信息
        if (u.headimg==nil||[u.headimg isEqual:[NSNull null]]||[u.headimg isEqual:@""]) {
            
            [headBtn setImage:[UIImage imageNamed:@"边框"] forState:UIControlStateNormal];
        }else{
            //
            NSURL *url=[NSURL URLWithString:HOST_URL_APPEND(u.headimg)];
            
            [headBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"边框"]];
            
            
            
        }
        
        
    }
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //哦判断该控制器是不是导航的根控制器，如果是，就显示标签栏，如果不是，就隐藏标签栏
    if (self.navigationController.viewControllers[0]==self) {
        self.tabBarController.tabBar.hidden=NO;
        
    }else{
         self.tabBarController.tabBar.hidden=YES;
      
        }
   
    [self resetHeadImageButton];
    }
#pragma mark---  私有方法----
//tian加头像按钮
-(void)addHeadImageButton{
    
    headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.frame=CGRectMake(0, 0, 36, 36);
    [headBtn setImage:[UIImage imageNamed:@"背景2"] forState:UIControlStateNormal];
    headBtn.clipsToBounds=YES;
    headBtn.layer.cornerRadius=36/2;
    [headBtn addTarget:self action:@selector(headBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
    [view addSubview:headBtn];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:view];
    
}

//添加返回按钮
-(void)addBackButton{
    //如果不是导航的根，左侧添加一个返回按钮
    //添加返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 36, 36);
    [backBtn setImage:[UIImage imageNamed:@"navigationItem_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
}
#pragma mark ---控件触发方法 ----
//点击返回按钮触发方法
-(void)back:(id)sender{
    
    //如果popView在屏幕上就隐藏
    if ([self popViewIsInScreen]) {
        [UIView animateWithDuration:0.135 animations:^{
            //隐藏膜层视图
            UIView *backView = [self.view viewWithTag:999];
            [backView removeFromSuperview];
            backView = nil;
            
            
            self.sharePopView.frame =CGRectMake(0, SCR_H, SCR_W, 300);
        }];
    }
    
    //如果是抽屉内容视图上的二级，三级页面上的返回按钮，点击按钮让导航控制器作出栈操作，
    if (self.navigationController.viewControllers[0]==self) {
        //如果是抽屉左侧菜单的主视图，返回按钮点击后让导航Dismiss
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        //如果是抽屉内容视图上的二级，三级页面上的返回按钮，点击按钮让导航控制器作出栈操作，
        
    }else{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    }
    
}
//点击头像按钮触发的方法
-(void)headBtnDidPress:(UIButton *)sender{
    //获取Appdelegate中的SideMenu属性
    [[App_Delegate sideMenu] presentLeftMenuViewController];
}
#pragma mark -------分享按钮及视图---------
//在导航上添加分享按钮
-(void)addShaeritem{
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame =CGRectMake(0, 0, 43, 43);
    [shareBtn setImage:[UIImage imageNamed:@"navigationItem_share"] forState:UIControlStateNormal];
    
    [shareBtn addTarget:self action:@selector(showOrHideSharepopView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    //添加view子视图
    [self.view addSubview:self.sharePopView];
    
}
//实例化弹出式图
- (UIView *)sharePopView{
    if (!_sharePopView) {
        
        _sharePopView = [[UIView alloc]initWithFrame:CGRectMake(0, SCR_H, SCR_W, 300)];
        _sharePopView.backgroundColor =[UIColor lightGrayColor];
        //
        NSArray *imgArr= @[@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_1"];
        NSArray *titleArr=@[@"微信好友",@"朋友圈",@"QQ好友",@"微博"];
        
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 300)];
        images.image = [UIImage imageNamed:@"beijing1"];
        [_sharePopView addSubview:images];
        
        
        //按钮的宽度
        CGFloat btnWidth = 60;
        //按钮的距离
        CGFloat dis = (SCR_W -btnWidth *imgArr.count) /(imgArr.count +1);
        
        //使用for
        for (int i =0; i< imgArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame =CGRectMake(dis+(dis+btnWidth)*i, 50, btnWidth, btnWidth);
        //
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        //
            [_sharePopView addSubview:btn];
            
        }
        //添加手势触摸
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHideSharepopView:)];
        [_sharePopView addGestureRecognizer:tap];
        //清扫手势
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHideSharepopView:)];
        swipe.direction = UISwipeGestureRecognizerDirectionDown;
        [_sharePopView addGestureRecognizer:swipe];
        
        
    }
    return _sharePopView;
}
//判断popView是否显示在屏幕上
-(BOOL)popViewIsInScreen{
    if (CGRectEqualToRect(self.sharePopView.frame, CGRectMake(0, SCR_H-300, SCR_W, 300))) {
        return YES;
        
    }
    
    return NO;
}


//显示或者隐藏弹出视图
-(void)showOrHideSharepopView:(id)sender{
    //如果popView在屏幕上就隐藏
    if ([self popViewIsInScreen]) {
        [UIView animateWithDuration:0.135 animations:^{
            //隐藏膜层视图
            UIView *backView = [self.view viewWithTag:999];
            [backView removeFromSuperview];
            backView = nil;

            
             self.sharePopView.frame =CGRectMake(0, SCR_H, SCR_W, 300);
        }];
        
    }else{
        
        //如果popView在不在屏幕上，就弹出popView
        [UIView animateWithDuration:0.135 animations:^{
            //添加膜层视图
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)];
            backView.backgroundColor=[UIColor clearColor];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHideSharepopView:)];
            [backView addGestureRecognizer:tap];
            backView.tag =999;
            [self.view addSubview: backView];
            
            [self.view bringSubviewToFront:self.sharePopView];
            
        
            
             self.sharePopView.frame =CGRectMake(0, SCR_H-300, SCR_W, 300);
        }];
       
    }
    
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
