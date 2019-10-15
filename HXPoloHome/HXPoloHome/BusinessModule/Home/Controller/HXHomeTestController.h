//
//  HXHomeTestController.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/16.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HXHomeTestController : HXBaseController

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, weak) id delegate;

@end

NS_ASSUME_NONNULL_END
