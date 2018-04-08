//
//  BSDelayOperation.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/4/4.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "KTSwitchViewDelayOperation.h"

@interface KTSwitchViewDelayOperation ()

@property(copy,nonatomic) void(^finishBlock)(void);
@property (nonatomic, assign) NSTimeInterval delay;

@end

@implementation KTSwitchViewDelayOperation

- (void)main {
    if(self.isCancelled){
        return;
    }
    sleep(self.delay);
    if(self.isCancelled){
        return;
    }
    self.finishBlock();
}

+ (instancetype)delayTime:(NSTimeInterval)delay finishBlock:(void(^)(void))finishBlock {
    
    KTSwitchViewDelayOperation * operation = [[KTSwitchViewDelayOperation alloc]init];
    operation.finishBlock = finishBlock;
    operation.delay = delay;
    return operation;
}
@end
