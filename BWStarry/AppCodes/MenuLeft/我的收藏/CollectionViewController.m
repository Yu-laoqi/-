
//
//  CollectionViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/14.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionDetailViewController.h"
@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor=[UIColor greenColor];
    self.navigationItem.title=@"我的收藏";
}
//
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    CollectionDetailViewController *detailVC=[[CollectionDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    
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
