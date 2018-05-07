//
//  NSURLSession+SearchTask.h
//  SearchHint
//
//  Created by JoeXu on 2018/5/7.
//  Copyright © 2018年 JoeXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMSearchHintDefines.h"

@interface NSURLSession (SearchTask)

- (NSURLSessionDataTask *)searchTaskWithWord:(NSString *)word callback:(YMSearchCallback)callback;

@end
