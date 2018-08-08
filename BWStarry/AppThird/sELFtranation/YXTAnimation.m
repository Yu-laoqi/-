//
//  YXTAnimation.m
//  自定义转场
//
//  Created by 尹晓腾 on 2018/5/28.
//  Copyright © 2018年 BW. All rights reserved.
//

#import "YXTAnimation.h"

@implementation YXTAnimation
// 转场动画时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.35;
}

// 转场动画设置
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 获取跳转前，显示在屏幕上的控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 获取到将要显示的控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 获取一个类似于父视图的容器view
    UIView *containerView = transitionContext.containerView;
    
    // 用于获取当前控制器的view的对象
    UIView *fromView = nil;
    // 用于获取将显示的控制器的view对象
    UIView *toView = nil;
    
    
    // 判断控制器上带不带view，如果不带，用transitionContext获取
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    else {
        // 官方文档推荐不要使用此方式，而是使用上面👆的方式获取
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    // 需要将toView添加为子视图
    [containerView addSubview:toView];
    
    // 获取当前显示在屏幕的控制器的frame
    CGRect visableFrame = [transitionContext initialFrameForViewController:fromVC];
    // 获取屏幕左侧和屏幕等大小的frame
    CGRect leftHiddenFrame = CGRectMake(-visableFrame.size.width, visableFrame.origin.y, visableFrame.size.width, visableFrame.size.height);
    // 获取屏幕右侧和屏幕等大小的frame
    CGRect rightHiddenFrame = CGRectMake(visableFrame.size.width, visableFrame.origin.y, visableFrame.size.width, visableFrame.size.height);
    
    // toVc.presentingViewController --> 弹出toVc的controller
    // 所以如果是present的时候  == fromVc
    // 或者可以使用 fromVc.presentedViewController == toVc
    BOOL isPresenting = toVC.presentingViewController == fromVC;
    
    if (isPresenting) { // present Vc左移
        toView.frame = rightHiddenFrame;
        fromView.frame = visableFrame;
    }
    else{  // dismiss Vc右移
        toView.frame = leftHiddenFrame;
        fromView.frame = visableFrame;
    }
    
    // 执行动画
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (isPresenting) {
            toView.frame = visableFrame;
            fromView.frame = leftHiddenFrame;
        }
        else{
            toView.frame = visableFrame;
            fromView.frame = rightHiddenFrame;
        }
    } completion:^(BOOL finished) {
        BOOL canceled = transitionContext.transitionWasCancelled;
        if (canceled) {
            // 如果中途取消了就移除toView(可交互的时候会发生)
            [toView removeFromSuperview];
        }
        // 通知系统动画是否完成或者取消了
        [transitionContext completeTransition:!canceled];
    }];
    
}
@end





