//
//  NewsViewController.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/4/12.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "NewsViewController.h"
#import "TitleSelectViewController.h"
#import "NewsCollectionViewCell.h"
#import "News.h"
#import "NewsDetailViewController.h"
@interface NewsViewController ()<UICollectionViewDataSource,UITableViewDataSource,UICollectionViewDelegate,UITableViewDelegate>{
    NSArray *_titleArr;//标题数组
    NSMutableArray *_tableDataArr;//用来给表格赋值的数组
    int _currentTitleID;//当前选中的标题的ID
    NSMutableDictionary *_cachaDic;//用于缓存数据的字典
    NSInteger _rowsNum;//存储表格行数的变量
    
    
}
@property(nonatomic,strong)UIScrollView *titleScrView;//标题滚动视图
@property(nonatomic,strong)UIView *underLineView;//标题底部的线条视图
@property(nonatomic,strong)UICollectionView *contentColView;//显示新闻数据的网格视图

@property(nonatomic,strong)NewsDetailViewController *deatialVC;

@end

@implementation NewsViewController

- (NewsDetailViewController *)deatialVC{
    if (!_deatialVC) {
        _deatialVC = [[NewsDetailViewController alloc]init];
    }
    return _deatialVC;
    
}


//标题滚定视图
- (UIScrollView *)titleScrView{
    if (!_titleScrView) {
        _titleScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 40)];
        //设置内容视图大小
        _titleScrView.contentSize = CGSizeMake(SCR_W *2, 40);
        //隐藏滚动条
        _titleScrView.showsHorizontalScrollIndicator = NO;
        //设置代理
        _titleScrView.delegate = self;
        //添加子视图
        for (int i=0; i<_titleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCR_W/2 * i, 0, SCR_W/2, 38);
            //设置Normal状态的标题文本及颜色
            [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            //设置选中状态的标题文本及颜色
            [btn setTitle:_titleArr[i] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            //添加事件
            [btn addTarget:self action:@selector(titleBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100 + i;
            if (i == 0) {
                btn.selected = YES;
            }
            //加为滚动视图的子视图
            [_titleScrView addSubview:btn];
        }
        //
        [_titleScrView addSubview:self.underLineView];
    }
    return _titleScrView;
}
//底部线条视图
- (UIView *)underLineView{
    if (!_underLineView) {
        _underLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, SCR_W/2, 1.5)];
        _underLineView.backgroundColor = [UIColor redColor];
    }
    return _underLineView;
}
#pragma mark - ---Mathods-----
//标题按钮触发事件
-(void)titleBtnDidPress:(UIButton *)sender{
    //如果选中当前选中的按钮
    if (_currentTitleID ==(int)sender.tag -100) {
        return;
    }
    
    
    //(1)将选中的button的tag值赋值给选中标题ID
    _currentTitleID = (int)sender.tag -100;
    
    //(2)将点中的button设置为选中状态，将其他button设置为默认状态
    for(UIView *sub in self.titleScrView.subviews){
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            //先把所有的Button设置为默认状态
            btn.selected = NO;
            //将选中的button设置为选中状态
            if (btn.tag ==sender.tag) {
                btn.selected = YES;
            }
        }
        
    }
    //(3)让线跟着滚动
    [UIView animateWithDuration:0.165 animations:^{
        
        self.underLineView.frame = CGRectMake(SCR_W/2 * (sender.tag -100), 38, SCR_W/2, 1.5);

    }];
    //(4)让下面的网格跟着滚动
    int index= (int)sender.tag -100;
    [self.contentColView setContentOffset:CGPointMake(SCR_W *index, 0) animated:NO];
    //(5)刷新数据
    [self requestNetWorkData];
}
//网格视图
- (UICollectionView *)contentColView{
    
    if (!_contentColView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        //设置单元格大小
        flow.itemSize = CGSizeMake(SCR_W, SCR_H-TOP_BAR_HEIGHT-TAB_BAR_HEIGHT-BottomSafeArea-40);
        //设置滚动方向,水平滚动
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumLineSpacing = 0.0;
        //实例化网格视图
        _contentColView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, SCR_W, SCR_H-TOP_BAR_HEIGHT-40-TAB_BAR_HEIGHT-BottomSafeArea) collectionViewLayout:flow];
        //分液效果
        _contentColView.pagingEnabled = YES;
        _contentColView.showsHorizontalScrollIndicator = NO;
        //注册单元格
        [_contentColView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        //设置网格的代理
        _contentColView.dataSource = self;
        _contentColView.delegate = self;
        
    }
    return  _contentColView;
}
#pragma mark  ---- UICollectionViewDataSource-----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//分区中有多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}
//设置单元格内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //复用字符串
    static NSString *ident = @"cell";
    //从复用池中取出一块内存
    NewsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ident forIndexPath:indexPath];
    if (cell == nil) {
        cell=[[NewsCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, SCR_W,SCR_H-40-TOP_BAR_HEIGHT-TAB_BAR_HEIGHT-BottomSafeArea)];
    }
    cell.newsTable.dataSource = self;
    cell.newsTable.delegate =self;
    [cell.newsTable reloadData];
    
    
    //如果执行下拉刷新操作
    [cell.mjHeader setBeginRefreshingBlock:^(MJRefreshBaseView *refreshView) {
        //把缓存中的key清空
        NSString *key = [NSString stringWithFormat:@"%d",self->_currentTitleID];
        [self->_cachaDic setValue:nil forKey:key];
        //把表格行数设置为初始的20
        self->_rowsNum =20;
        
        //请求网络数据
        [self requestNetWorkData];
        
    }];
    //执行上拉刷新操作
    
    cell.mjfooter = [[MJRefreshFooterView alloc]initWithScrollView:cell.newsTable];
    
    [cell.mjfooter setBeginRefreshingBlock:^(MJRefreshBaseView *refreshView) {
        //(1)改变行数数值
        if (self->_rowsNum < self->_tableDataArr.count) {
            self->_rowsNum += 20;
            
        }
        else{
            self->_rowsNum = self->_tableDataArr.count;
        }
        //刷新网格
        [self.contentColView reloadData];
    
        //停止上拉刷新
        [refreshView endRefreshing];
        [refreshView removeFromSuperview];
        refreshView = nil;
        
    }];

    return cell;
}
#pragma mark --------UIscrollectionViewDelegate---------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1如果是标题滚动视图，不执行
    if (scrollView == self.titleScrView) {
        return;
    }
    
    //得到在水平方向滚动的距离
    CGFloat disX = self.contentColView.contentOffset.x;
    //计算出现在正在展示哪个tableView
    int index = disX /SCR_W;
    //标题栏跟着变化
    //(2)将点中的button设置为选中状态，将其他button设置为默认状态
    for(UIView *sub in self.titleScrView.subviews){
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            //先把所有的Button设置为默认状态
            btn.selected = NO;
            //将选中的button设置为选中状态
            if (btn.tag == 100+index ) {
                btn.selected = YES;
            }
        }
        
    }
   ;
    //(3)标题滚动视图跟着滚动
    [self.titleScrView scrollRectToVisible:CGRectMake(SCR_W/2 * index, 0, SCR_W/2, 38) animated:YES];
    
    //(4)让线跟着滚动
    [UIView animateWithDuration:0.165 animations:^{
        
        self.underLineView.frame = CGRectMake(SCR_W/2 * index, 38, SCR_W/2, 1.5);
        
    }];

    //5如果显示的单元格滚动式显示该单元格，不做任何处理
    if(_currentTitleID == index){
        return;
    }

    
    //(6)选中标题ID赋值,请求网络数据
    _currentTitleID = index;
    
    [self requestNetWorkData];
}
#pragma mark -------UITableViewdelegate----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    News *selectNews = _tableDataArr[indexPath.row];
    self.deatialVC=[[NewsDetailViewController alloc]init];
    self.deatialVC.passUrlStr=selectNews.txturl;
    [self.navigationController pushViewController:self.deatialVC animated:NO];
    
}


