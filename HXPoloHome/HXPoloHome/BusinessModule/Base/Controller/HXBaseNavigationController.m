//
//  HXBaseNavigationController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXBaseNavigationController.h"

@interface HXBaseNavigationController ()

@end

@implementation HXBaseNavigationController

#pragma mark -
#pragma mark - Life Cycle
- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return self.topViewController.preferredStatusBarStyle;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return self.topViewController.supportedInterfaceOrientations;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
  return self.topViewController.preferredInterfaceOrientationForPresentation;
}
- (BOOL)shouldAutorotate
{
  return self.topViewController.shouldAutorotate;
}

#pragma mark -
#pragma mark - UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  
  if (self.childViewControllers.count > 0 ) {
    viewController.hidesBottomBarWhenPushed = YES;
  }
  [super pushViewController:viewController animated:animated];
  
}

@end
