//
//  HXLayoutController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/10/15.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXLayoutController.h"

@interface HXLayoutController ()

@property (nonatomic, strong) MyLinearLayout *rootLayout;

@end

@implementation HXLayoutController

#pragma mark -
#pragma mark - Life Cycle
- (void)loadView
{
  [super loadView];
  
  MyLinearLayout *rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
  rootLayout.insetsPaddingFromSafeArea   = UIRectEdgeAll;
  rootLayout.insetLandscapeFringePadding = NO;
  rootLayout.myMargin = 0;
  [self.view addSubview:rootLayout];
  
  UIView *testView = [[UIView alloc] init];
  testView.backgroundColor = [UIColor blueColor];
  testView.myTop = HXLen(110);
  testView.mySize = CGSizeMake(100, 120);
  testView.myCenterX = 0;
  [rootLayout addSubview:testView];
  
  UILabel *label = [[UILabel alloc] init];
  label.myHorzMargin = HXLen(10);
  label.myTop = HXLen(20);
  label.weight = 1;
  label.numberOfLines = 0;
  label.text = @"这里是测试这里是测试这里是测试这里是测试这里是测试这里是测试这里是测试这里是测试这里是测试这里是测试这里是测试";
  [rootLayout addSubview:label];
  
}
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor yellowColor];
  

  
  
}

- (BOOL)shouldAutorotate
{
  return YES;
}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//  return UIInterfaceOrientationMaskAll;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//  return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//}

@end
