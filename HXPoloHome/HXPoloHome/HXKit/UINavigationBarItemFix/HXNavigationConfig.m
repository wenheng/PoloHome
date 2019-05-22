//
//  HXNavigationConfig.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "HXNavigationConfig.h"

@implementation HXNavigationConfig

+ (instancetype)shared
{
  static HXNavigationConfig *config;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    config = [[self alloc] init];
  });
  return config;
}

- (instancetype)init
{
  if (self = [super init]) {
    [self initConfig];
  }
  return self;
}

- (void)initConfig
{
  self.hx_defaultFixSpace = 0.0f;
  self.hx_defaultFixSpace = -20.0f;
  self.hx_disableFixSpace = NO;
}

@end
