//
//  NewsCollectionViewCell.m
//  BWStarry
//
//  Created by 于泽峰 on 2018/6/6.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewCell

- (UITableView *)newsTable{
    if (!_newsTable) {
    _newsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-TAB_BAR_HEIGHT-40-TOP_BAR_HEIGHT-BottomSafeArea)style:UITableViewStylePlain];
}
    return _newsTable;
}
- (MJRefreshHeaderView *)mjHeader{
    if (!_mjHeader) {
        _mjHeader = [[MJRefreshHeaderView alloc]initWithScrollView:self.newsTable];
    }
    return _mjHeader;
    
}
- (MJRefreshFooterView *)mjfooter{
    if (!_mjfooter) {
        _mjfooter = [[MJRefreshFooterView alloc]initWithScrollView:self.newsTable];
    }
    
    return _mjfooter;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.newsTable];
    }
    return self;
}


@end
