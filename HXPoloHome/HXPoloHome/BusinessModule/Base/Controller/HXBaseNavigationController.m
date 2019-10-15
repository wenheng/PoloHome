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

#pragma mark -
#pragma mark - Private Method
- (UIStatusBarStyle)preferredStatusBarStyle
{
  return self.visibleViewController.preferredStatusBarStyle;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return self.visibleViewController.supportedInterfaceOrientations;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
  return self.visibleViewController.preferredInterfaceOrientationForPresentation;
}
- (BOOL)shouldAutorotate
{
  return self.visibleViewController.shouldAutorotate;
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
