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
  self.view = [[HXHomeView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
  
  NSLog(@"self.view.frame %@ ---",NSStringFromCGRect(self.view.frame));
}
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.edgesForExtendedLayout = UIRectEdgeNone;

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
}

- (void)testArray
{
  NSLog(@"-----%@",self.view);
}

@end
