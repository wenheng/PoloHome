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
- (void)prepareLayout
{
  [super prepareLayout];
  
  //计算每一个item的宽度
  CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing)/2;
  //定义数组保存每一列的高度
  //这个数组的主要作用是保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
  CGFloat colHight[2] = {self.sectionInset.top,self.sectionInset.bottom};
  //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
  for (NSInteger i = 0; i<_itemCount; i++) {
    //设置每个item的位置相关属性
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    //创建一个布局属性类
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //随机一个高度
    CGFloat height = arc4random() % 150 + 40;
    //那一列高度小，则放到那一列下面
    //标记最短的列
    NSInteger colIndex = 0;
    if (colHight[0] < colHight[1]) {
      //将新的item高度加入到断的一列
      colHight[0] = colHight[0] + height + self.minimumLineSpacing;
      colIndex = 0;
    }
    else {
      colHight[1] = colHight[1] + height + self.minimumLineSpacing;
      colIndex = 1;
    }
    
    //设置item的位置
    attrs.frame = CGRectMake(self.sectionInset.left + (self.minimumInteritemSpacing+itemWidth)*colIndex, colHight[colIndex]-height-self.minimumLineSpacing, itemWidth, height);
    [self.attributeArray addObject:attrs];
  }

  //设置itemSize来确保滑动范围的正确 这里是通过将所有的item高度平均化，计算出来的(以最高的列位标准)
  if (colHight[0]>colHight[1]) {
    self.itemSize = CGSizeMake(itemWidth, (colHight[0]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
  }else{
    self.itemSize = CGSizeMake(itemWidth, (colHight[1]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
  }
}
//这个方法返回我们的布局数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
  return _attributeArray;
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
