//
//  ViewController.m
//  DJTransitionDemo
//
//  Created by Li,Dongjie on 2020/6/4.
//  Copyright © 2020 DJ. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "PresentDismissViewController.h"
#import "PushPopViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)pushAction:(id)sender {
    UIStoryboard *UpgradeHardware = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [UpgradeHardware instantiateViewControllerWithIdentifier:@"SecondViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)dj_pushAction:(id)sender {
    PushPopViewController *vc = [[PushPopViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)presentAction:(id)sender {
    UIStoryboard *UpgradeHardware = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [UpgradeHardware instantiateViewControllerWithIdentifier:@"SecondViewController"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)dj_presentAction:(id)sender {
    PresentDismissViewController *vc = [[PresentDismissViewController alloc] init];
    vc.transitioningDelegate = vc;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
