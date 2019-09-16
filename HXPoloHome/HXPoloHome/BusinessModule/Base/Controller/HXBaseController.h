//
//  HXBaseController.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXRouterManager.h"
#import "UIViewController+HXNaviBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface HXBaseController : UIViewController


- (void)push:(NSInteger)pageId;
- (void)push:(NSInteger)pageId params:(NSDictionary *)params;
- (void)push:(NSInteger)pageId params:(NSDictionary *)params delegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
