//
//  HXWaterFlowLayout.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/29.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXWaterFlowLayout.h"

NSString * const HX_UICollectionElementKindSectionHeader = @"HX_HeaderView";
NSString * const HX_UICollectionElementKindSectionFooter = @"HX_FooterView";

@interface HXWaterFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary *cellLayoutInfo;//保存cell的布局
@property (nonatomic, strong) NSMutableDictionary *headLayoutInfo;//保存透视图的布局
@property (nonatomic, strong) NSMutableDictionary *footLayoutInfo;//保存尾视图的布局

@property (nonatomic, assign) CGFloat  startY;//记录开始的Y
@property (nonatomic, strong) NSMutableDictionary *maxYForColumn;//记录瀑布流每列最下面那个cell的底部Y值
@property (nonatomic, strong) NSMutableArray *shouldAnimationArray;//记录需要添加动画的NSIndexPath

@end

@implementation HXWaterFlowLayout

- (instancetype)init
{
  if (self = [super init]) {
    self.numberOfColumns      = 3;
    self.topAndBottomDistance = 10;
    self.cellDistance         = 10;
    _headerViewHeight         = 0;
    _footerViewHeight         = 0;
    self.startY               = 0;
    self.maxYForColumn        = [NSMutableDictionary dictionary];
    self.cellLayoutInfo       = [NSMutableDictionary dictionary];
    self.headLayoutInfo       = [NSMutableDictionary dictionary];
    self.footLayoutInfo       = [NSMutableDictionary dictionary];
    self.shouldAnimationArray = [NSMutableArray array];
  }
  return self;
}

- (void)prepareLayout
{
  [super prepareLayout];
  
  //重新布局需要清空
  [self.cellLayoutInfo removeAllObjects];
  [self.headLayoutInfo removeAllObjects];
  [self.footLayoutInfo removeAllObjects];
  self.startY = 0;
  
  CGFloat viewWidth = self.collectionView.frame.size.width;
  //代理里面只取了高度，所以cell的宽度还有列数还有cell的间距计算出来
  CGFloat itemWidth = (viewWidth - self.cellDistance * (self.numberOfColumns + 1)) / self.numberOfColumns;
  //取有多少个section
  NSInteger sectionsCount = [self.collectionView numberOfSections];
  for (NSInteger section = 0; section < sectionsCount; section++) {
    //存储headerview属性
    NSIndexPath *supplementaryViewIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    //透视图的高度不为0并且根据代理方法能获取到对应的头视图的时候，添加对应头视图的布局对象
    if (_headerViewHeight > 0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
      UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:HX_UICollectionElementKindSectionHeader withIndexPath:supplementaryViewIndexPath];
      //设置frame
      attributes.frame = CGRectMake(0, self.startY, self.collectionView.frame.size.width, _headerViewHeight);
      //保存布局对象
      self.headLayoutInfo[supplementaryViewIndexPath] = attributes;
      //设置下个布局对象的开始Y值
      self.startY = self.startY + _headerViewHeight + _topAndBottomDistance;
    }
    else {
      //没有头视图的时候，也要设置section的第一排cell的顶部的距离
      self.startY += _topAndBottomDistance;
    }
    
    //将section的第一排cell的frame的Y值进行设置
    for (NSInteger i = 0; i<_numberOfColumns; i++) {
      self.maxYForColumn[@(i)] = @(self.startY);
    }
    
    //计算cell的布局
    //取出section有多少个row
    NSInteger rowCount = [self.collectionView numberOfItemsInSection:section];
    //分别计算设置每个cell的布局对象
    for (NSInteger row = 0; row < rowCount; row++) {
      NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
      UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
      
      //计算当前的cell加到哪一列(瀑布流是加载到最短的一列)
      CGFloat y = [self.maxYForColumn[@(0)] floatValue];
      NSInteger currentRow = 0;
      for (NSInteger i = 0; i<_numberOfColumns; i++) {
        if ([self.maxYForColumn[@(i)] floatValue] < y) {
          y = [self.maxYForColumn[@(i)] floatValue];
          currentRow = i;
        }
      }
      
      //计算x值
      CGFloat x = self.cellDistance + (self.cellDistance + itemWidth)*currentRow;
      //根据代理去取当前cell的高度，因为当前是采用通过列数计算的宽度，高度根据图片的原始宽高比进行设置
      CGFloat height = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:cellIndexPath itemWith:itemWidth];
      //设置当前cell布局对象的frame
      attributes.frame = CGRectMake(x, y, itemWidth, height);
      //重新设置当前排列的y值
      y = y + self.cellDistance + height;
      self.maxYForColumn[@(currentRow)] = @(y);
      //保留cell的布局对象
      self.cellLayoutInfo[cellIndexPath] = attributes;
      
      //当是section的最后一个cell的时候，取出最后一排cell的底部Y值，设置starY决定下个视图对象的起始Y值
      if (row == rowCount - 1) {
        CGFloat maxY = [self.maxYForColumn[@(0)] floatValue];
        for (NSInteger i = 0; i<_numberOfColumns; i++) {
          if ([self.maxYForColumn[@(i)] floatValue] > maxY) {
            maxY = [self.maxYForColumn[@(i)] floatValue];
          }
        }
        self.startY = maxY - self.cellDistance + self.topAndBottomDistance;
      }
    }
    
    //存储footerView属性
    //尾视图的高度不为0并且根据代理方法能取到对应的尾视图的时候，添加对应尾视图的布局对象
    if (_footerViewHeight > 0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
      UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:HX_UICollectionElementKindSectionFooter withIndexPath:supplementaryViewIndexPath];
      attributes.frame = CGRectMake(0, self.startY, self.collectionView.frame.size.width, _footerViewHeight);
      self.footLayoutInfo[supplementaryViewIndexPath] = attributes;
      self.startY = self.startY + _footerViewHeight;
    }
    
  }
  
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
  NSMutableArray *allAttributes = [NSMutableArray array];
  
  //添加当前屏幕可见的cell的布局
  [self.cellLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL * _Nonnull stop) {
    if (CGRectIntersectsRect(rect, attributes.frame)) {
      [allAttributes addObject:attributes];
    }
  }];
  
  //添加当前屏幕可见的头视图的布局
  [self.headLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL * _Nonnull stop) {
    if (CGRectIntersectsRect(rect, attributes.frame)) {
      [allAttributes addObject:allAttributes];
    }
  }];
  
  //添加当前屏幕可见的尾视图的布局
  [self.footLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL * _Nonnull stop) {
    if (CGRectIntersectsRect(rect, attributes.frame)) {
      [allAttributes addObject:attributes];
    }
  }];
  return allAttributes;
  
}

