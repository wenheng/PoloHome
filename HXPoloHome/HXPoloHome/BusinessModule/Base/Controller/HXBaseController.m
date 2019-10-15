//
//  HXBaseController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "HXBaseController.h"

@interface HXBaseController ()

@end

@implementation HXBaseController

#pragma mark -
#pragma mark - Init Method
- (instancetype)init
{
  if (self = [super init]) {
    
  }
  return self;
}

#pragma mark -
#pragma mark - Life Cycle
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  NSLog(@"当前%@的self.View尺寸是 %@",NSStringFromClass([self class]),NSStringFromCGRect(self.view.frame));
}

#pragma mark -
#pragma mark - 横竖屏设置
- (BOOL)shouldAutorotate
{
  return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
  return UIInterfaceOrientationPortrait;
}

#pragma mark -
#pragma mark - Public Method
- (void)push:(NSInteger)pageId
{
  id delegate = nil;
  [[HXRouterManager sharedInstance] push:pageId from:self params:@{} delegate:delegate];
}
- (void)push:(NSInteger)pageId params:(NSDictionary *)params
{
  id delegate = nil;
  [[HXRouterManager sharedInstance] push:pageId from:self params:params delegate:delegate];
}
- (void)push:(NSInteger)pageId params:(NSDictionary *)params delegate:(nonnull id)delegate
{
  [[HXRouterManager sharedInstance] push:pageId from:self params:params delegate:delegate];
}

@end
