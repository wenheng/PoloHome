//
//  HXHomeController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXHomeController.h"
#import "HXHomeView.h"

@interface HXHomeController ()

@property (nonatomic, readwrite) HXHomeView *view;

@end

@implementation HXHomeController

@dynamic view;

#pragma mark -
#pragma mark - Life Cycle
- (instancetype)init
{
  self = [super init];
  if(self) {
  }
  return self;
}
- (void)loadView
{
  CGFloat w = [UIApplication sharedApplication].keyWindow.frame.size.width;
  CGFloat h = [UIApplication sharedApplication].keyWindow.frame.size.height;
  CGFloat y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
  self.view = [[HXHomeView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
  
}
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor purpleColor];
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  NSLog(@"viewDidLayoutSubviews -- %@",self.view);
  NSLog(@"tableViewFrame --- %@",NSStringFromCGRect(self.view.tableView.frame));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//  [self.view setNeedsLayout];
//  [self.view layoutIfNeeded];
//  [self.view setNeedsDisplay];
  
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"userName"]  = @"张三";
  params[@"userPhone"] = @"13878789090";
  [self push:Page_Test_Index params:params.copy delegate:self];
}

@end
