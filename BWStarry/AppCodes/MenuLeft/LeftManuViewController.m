//
//  LeftManuViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "LeftManuViewController.h"
#import "PersonalViewController.h"
#import "CollectionViewController.h"
#import "AboutUsViewController.h"
#import "YXTAnimation.h"
@interface LeftManuViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>

{
    NSArray *_tableData;//给表格赋值的数组
    
    
}
@property(nonatomic,strong)UIImageView *headImgView;//头像视图
@property(nonatomic,strong)UILabel *accountlabel;//账号标签
@property(nonatomic,strong)UITableView *table;//选项表格


@property(nonatomic,strong)UINavigationController *personalVCNav;//个人信息
@property(nonatomic,strong)UINavigationController *collectionVCNav;//收藏
@property(nonatomic,strong)UINavigationController *aboutUSVCNav;//关于我们
@property(nonatomic,strong)YXTAnimation *yxtAnimation;//转场动画对象
@end

@implementation LeftManuViewController
#pragma mark  -----转场动画对象-------
- (YXTAnimation *)yxtAnimation{
    if (!_yxtAnimation) {
        _yxtAnimation = [[YXTAnimation alloc]init];
    }
    return _yxtAnimation;
}

#pragma mark  -----控制器创建-------
//个人信息
- (UINavigationController *)personalVCNav{
    if (!_personalVCNav) {
        _personalVCNav=[[UINavigationController alloc]initWithRootViewController:[[PersonalViewController alloc]initWithMenuType:MenuType_left]];
    }
    return _personalVCNav;
}
//收藏
- (UINavigationController *)collectionVCNav{
    if (!_collectionVCNav) {
        _collectionVCNav=[[UINavigationController alloc]initWithRootViewController:[[CollectionViewController alloc]initWithMenuType:MenuType_left]];
    }
    return _collectionVCNav;
}
//关于我们
- (UINavigationController *)aboutUSVCNav{
    if (!_aboutUSVCNav) {
        _aboutUSVCNav=[[UINavigationController alloc]initWithRootViewController:[[AboutUsViewController alloc]initWithMenuType:MenuType_left]];
        
    }
    return _aboutUSVCNav;
}
#pragma mark-----控件创建-----
//头像视图创建
- (UIImageView *)headImgView{
    if (!_headImgView) {
        
        _headImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FIT_X(80), FIT_X(80))];
        _headImgView.center=CGPointMake((SCR_W/2+FIT_X(130))/2, TOP_BAR_HEIGHT+FIT_X(40));
        _headImgView.image=[UIImage imageNamed:@"背景2"];
        _headImgView.clipsToBounds=YES;
        _headImgView.layer.cornerRadius=FIT_X(40);
        //开启用户相互功能
        _headImgView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImgDidPress:)];
        //添加手势
        [_headImgView addGestureRecognizer:tap];
    }
    return _headImgView;
}
//账号标签-
- (UILabel *)accountlabel{
    
    if (!_accountlabel) {
        _accountlabel=[[UILabel alloc]initWithFrame:CGRectMake(FIT_X(20), self.headImgView.frame.origin.y+self.headImgView.frame.size.height+15, SCR_W/2+FIT_X(130)-FIT_X(40), FIT_X(40))];
        //剧中对齐
        _accountlabel.textAlignment=NSTextAlignmentCenter;
        _accountlabel.textColor=[UIColor whiteColor];
       // _accountlabel.backgroundColor=[UIColor yellowColor];
        _accountlabel.font=[UIFont systemFontOfSize:26.];
        _accountlabel.text=@"yuzefeng";
        _accountlabel.hidden=YES;
        
    }
    return _accountlabel;
}
//选项的表格
- (UITableView *)table{
    if (!_table) {
        _table=[[UITableView alloc]initWithFrame:CGRectMake(20, self.accountlabel.frame.origin.y+self.accountlabel.frame.size.height+20, SCR_W/2+FIT_X(130)-FIT_X(40), FIT_X(320))];
        _table.rowHeight=FIT_X(80);
        _table.scrollEnabled=NO;
        _table.backgroundColor=[UIColor clearColor]; _table.separatorStyle=UITableViewCellSeparatorStyleNone;
        _table.delegate=self;
        _table.dataSource=self;
    
    }
    
    return _table;
}
#pragma mark-----UIViewControllerTransitioningDelegate-------

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    
    return self.yxtAnimation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return  self.yxtAnimation;
}



