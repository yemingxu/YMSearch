//
//  YMSearchTaskManager.m
//  SearchHint
//
//  Created by JoeXu on 2018/5/7.
//  Copyright © 2018年 JoeXu. All rights reserved.
//

#import "YMSearchTaskManager.h"

static NSTimeInterval __delayTime = 0.2;

@interface YMSearchTaskManager()
{
    dispatch_semaphore_t _semaphore;
    dispatch_block_t _delayBlock;
}
@end
@implementation YMSearchTaskManager
- (instancetype)init
{
    if (!(self = [super init])) {return self;}
    _semaphore = dispatch_semaphore_create(1);
    return self;
}

- (void)pushInAnTask:(NSURLSessionDataTask *)task
{
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    if (_delayBlock){
        if (dispatch_block_testcancel(_delayBlock) != 0){
//            dispatch_block_cancel(_delayBlock);
        }
        dispatch_block_cancel(_delayBlock);

        _delayBlock = nil;
    }
    _delayBlock = dispatch_block_create(0, ^{
        [task resume];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(__delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), _delayBlock);
    
    dispatch_semaphore_signal(_semaphore);
}


@end
