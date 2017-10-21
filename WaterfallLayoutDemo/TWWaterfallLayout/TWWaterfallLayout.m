//
//  TWWaterfallLayout.m
//  WaterfallLayoutDemo
//
//  Created by Towey on 2017/10/21.
//  Copyright © 2017年 tw. All rights reserved.
//

#import "TWWaterfallLayout.h"

@interface TWWaterfallLayout ()
//存放item属性的数组
@property (nonatomic, strong) NSMutableArray *attrsArray;

//存放每一列高度的数组
@property (nonatomic, strong) NSMutableArray *heightArray;

//布局最大高度
@property (nonatomic, assign) CGFloat maxH;

//item准备开始计算的索引，防止添加数据时重复计算之前已经计算过的item属性
@property (nonatomic, assign) NSInteger startIndex;

//列数
@property (nonatomic, assign) NSInteger columnCount;


@end

@implementation TWWaterfallLayout

- (instancetype)init {
    if (self = [super init]) {
//        初始化将开始索引置为0
        _startIndex = 0;
        
    }
    
    return self;
}

#pragma mark - 自定义布局相关
- (void)prepareLayout {
    [super prepareLayout];
    
//    获取列数,默认为2列
    self.columnCount = 2;
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnInWaterfallLayout)]) {
        self.columnCount = [self.dataSource numberOfColumnInWaterfallLayout];
    }
    
//    计算Item的宽度
    int itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.minimumInteritemSpacing) / self.columnCount;
    
//    获取item的个数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
//    计算所有的item的属性
    for (NSInteger i = self.startIndex; i < itemCount; ++ i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
//        创建对应item的Attributes属性
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
//        获取对应item的高度，不设置就默认50
        CGFloat itemH = 50;
        if ([self.dataSource respondsToSelector:@selector(waterfallLayout:itemHeightAtIndexPath:)]) {
            itemH = [self.dataSource waterfallLayout:self itemHeightAtIndexPath:indexPath];
        }
        
//        获取高度最短那一列的索引
        NSNumber *minH = [NSNumber numberWithFloat:[[self.heightArray valueForKeyPath:@"@min.floatValue"] floatValue]];
        NSInteger minIndex = [self.heightArray indexOfObject:minH];

//        设置item属性的frame
        CGFloat itemX = self.sectionInset.left + (itemW + self.minimumInteritemSpacing) * minIndex;
        CGFloat itemY = [self.heightArray[minIndex] floatValue];
        attributes.frame = CGRectMake(itemX, itemY, itemW, itemH);
        
//        将item属性添加到数组中
        [self.attrsArray addObject:attributes];
        
//        增加最短列对应的高度，因为新的item即将添加到高度最短那一列
        self.heightArray[minIndex] = @([minH floatValue] + itemH + self.minimumLineSpacing);
        
    }
    
//    记录最大值
    self.maxH = [[self.heightArray valueForKeyPath:@"@max.floatValue"] floatValue];
    
//    给startIndex重新复制
    self.startIndex = itemCount;
    
}

- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(0, self.maxH + self.sectionInset.bottom - self.minimumLineSpacing);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attrsArray;
}

#pragma mark - 懒加载
- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    
    return _attrsArray;
}

- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
        
//        添加每一列上边距作为初始高度
        for (int i = 0; i < self.columnCount; i++) {
            self.heightArray[i] = @(self.sectionInset.top);
        }
    }
    
    return _heightArray;
}

@end
