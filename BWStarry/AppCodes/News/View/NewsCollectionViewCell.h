//
//  NewsCollectionViewCell.h
//  BWStarry
//
//  Created by 于泽峰 on 2018/6/6.
//  Copyright © 2018年 BW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UITableView *newsTable;
@property(nonatomic,strong)MJRefreshHeaderView *mjHeader;
@property(nonatomic,strong)MJRefreshFooterView *mjfooter;//上拉
@end









