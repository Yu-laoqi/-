//
//  NewsDetailViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation NewsDetailViewController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
        _webView.delegate=self;
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    //添加分享导航按钮
    [self addShaeritem];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSURL *url = [NSURL URLWithString:self.passUrlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];

    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
   // [self.view showMBProgressHUD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
   // [self.view hideMBProgressHUD];
     [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
}


//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    
//    NSLog(@"error====%@",error);
//    
//}

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
