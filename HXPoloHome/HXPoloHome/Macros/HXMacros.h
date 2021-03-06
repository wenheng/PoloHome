//
//  HXMacros.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#ifndef HXMacros_h
#define HXMacros_h

#pragma mark -
#pragma mark - 日志

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

#define UMELog(fmt, ...) NSLog((@"\n函数:%s""\n""行数:%d" "\n" "内容:" fmt) , __FUNCTION__, __LINE__, ##__VA_ARGS__); //带函数名和行数

#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#define HXLog(fmt, ...)

#endif


#pragma mark -
#pragma mark - 设备
/** 判断是否是iPad */
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
/** 判断是否是iPhone4系列 */
#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
/** 判断iPhone5系列 */
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/** 判断iPhone6系列 */
#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
/** 判断iphone6 plus系列 */
#define IS_IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
/** 判断iPHoneXR */
#define IS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
/** 判断iPhoneX/XS */
#define IS_IPHONE_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/** 判断iPhoneXS Max */
#define IS_IPHONE_XS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
/** 判断iPhone X系列 */
//#define IS_IPHONE_Series IS_IPHONE_XR || IS_IPHONE_XS || IS_IPHONE_XS_Max
#define IS_IPHONE_X_Series [UIScreen mainScreen].bounds.size.height >= 812.0

#pragma mark -
#pragma mark - UI宏
//状态栏
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏
#define kNavigationBarHeight 44.0
//顶部高度 = 状态栏 + 导航栏
#define kTopHeight (kStatusBarHeight + kNavigationBarHeight)
//tabbar高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.1 ? 83.0 : 49.0)
//底部圆弧（全面屏系列专有）
#define kTabBarArcHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.1 ? 34.0 : 0.0)

//iPhone的宽度
#define kIPHONE_WIDTH [[UIScreen mainScreen] bounds].size.width
//iPhone的高度
#define kIPHONE_HEIGHT [[UIScreen mainScreen] bounds].size.height

#pragma mark -
#pragma mark - 适配
//设计基准尺寸 375 * 667
//适配宽度
#define HXWidth(width)  (kIPHONE_WIDTH != 375 ? (width)*kIPHONE_WIDTH/375 : (width))
//适配高度
#define HXHeight(height) (kIPHONE_WIDTH != 375 ? (height)*kIPHONE_WIDTH/375 : (height))
//适配字体大小
#define UMEAdaptFont(font) (kIPHONE_WIDTH != 375 ? floor((font)*kIPHONE_WIDTH / 375) : (font))



#endif /* HXMacros_h */
