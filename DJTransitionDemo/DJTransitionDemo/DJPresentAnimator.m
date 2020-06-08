//
//  DJPresentAnimator.m
//  DJTransitionDemo
//
//  Created by Li,Dongjie on 2020/6/4.
//  Copyright © 2020 DJ. All rights reserved.
//

#import "DJPresentAnimator.h"

@implementation DJPresentAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext { 
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];

    UIView *fromView = nil;
    UIView *toView = nil;

    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }

    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);

    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];

    if (isPresenting) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width, 0);

        if (fromViewController.modalPresentationStyle == UIModalPresentationCustom) {
            [fromViewController beginAppearanceTransition:NO animated:YES];
        }

        [containerView addSubview:toView];

    } else {
        fromView.frame = fromFrame;
        toView.frame = toFrame;

        if (toViewController.modalPresentationStyle == UIModalPresentationCustom) {
            [toViewController beginAppearanceTransition:YES animated:YES];
        }

        [containerView insertSubview:toView belowSubview:fromView];
    }

    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting) {
            toView.frame = toFrame;
        } else {
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width, 0);
        }
    } completion:^(BOOL finished) {
        if (transitionContext.transitionWasCancelled) {
            if (isPresenting) {
                if (fromViewController.modalPresentationStyle == UIModalPresentationCustom) {
                    [fromViewController beginAppearanceTransition:YES animated:YES];
                    [fromViewController endAppearanceTransition];
                }
            } else {
                if (toViewController.modalPresentationStyle == UIModalPresentationCustom) {
                    [toViewController beginAppearanceTransition:NO animated:YES];
                    [toViewController endAppearanceTransition];
                }
            }
            [toView removeFromSuperview];
            [transitionContext completeTransition:NO];
        } else {
            if (isPresenting) {
                if (fromViewController.modalPresentationStyle == UIModalPresentationCustom) {
                    [fromViewController endAppearanceTransition];
                }
            } else {
                if (toViewController.modalPresentationStyle == UIModalPresentationCustom) {
                    [toViewController endAppearanceTransition];
                }
            }
            [transitionContext completeTransition:YES];
        }
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext { 
    return 0.5f;
}

@end
