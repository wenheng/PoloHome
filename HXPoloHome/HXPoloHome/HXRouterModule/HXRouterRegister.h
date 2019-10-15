//
//  HXRouterRegister.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/10/15.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HXPage){
  
  //Tab模块
  Page_Tab_First  = 100000, //第一个选项卡
  Page_Tab_Second = 100001, //第二个选项卡
  Page_Tab_Third  = 100002, //第三个选项卡
  Page_Tab_Fourth = 100003, //第四个选项卡
  
  //首页模块
  Page_Home_Index = 200000, //首页
  
  //商城模块
  Page_Mall_Index = 300000, //商城
  
  //发现模块
  Page_Discover_Index = 400000, //发现
  
  //个人中心模块
  Page_User_Index = 500000,//我的
  
  //测试模块
  Page_Test_Index  = 600000,
  Page_Test_Layout = 600001,
  
};

static const HXPage Tab_00_Name = Page_Tab_First;
static const HXPage Tab_01_Name = Page_Tab_Second;
static const HXPage Tab_02_Name = Page_Tab_Third;
static const HXPage Tab_03_Nmae = Page_Tab_Fourth;

@interface HXRouterRegister : NSObject

@property (nonatomic, copy) NSDictionary<NSNumber *, NSString *> *pageMap;

@end

NS_ASSUME_NONNULL_END
