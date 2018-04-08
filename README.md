# KTSwitchViewDemo
[《简书链接》](https://www.jianshu.com/p/6788fbfcfa47)
#### 效果图如下、有需要可以自取。
![](https://upload-images.jianshu.io/upload_images/1552225-163b2bf325c56034.gif?imageMogr2/auto-orient/strip)
***
#### 主要写了以下的几个功能
  - 可以设置X秒内不允许点击。
  - 可以设置X秒后无新动作再的捕获回调。
  - 自定义文字颜色、大小
  - 自定义背景色
  - 自定义图片  
##### .h文件如下
```
///
//  KTSwitchView.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/4/3.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KTSwitchView;

typedef NS_OPTIONS(NSUInteger, KTSwitchViewStyle) {
    //选中状态
    KTSwitchViewStyle_Selected = 1 << 0,
    //普通状态
    KTSwitchViewStyle_Default = 1 << 1,
};


@protocol KTSwitchViewDelegate<NSObject>
/**
 * selected属性改变的时候调用
 */
- (void)KTSwichViewDidChange:(KTSwitchView *)swichView;
/**
 * selected一定时间后没有再改变时调用 默认0s、也就是不走这个回调
 */
- (void)KTSwichViewDidDelayChange:(KTSwitchView *)swichView;

@end
@interface KTSwitchView : UIView

@property (nonatomic, weak) id <KTSwitchViewDelegate> delegate;
/* 延迟多久可以再次点击 */
@property (nonatomic, assign) NSTimeInterval eventInterval;
/* 延迟多久回调 BSSwichViewDidDelayChange 默认0s*/
@property (nonatomic, assign) NSTimeInterval delayTime;
@property (nonatomic) UIFont * font;
@property (nonatomic) BOOL selected;


/**
 *  可以KTSwitchViewStyle_Default|KTSwitchViewStyle_Selected同时设定两种状态
 */
- (void)setContentText:(NSString *)contentText style:(KTSwitchViewStyle)style;
- (void)setTextColor:(UIColor *)textColor style:(KTSwitchViewStyle)style;
- (void)setImage:(UIImage *)img style:(KTSwitchViewStyle)style;
- (void)setBgcolor:(UIColor *)bgcolor style:(KTSwitchViewStyle)style;

@end
```


***
#### 需要注意的是
- 布局使用的是`Masonry`、需要项目支持。
- 延迟回调用的是NSOperation队列、每次点击废弃队列中的旧操作。
其实也可以(或者说从场景上更适合)用定时器、但是个人情感上不太喜欢不断的开关某个定时器。