#pragma mark -------UITableViewDataSource----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_rowsNum < _tableDataArr.count) {
        return _rowsNum;
    }
    return _tableDataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //cell赋值
    
    News *one = _tableDataArr[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text =one.title;
    //网址字符串
    NSString *imgURLStr = HOST_URL_APPEND(one.uploadimgurl);
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgURLStr] placeholderImage:[UIImage imageNamed:@"left_personal@2x"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize itemSize = CGSizeMake(50, 50);
        
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }];
    
    
    
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将缓存字典实例化
    _cachaDic = [[NSMutableDictionary alloc]init];
    
    _titleArr = @[@"商会动态",@"实证新闻动态",@"平远新闻",@"博丰雅颂"];
   // _tableDataArr = [@[@"商会动态",@"商会",@"",@"",@""]mutableCopy];

    //添加标题视图
    [self.view addSubview:self.titleScrView];
    //添加网格视图
    [self.view addSubview:self.contentColView];
    
    //初始标题的ID
    _currentTitleID = 0;
    
    //表格行数初始值
    _rowsNum = 20;
    
      
    //请求网络数据
    [self requestNetWorkData];
}
//请求网络数据
-(void)requestNetWorkData{
    //先将表格数据清空
    NSString *key = [NSString stringWithFormat:@"%d",_currentTitleID];
    self->_tableDataArr = [_cachaDic objectForKey:key];
    [self.contentColView reloadData];
    
    //如果不为控，不请求数据
    if (self->_tableDataArr != nil) {
        return;
    }
    //请求网络数据
    NSString *IDStr = [NSString stringWithFormat:@"%d",_currentTitleID];
    [[[URLservice alloc]init] getNewsDataWithChangeID:IDStr completion:^(id data, BOOL success) {
        //停止下拉刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            NewsCollectionViewCell *cell=(NewsCollectionViewCell *)[self.contentColView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self->_currentTitleID inSection:0]];
            [cell.mjHeader endRefreshing];
        });
        
        if (!success) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.view showMBHudWithMessage:data hide:2.5];
                
            });
            return ;
        }
        NSLog(@"data==%@",data);
        //如果成功，data是一个newS对象数组
       self-> _tableDataArr = [data mutableCopy];
        //缓存到字典中
        [_cachaDic setObject:data forKey:key];
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentColView reloadData];
        });
        
    }];
    
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
