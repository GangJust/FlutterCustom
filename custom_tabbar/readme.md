### 去官方字体缩放抖动，可缩放的Tab

使用方式如下：

```dart
CustomTabBar(
    controller: _tabController,
    ...
    style: TextStyle(fontSize: 18.0),
    selectedScale: 1.3,
    tabs: [
        Tab(child: Text("页面1")),
        Tab(child: Text("页面2")),
    ],
)
```



删除了源码中的两个属性：

```dart
final TextStyle? labelStyle;
...
final TextStyle? unselectedLabelStyle;
```



新增加了两个自定义属性：

```dart
/// tab的文字样式
final TextStyle? style;
...
/// 被选中缩放
final double selectedScale;
```



使用方式：下载dart文件直接复制到项目中即可。



演示效果自行看图。