#pragma mark------控件方法------
//头像视图点击触发
-(void)headImgDidPress:(id)sender{
    UIAlertController *alertCtl=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"选择了拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  dianzhong拍摄按钮回调的代码块
        NSLog(@"选择了拍摄");
        
    }]];
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"从手机相册选择");
        
    }]];
    
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertCtl animated:YES completion:nil];
    
}

#pragma mark   ----UITableViewDataSource-----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //如果登录了，显示tableData数组中的所有数据
    if ([[UserDBService sharedDistance]userhadlogin]) {
        return _tableData.count;
        
    }//如果没有登录
    else{
        
            return _tableData.count - 1;
        
    }

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.textColor=[UIColor whiteColor];

    
    cell.textLabel.font=[UIFont systemFontOfSize:FONT_FIT(22)];
   cell.backgroundColor=[UIColor clearColor]; cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=_tableData[indexPath.row];
    return cell;
}
#pragma mark------UITableViewDelegate------



//点几单元格触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    //未登录，进入登录视图
    if (![[UserDBService sharedDistance]userhadlogin ]) {
        LoginViewController *loginVC=[LoginViewController getInstance];
        loginVC.transitioningDelegate =self;
        //进入登录视图
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    
    
    switch (indexPath.row) {
        case 0:
            //个人信息
            [self presentViewController:self.personalVCNav animated:YES completion:nil];
            
            break;
            case 1:
            //我的收藏
            [self presentViewController:self.collectionVCNav animated:YES completion:nil];

            break;
        case 2:
            //关于我们
            [self presentViewController:self.aboutUSVCNav animated:YES completion:nil];

            break;
        case 3:
        {
            NSLog(@"退出登录");
            [[UserDBService sharedDistance] clearLoginUser];
            //UIs刷新
            [self resetHeadImageAndReqReloadTable];
            //发出退出登录
            [[NSNotificationCenter defaultCenter]postNotificationName:LogoutNotificationName object:nil];
            
    }
            break;
            
        default:
            break;
    
    
    }
}
#pragma mark---- 私有方法，重制头像-----
- (void)resetHeadImageAndReqReloadTable{
    
    //判断有无登录，没有登录，显示默认头像
    if (![[UserDBService sharedDistance]userhadlogin]) {
        self.headImgView.image=[UIImage imageNamed:@"背景2"];
        self.accountlabel.hidden=YES;
    }
    //登录
    else{
        //获取登录人信息
        User *u=[[UserDBService sharedDistance]getLoginUser];
        //显示账号标签
        self.accountlabel.hidden=NO;
        self.accountlabel.text=u.wxaccount;
        //获取头像信息
        if (u.headimg==nil||[u.headimg isEqual:[NSNull null]]||[u.headimg isEqual:@""]) {
            
            self.headImgView.image=[UIImage imageNamed:@"边框"];
        }else{
            //
            NSURL *url=[NSURL URLWithString:HOST_URL_APPEND(u.headimg)];
            
            [self.headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"边框"]];
            
        }
        
    }
    //刷新表格
    [self.table reloadData];
    
}

#pragma mark---- View Load-----

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加头像
    [self.view addSubview:self.headImgView];
    [self.view addSubview:self.accountlabel];
    
    //初始化表格数组bing添加表格
    _tableData=@[@"个人资料",@"我的收藏",@"关于我们",@"退出登录"];
    [self.view addSubview:self.table];
   
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏导航条
    self.navigationController.navigationBarHidden=YES;
    //
    [self resetHeadImageAndReqReloadTable];
   
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
