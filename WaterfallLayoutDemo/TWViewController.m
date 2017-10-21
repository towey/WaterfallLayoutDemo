//
//  TWViewController.m
//  WaterfallLayoutDemo
//
//  Created by Towey on 2017/10/21.
//  Copyright © 2017年 tw. All rights reserved.
//

#import "TWViewController.h"
#import "TWWaterfallLayout.h"
#import "TWWaterfallCell.h"

#define kEdgeMargin 8
#define kIdentifier @"TWWaterfallCell"
#define kItemColumn 2

@interface TWViewController () <UICollectionViewDataSource, TWWaterfallLayoutDataSource>

@end

@interface TWViewController ()
//存放图片名称
@property (nonatomic, strong) NSMutableArray *imgArray;

@end

@implementation TWViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setContentView];
}

#pragma mark - 设置collectionView
- (void)setContentView {
    
//    创建瀑布流布局，设置相应属性
    TWWaterfallLayout *layout = [[TWWaterfallLayout alloc] init];
    layout.minimumLineSpacing = kEdgeMargin;
    layout.minimumInteritemSpacing = kEdgeMargin;
    layout.sectionInset = UIEdgeInsetsMake(kEdgeMargin, kEdgeMargin, kEdgeMargin, kEdgeMargin);
    layout.dataSource = self;
    
//    创建UICollectionView，并添加瀑布流布局
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:kIdentifier bundle:nil] forCellWithReuseIdentifier:kIdentifier];
    
    [self.view addSubview:collectionView];
}


#pragma mark - collectionView 相关数据源&瀑布流布局数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TWWaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    cell.bgImgView.image = [UIImage imageNamed:self.imgArray[indexPath.row % self.imgArray.count]];
    
    return cell;
}

-(NSInteger)numberOfColumnInWaterfallLayout {
    return kItemColumn;
}

-(CGFloat)waterfallLayout:(TWWaterfallLayout *)waterfallLayout itemHeightAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item % 2 == 0 ? UIScreen.mainScreen.bounds.size.width * 0.7 : UIScreen.mainScreen.bounds.size.width * 0.5;
}

#pragma mark - 懒加载
-(NSMutableArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
        
//        添加测试数据
        for (int i = 0; i < 30; ++ i) {
            [_imgArray addObject:[NSString stringWithFormat:@"test%d",i % 4 + 1]];
        }
    }
    
    return _imgArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
