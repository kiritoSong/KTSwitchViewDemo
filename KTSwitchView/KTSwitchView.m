//
//  BSMineTimeOrderSwichView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/4/3.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "KTSwitchView.h"
#import "KTSwitchViewDelayOperation.h"
#import <Masonry.h>

@interface KTSwitchView()
{
    NSString * _selected_contentText;
    NSString * _contentText;
    UIImage * _selected_img;
    UIImage * _img;
    UIColor * _selected_textColor;
    UIColor * _textColor;
}
@property (nonatomic) UIImageView * imgView;
@property (nonatomic) UIView * contentView;
@property (nonatomic) UILabel * contentLab;
@property (nonatomic) UIView * selected_contentView;
@property (nonatomic) UILabel * selected_contentLab;

//用定时器也能实现、看个人喜好吧。我个人不太喜欢用定时器一会开始一会暂停的
@property (nonatomic) NSOperationQueue * queue;
@end

@implementation KTSwitchView

- (instancetype)init
{
    self = [super init];
    if (self) {

        [self commonInit];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEvent)];
        [self addGestureRecognizer:tapGesture];
        
        self.selected = NO;

    }
    return self;
}

- (void)commonInit {
    self.queue = [[NSOperationQueue alloc]init];
    self.queue.maxConcurrentOperationCount = 3;//3个够用了、除非有逗比一直切着玩可能会有点延迟
    self.eventInterval = 0;
    self.delayTime = 0;
    [self setBgcolor:[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:1.0f] style:KTSwitchViewStyle_Default|KTSwitchViewStyle_Selected];
    [self setTextColor:[UIColor blackColor] style:KTSwitchViewStyle_Default|KTSwitchViewStyle_Selected];
    [self setContentText:@"关" style:KTSwitchViewStyle_Default];
    [self setContentText:@"开" style:KTSwitchViewStyle_Selected];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.contentLab];
    [self addSubview:self.selected_contentView];
    [self.selected_contentView addSubview:self.selected_contentLab];

    [self addSubview:self.imgView];
}


- (void)tapGestureEvent {
    if (self.userInteractionEnabled == NO) {
        return;
    }
    if (self.eventInterval > 0) {
        self.userInteractionEnabled = NO;
        [self performSelector:@selector(func) withObject:nil afterDelay:self.eventInterval];
    }
    
    self.selected =!self.selected;
    
    if ([self.delegate respondsToSelector:@selector(KTSwichViewDidChange:)]) {
        [self.delegate KTSwichViewDidChange:self];
    }
    
    if (self.delayTime > 0) {
        //取消之前的操作
        [self.queue cancelAllOperations];
        KTSwitchViewDelayOperation * operation = [KTSwitchViewDelayOperation delayTime:self.delayTime finishBlock:^{
            [self callDelayDelegate];
        }];
        [self.queue addOperation:operation];
    }

}

- (void)func {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}



#pragma mark - setter && getter
- (void)setSelected:(BOOL)selected {

    _selected = selected;

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    if (selected) {
        self.imgView.image = _selected_img;
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(self.mas_height);
        }];
    }else {

        self.imgView.image = _img;
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(self.mas_height);
        }];
    }
    
    static dispatch_once_t onceToken;
    if (onceToken != 0 && self.frame.size.width) {
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
    }else {
        [self layoutIfNeeded];
        onceToken = 1;
    }
    
}

- (void)callDelayDelegate {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if ([self.delegate respondsToSelector:@selector(KTSwichViewDidDelayChange:)]) {
            [self.delegate KTSwichViewDidDelayChange:self];
        }
    }];
}


- (void)setBgcolor:(UIColor *)bgcolor style:(KTSwitchViewStyle)style {
    if (style & KTSwitchViewStyle_Default) {
        self.backgroundColor = bgcolor;
    }
    
    if (style & KTSwitchViewStyle_Selected) {
        self.selected_contentView.backgroundColor = bgcolor;
    }
}



- (void)setTextColor:(UIColor *)textColor style:(KTSwitchViewStyle)style {
    if (style & KTSwitchViewStyle_Default) {
        _textColor = textColor;
        self.contentLab.textColor = textColor;
    }
    
    if (style & KTSwitchViewStyle_Selected) {
        _selected_textColor = textColor;
        self.selected_contentLab.textColor = textColor;
    }
}


- (void)setImage:(UIImage *)img style:(KTSwitchViewStyle)style {
    if (style & KTSwitchViewStyle_Default) {
        _img = img;
    }
    
    if (style & KTSwitchViewStyle_Selected) {
        _selected_img = img;
    }
    
    if (self.selected) {
        self.imgView.image = _selected_img;
    }else {
        self.imgView.image = _img;
    }
}


- (void)setContentText:(NSString *)contentText style:(KTSwitchViewStyle)style {
    if (style & KTSwitchViewStyle_Default) {
        _contentText = contentText;
        self.contentLab.text = contentText;
    }
    
    if (style & KTSwitchViewStyle_Selected) {
        _selected_contentText = contentText;
        self.selected_contentLab.text = contentText;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setCornerRadius:self.frame.size.height/2];
    static float width;
    
    if (self.frame.size.width != width) {
        CGFloat height = self.frame.size.height;
        width =self.frame.size.width;
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_equalTo(self.imgView.mas_left).offset(height/2);
            make.height.equalTo(self);
            make.width.mas_equalTo(width);
        }];
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(width - height*1.5);
            make.centerX.equalTo(self.contentView).offset(height/4);
        }];
        
        [self.selected_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(self.imgView.mas_right).offset(-height/2);
            make.height.equalTo(self);
            make.width.equalTo(self.contentView);
        }];
        
        [self.selected_contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selected_contentView);
            make.width.equalTo(self.contentLab);
            make.centerX.equalTo(self.selected_contentView).offset(-height/4);
        }];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = cornerRadius;
    self.imgView.layer.masksToBounds = YES;
}


- (void)setFont:(UIFont *)font {
    _font = font;
    self.contentLab.font = font;
    self.selected_contentLab.font = font;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLab;
}

- (UIView *)selected_contentView {
    if (!_selected_contentView) {
        _selected_contentView = [UIView new];
    }
    return _selected_contentView;
}

- (UILabel *)selected_contentLab {
    if (!_selected_contentLab) {
        _selected_contentLab = [UILabel new];
        _selected_contentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _selected_contentLab;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}
@end
