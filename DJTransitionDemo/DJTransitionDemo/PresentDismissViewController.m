//
//  PresentDismissViewController.m
//  DJTransitionDemo
//
//  Created by Li,Dongjie on 2020/6/5.
//  Copyright © 2020 DJ. All rights reserved.
//

#import "PresentDismissViewController.h"
#import "DJPresentAnimator.h"

@interface PresentDismissViewController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation PresentDismissViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];

    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake((screenWidth - 140.f) / 2.f, (screenHeight - 50.f) / 2.f, 140.f, 50.f);
    backButton.backgroundColor = [UIColor whiteColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@:%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@:%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@:%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@:%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

#pragma mark - Action
- (void)panHandler:(UIPanGestureRecognizer *)gesture {
    CGFloat process = [gesture translationInView:self.view].x / ([UIScreen mainScreen].bounds.size.width);
    process = MIN(1.0,(MAX(0.0, process)));

    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (gesture.state == UIGestureRecognizerStateChanged){
        [self.interactiveTransition updateInteractiveTransition:process];
    } else if (gesture.state == UIGestureRecognizerStateEnded
              || gesture.state == UIGestureRecognizerStateCancelled){
        if (process > 0.5) {
            [ self.interactiveTransition finishInteractiveTransition];
        } else {
            [ self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
    }
}

- (void)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[DJPresentAnimator alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DJPresentAnimator alloc] init];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}

@end
