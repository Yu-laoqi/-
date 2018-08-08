//
//  GoodsListViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsDetailViewController.h"
@interface GoodsListViewController ()

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//单击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    GoodsDetailViewController *datailVC=[[GoodsDetailViewController alloc]init];
    [self.navigationController pushViewController:datailVC animated:YES];
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
