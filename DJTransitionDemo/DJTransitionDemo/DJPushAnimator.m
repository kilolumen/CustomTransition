//
//  DJPushAnimator.m
//  DJTransitionDemo
//
//  Created by Li,Dongjie on 2020/6/4.
//  Copyright © 2020 DJ. All rights reserved.
//

#import "DJPushAnimator.h"

@implementation DJPushAnimator


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *fromView = nil;
    UIView *toView = nil;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }

    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    toView.frame = CGRectMake(width, 0, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        if (transitionContext.transitionWasCancelled) {
            [transitionContext completeTransition:NO];
        } else {
            [transitionContext completeTransition:YES];
        }
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

@end
