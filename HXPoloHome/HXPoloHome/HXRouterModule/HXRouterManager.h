//
//  HXRouterManager.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/7/30.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXRouterConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HXRouterManager : NSObject

+ (instancetype)sharedInstance;
- (void)push:(NSInteger)pageId;
- (void)push:(NSInteger)pageId params:(NSDictionary *)params;
- (void)push:(NSInteger)pageId params:(NSDictionary *)params delegate:(id)delegate;
@end

NS_ASSUME_NONNULL_END
