//
//  HXFlowLayout.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/17.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXFlowLayout.h"

@interface HXFlowLayout ()

@property (nonatomic, strong) NSMutableArray *attributeArray;

@end

@implementation HXFlowLayout

#pragma mark -
#pragma mark - Private Method
//在这个方法中做一些初始化操作
- (void)prepareLayout
{
  [super prepareLayout];
  
  //水平滚动
  self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
  //决定第一张图片所在的位置
  CGFloat margin = (self.collectionView.frame.size.width - self.itemSize.width) / 2;
  self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, margin);
  
}
/**
 这个方法返回我们的布局数组
 这个数组中存放的都是UICollectionViewLayoutAttributes对象
 UICollectionViewLayoutAttributes对象决定了cell的布局方式(frame等)
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
  //让父类布局好样式
  NSArray *arr = [super layoutAttributesForElementsInRect:rect];
  //计算出collectionView的中心的位置
  CGFloat ceterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
  /**
  * 1.一个cell对应一个UICollectionViewLayoutAttributes对象
  * 2.UICollectionViewLayoutAttributes对象决定了cell的frame
  */
   for (UICollectionViewLayoutAttributes *attributes in arr) {
    //cell的中心点距离collectionView的中心点的距离，注意ABS()表示绝对值
    CGFloat delta = ABS(attributes.center.x - ceterX);
    //设置缩放比例
     CGFloat scale = 1.1 - delta / self.collectionView.frame.size.width;
    //设置cell滚动时候缩放的比例
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
   }
  return arr;
}
/*
 如果返回YES，那么collectionView显示的范围发生改变时，就会重新刷新布局
 一旦重新刷新布局，就会按顺序调用下面的方法
 - prepareLayout
 - layoutAttributesForElementsInRect:
 
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
  return YES;
}
/*
 作用：返回值决定了collectionView停止滚动时最终的偏移量contentOffset
 参数
 proposedContentOffset:原本情况下，collectionView停止滚动时最终的偏移量
 velocity: 滚动速度，通过这个参数可以了解滚动的方向
 */

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
  // 计算出最终显示的矩形框
  CGRect rect;
  rect.origin.y = 0;
  rect.origin.x = proposedContentOffset.x;
  rect.size = self.collectionView.frame.size;
  
  //获得super已经计算好的布局的属性
  NSArray *arr = [super layoutAttributesForElementsInRect:rect];
  
  //计算collectionView最中心点的x值
  CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
  
  CGFloat minDelta = MAXFLOAT;
  for (UICollectionViewLayoutAttributes *attrs in arr) {
    if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
      minDelta = attrs.center.x - centerX;
    }
  }
  proposedContentOffset.x += minDelta;
  return proposedContentOffset;
}

#pragma mark -
#pragma mark - Getter
- (NSMutableArray *)attributeArray
{
  if (!_attributeArray) {
    _attributeArray = [[NSMutableArray alloc] init];
  }
  return _attributeArray;
}

@end
