//
//  HXRouterRegister.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/10/15.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXRouterRegister.h"

//controller
#import "HXHomeController.h"
#import "HXMallController.h"
#import "HXDiscoverController.h"
#import "HXMeController.h"




#import "HXLayoutController.h"
#import "HXHomeTestController.h"

@interface HXRouterRegister ()

@property (nonatomic, strong) NSMutableDictionary *classMap;

@end

@implementation HXRouterRegister

#pragma mark -
#pragma mark - Init Method
- (instancetype)init
{
  if (self = [super init]) {
    [self registerAllController];
  }
  return self;
}

#pragma mark -
#pragma mark - Public Method

#pragma mark -
#pragma mark - Pirvate Method
- (void)registerAllController
{
  self.classMap[@(Page_Tab_First)]      = @"HXHomeController";
  self.classMap[@(Page_Tab_Second)]     = @"HXMallController";
  self.classMap[@(Page_Tab_Third)]      = @"HXDiscoverController";
  self.classMap[@(Page_Tab_Fourth)]     = @"HXMeController";
  self.classMap[@(Page_Home_Index)]     = @"HXHomeController";
  self.classMap[@(Page_Mall_Index)]     = @"HXMallController";
  self.classMap[@(Page_Discover_Index)] = @"HXDiscoverController";
  self.classMap[@(Page_User_Index)]     = @"HXMeController";
  self.classMap[@(Page_Test_Index)]     = @"HXHomeTestController";
  self.classMap[@(Page_User_Index)]     = @"HXLayoutController";
  
  

  
  self.pageMap = self.classMap.copy;
}

#pragma mark -
#pragma mark - Getter Method
- (NSMutableDictionary *)classMap
{
  if (!_classMap) {
    _classMap = [[NSMutableDictionary alloc] init];
  }
  return _classMap;
}


@end
