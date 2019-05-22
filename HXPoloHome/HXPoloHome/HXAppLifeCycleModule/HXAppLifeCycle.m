//
//  HXAppLifeCycle.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "HXAppLifeCycle.h"
#import "HXTabBarController.h"
#import "HXNewFeatureController.h"


@interface HXAppLifeCycle ()

@end

@implementation HXAppLifeCycle

#pragma mark -
#pragma mark - Life Cycle
static id _instance;
+ (id)allocWithZone:(struct _NSZone *)zone
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [super allocWithZone:zone];
  });
  return _instance;
}

+ (instancetype)sharedInstance
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [[self alloc] init];
  });
  return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
  return _instance;
}

#pragma mark -
#pragma mark - Public Method
- (void)configAppModule
{
  UIApplication *application = [UIApplication sharedApplication];
  application.delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  application.delegate.window.backgroundColor = [UIColor whiteColor];
  [application.delegate.window makeKeyAndVisible];
  
  NSString *key = @"CFBundleVersion";
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *lastVersion = [defaults stringForKey:key];
  
  NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
  if ([currentVersion isEqualToString:lastVersion]) {
    HXTabBarController *tabController = [[HXTabBarController alloc] init];
    application.delegate.window.rootViewController = tabController;
  }
  else {//new
    HXNewFeatureController *newVC = [[HXNewFeatureController alloc] init];
    application.delegate.window.rootViewController = newVC;
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}


@end
