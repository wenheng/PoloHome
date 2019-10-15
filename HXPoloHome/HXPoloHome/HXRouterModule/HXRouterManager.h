//
//  HXRouterManager.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/7/30.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXRouterRegister.h"


NS_ASSUME_NONNULL_BEGIN

@interface HXRouterManager : NSObject

@property (nonatomic, readonly) HXRouterRegister *registerHelper;

+ (instancetype)sharedInstance;
- (void)push:(NSInteger)pageId from:(UIViewController *)from params:(NSDictionary *)params delegate:(id)delegate;

- (void)popFrom:(UIViewController *)from params:(NSDictionary *)params;
- (void)popToRootFrom:(UIViewController *)from params:(NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
