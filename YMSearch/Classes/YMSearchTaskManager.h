//
//  YMSearchTaskManager.h
//  SearchHint
//
//  Created by JoeXu on 2018/5/7.
//  Copyright © 2018年 JoeXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMSearchHintDefines.h"

/**
 管理task的有效性
 */
@interface YMSearchTaskManager : NSObject

- (void)pushInAnTask:(NSURLSessionDataTask *)task;

@end
