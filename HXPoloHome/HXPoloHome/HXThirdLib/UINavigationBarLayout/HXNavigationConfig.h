//
//  HXNavigationConfig.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HXNavigationConfig : NSObject

/** item距离两端的距离 默认0 */
@property (nonatomic, assign) CGFloat  hx_defaultFixSpace;
/** iOS 11 之前调整间距 默认-20 */
@property (nonatomic, assign) CGFloat  hx_fixedSpaceWidth;
/** 是否禁止使用修正，默认为NO */
@property (nonatomic, assign) BOOL  hx_disableFixSpace;

+ (instancetype)shared;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

