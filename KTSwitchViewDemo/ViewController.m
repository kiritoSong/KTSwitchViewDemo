//
//  ViewController.m
//  KTSwitchViewDemo
//
//  Created by 刘嵩野 on 2018/4/8.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "ViewController.h"
#import "KTSwitchView.h"

#import <Masonry.h>

@interface ViewController ()<KTSwitchViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self c1];
    [self c2];
    [self c3];
}

- (void)c1 {
    KTSwitchView * switchView = [KTSwitchView new];
    switchView.tag = 1;
    [self.view addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    
    [switchView setContentText:@"关管管" style:KTSwitchViewStyle_Default];
    [switchView setContentText:@"开开开" style:KTSwitchViewStyle_Selected];
    [switchView setBgcolor:[UIColor lightGrayColor] style:KTSwitchViewStyle_Default|KTSwitchViewStyle_Selected];
    [switchView setTextColor:[UIColor blackColor] style:KTSwitchViewStyle_Default];
    [switchView setTextColor:[UIColor redColor] style:KTSwitchViewStyle_Selected];
    [switchView setImage:[UIImage imageNamed:@"mine_timeorder_unlock.png"] style:KTSwitchViewStyle_Selected];
    [switchView setImage:[UIImage imageNamed:@"mine_timeorder_lock.png"] style:KTSwitchViewStyle_Default];
    switchView.font = [UIFont systemFontOfSize:10.0f];
    switchView.delegate = self;
}


- (void)c2 {
    KTSwitchView * switchView = [KTSwitchView new];
    switchView.tag = 2;
    [self.view addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(200);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(50);
    }];
    [switchView setImage:[UIImage imageNamed:@"mine_timeorder_unlock.png"] style:KTSwitchViewStyle_Selected];
    [switchView setImage:[UIImage imageNamed:@"mine_timeorder_lock.png"] style:KTSwitchViewStyle_Default];
    [switchView setBgcolor:[UIColor orangeColor] style:KTSwitchViewStyle_Selected];
    //开启延迟回调
    switchView.delayTime = 1;
    switchView.delegate = self;
    switchView.selected = YES;
}

- (void)c3 {
    KTSwitchView * switchView = [KTSwitchView new];
    switchView.tag = 2;
    [self.view addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(400);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    [switchView setImage:[UIImage imageNamed:@"mine_timeorder_unlock.png"] style:KTSwitchViewStyle_Selected];
    [switchView setImage:[UIImage imageNamed:@"mine_timeorder_lock.png"] style:KTSwitchViewStyle_Default];
    [switchView setContentText:@"已上架已上架已上架已上架" style:KTSwitchViewStyle_Selected];
    [switchView setContentText:@"未上架" style:KTSwitchViewStyle_Default];
    switchView.eventInterval = 2;
    switchView.delegate = self;
    
}

-(void)KTSwichViewDidChange:(KTSwitchView *)swichView {
    NSLog(@"%zd号点击---状态“%@”",swichView.tag,swichView.selected?@"开":@"关");
}

-(void)KTSwichViewDidDelayChange:(KTSwitchView *)swichView {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%zd号延迟回调---状态”%@“",swichView.tag,swichView.selected?@"开":@"关"] preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    

    [alert addAction:action1];

    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
