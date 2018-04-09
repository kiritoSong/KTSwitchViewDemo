//
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
- (void)setImageBgColor:(UIColor *)color style:(KTSwitchViewStyle)style;
- (void)setBgcolor:(UIColor *)bgcolor style:(KTSwitchViewStyle)style;

@end
