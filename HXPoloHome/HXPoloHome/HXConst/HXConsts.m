//
//  HXConsts.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "HXConsts.h"

@implementation HXConsts

NSString * const HX_APP_KEY_QQ = @"";
NSString * const HX_APP_APPSECRET_QQ = @"";
NSString * const HX_APP_APPDIRECTURL_QQ = @"";

NSString * const HX_APP_KEY_SINA = @"";
NSString * const HX_APP_APPSECRET_SINA = @"";
NSString * const HX_APP_APPDIRECTURL_SINA = @"";

NSString * const HX_APP_KEY_WECHAT = @"";
NSString * const HX_APP_APPSECRET_WECHAT = @"";
NSString * const HX_APP_APPDIRECTURL_WECHAT = @"";

#ifdef DEBUG
NSString * const HX_APP_KEY_COUNTLY = @"";
#else
NSString * const HX_APP_KEY_COUNTLY = @"";//生产Key
#endif


NSString * const HX_APP_VERSION = @"HX_APP_VERSION";

@end

