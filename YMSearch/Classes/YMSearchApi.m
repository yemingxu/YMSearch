//
//  YMSearchHintAPI.m
//  SearchHint
//
//  Created by JoeXu on 2018/5/4.
//  Copyright © 2018年 JoeXu. All rights reserved.
//

#import "YMSearchApi.h"
#import "NSURLSession+SearchTask.h"
#import "YMSearchTaskManager.h"

@interface YMSearchApi()
{
    dispatch_queue_t _queue;
}
@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) YMSearchTaskManager *taskManager;

@end
@implementation YMSearchApi
- (instancetype)init
{
    if (!(self = [super init])) return self;
    _queue = dispatch_queue_create("yeming.search.hint.manager.queue", NULL);
    return self;
}
static NSTimeInterval delayTime = 0.2;
- (void)ym_searchWord:(NSString *)word callback:(YMSearchCallback)callback
{
    __weak typeof(self) self_weak = self;
    dispatch_async(_queue, ^{
        __strong typeof(self_weak) self_strong = self_weak;
        NSURLSessionDataTask *task = [self_strong.session searchTaskWithWord:word callback:callback];
        [self_strong.taskManager pushInAnTask:task];
    });
    
}

#pragma mark - Lazy

- (NSURLSession *)session
{
    if (!_session) {
        NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:conf];
    }
    return _session;
}
- (YMSearchTaskManager *)taskManager
{
    if (!_taskManager) {
        _taskManager = [[YMSearchTaskManager alloc] init];
    }
    return _taskManager;
}
@end
