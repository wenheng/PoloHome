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
  MyLinearLayout *rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
  rootLayout.backgroundColor             = [UIColor yellowColor];
  rootLayout.insetsPaddingFromSafeArea   = UIRectEdgeAll;
  rootLayout.insetLandscapeFringePadding = NO;
  self.view = rootLayout;
  
}
- (void)viewDidLoad
{
  [super viewDidLoad];
}

@end
