//
//  HXHomeTestController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/16.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXHomeTestController.h"

@interface HXHomeTestController ()

@end

@implementation HXHomeTestController

#pragma mark -
#pragma mark - Life Cycle
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor yellowColor];
  self.navigationItem.title = @"我是标题";
//  self.edgesForExtendedLayout = UIRectEdgeNone;
  UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
  testView.backgroundColor = [UIColor redColor];
  [self.view addSubview:testView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  NSLog(@"--");
}

@end
