//
//  HXWaterFlowLayout.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/29.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const HX_UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString * const HX_UICollectionElementKindSectionFooter;

@class HXWaterFlowLayout;
@protocol HXWaterFlowLayoutDelegate <NSObject>

//cell的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(HXWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWith:(CGFloat)itemWidth;
//处理移动相关的数据源
- (void)moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HXWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<HXWaterFlowLayoutDelegate>delegate;
@property (nonatomic, assign) NSInteger  numberOfColumns;//瀑布流列数
@property (nonatomic, assign) CGFloat  cellDistance;//cell之间的间距
@property (nonatomic, assign) CGFloat  topAndBottomDistance;//cell顶部和底部的间距
@property (nonatomic, assign) CGFloat  headerViewHeight;//头视图的高度
@property (nonatomic, assign) CGFloat  footerViewHeight;//尾视图的高度


@end

NS_ASSUME_NONNULL_END