//插入cell的时候系统会调用该方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewLayoutAttributes *attributes = self.cellLayoutInfo[indexPath];
  return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewLayoutAttributes *attributes = nil;
  if ([elementKind isEqualToString:HX_UICollectionElementKindSectionHeader]) {
    attributes = self.headLayoutInfo[indexPath];
  }
  else if ([elementKind isEqualToString:HX_UICollectionElementKindSectionFooter]) {
    attributes = self.footLayoutInfo[indexPath];
  }
  return attributes;
}

- (CGSize)collectionViewContentSize
{
  return CGSizeMake(self.collectionView.frame.size.width, MAX(self.startY, self.collectionView.frame.size.height));
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems
{
  [super prepareForCollectionViewUpdates:updateItems];
  NSMutableArray *indexPaths = [NSMutableArray array];
  for (UICollectionViewUpdateItem *item in updateItems) {
    switch (item.updateAction) {
      case UICollectionUpdateActionInsert:
        [indexPaths addObject:item.indexPathAfterUpdate];
        break;
      case UICollectionUpdateActionDelete:
        [indexPaths addObject:item.indexPathBeforeUpdate];
        break;
      case UICollectionUpdateActionMove:
//        [indexPaths addObject:item.indexPathBeforeUpdate];
//        [indexPaths addObject:item.indexPathAfterUpdate];
        break;
        
      default:
        NSLog(@"unHandled case: %@",item);
        break;
    }
  }
  self.shouldAnimationArray = indexPaths;
}

//对应UICollectionViewUpdateitem 的indexPathBeforeUpdate 设置调用
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
  if ([self.shouldAnimationArray containsObject:itemIndexPath]) {
    UICollectionViewLayoutAttributes *attr = self.cellLayoutInfo[itemIndexPath];
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
    attr.alpha = 1;
    [self.shouldAnimationArray removeObject:itemIndexPath];
    return attr;
  }
  return nil;
}

//对应UICollectionViewUpdateItem的indexPathAfterUpdate设置调用
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
  if ([self.shouldAnimationArray containsObject:itemIndexPath]) {
    UICollectionViewLayoutAttributes *attr = self.cellLayoutInfo[itemIndexPath];
    
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(2, 2), 0);
    //        attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
    attr.alpha = 0;
    [self.shouldAnimationArray removeObject:itemIndexPath];
    return attr;
  }
  return nil;
}
- (void)finalizeCollectionViewUpdates
{
  self.shouldAnimationArray = nil;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
  CGRect oldBounds = self.collectionView.bounds;
  if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
    return YES;
  }
  return NO;
}

//移动相关
- (UICollectionViewLayoutInvalidationContext *)invalidationContextForInteractivelyMovingItems:(NSArray<NSIndexPath *> *)targetIndexPaths withTargetPosition:(CGPoint)targetPosition previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths previousPosition:(CGPoint)previousPosition
{
  UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForInteractivelyMovingItems:targetIndexPaths withTargetPosition:targetPosition previousIndexPaths:previousIndexPaths previousPosition:previousPosition];
  
  if([self.delegate respondsToSelector:@selector(moveItemAtIndexPath: toIndexPath:)]){
    [self.delegate moveItemAtIndexPath:previousIndexPaths[0] toIndexPath:targetIndexPaths[0]];
  }
  return context;
}
- (UICollectionViewLayoutInvalidationContext *)invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:(NSArray *)indexPaths previousIndexPaths:(NSArray *)previousIndexPaths movementCancelled:(BOOL)movementCancelled NS_AVAILABLE_IOS(9_0)
{
  UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:indexPaths previousIndexPaths:previousIndexPaths movementCancelled:movementCancelled];
  
  if(!movementCancelled){
    
  }
  return context;
}

@end
