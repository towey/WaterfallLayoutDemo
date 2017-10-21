//
//  TWWaterfallLayout.h
//  WaterfallLayoutDemo
//
//  Created by Towey on 2017/10/21.
//  Copyright © 2017年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWWaterfallLayout;

@protocol TWWaterfallLayoutDataSource <NSObject>

@required
//瀑布流indexPath位置item的高度
- (CGFloat)waterfallLayout:(TWWaterfallLayout *)waterfallLayout itemHeightAtIndexPath:(NSIndexPath *)indexPath;

//瀑布流列数
- (NSInteger)numberOfColumnInWaterfallLayout;

@end

@interface TWWaterfallLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <TWWaterfallLayoutDataSource> dataSource;

@end
