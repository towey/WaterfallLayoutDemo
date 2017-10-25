瀑布流布局(自定义UICollectionViewLayout)
==========
### 效果

![image](https://github.com/towey/WaterfallLayoutDemo/blob/master/gif/waterfall.gif)

<br/>

### 使用说明：

1、将TWWaterfallLayout文件夹拖到项目中，添加布局头文件
<br/>
2、为UICollectionView添加此布局
<br/>
3、实现以下数据源方法来设置瀑布流列数和对应位置item的高度，具体使用方法可以参照demo

```objc
//瀑布流indexPath位置item的高度
- (CGFloat)waterfallLayout:(TWWaterfallLayout *)waterfallLayout itemHeightAtIndexPath:(NSIndexPath *)indexPath;

//瀑布流列数
- (NSInteger)numberOfColumnInWaterfallLayout;
```

