//
//  YMSearchHintDefines.h
//  SearchHint
//
//  Created by JoeXu on 2018/5/4.
//  Copyright © 2018年 JoeXu. All rights reserved.
//

#ifndef YMSearchHintDefines_h
#define YMSearchHintDefines_h

#import <Foundation/Foundation.h>

typedef void(^YMSearchCallback)(NSError *error,NSArray<NSString *> * hintTitles);

@protocol YMSearchApiProrocol

- (void)ym_searchWord:(NSString *)word callback:(YMSearchCallback)callback;

@end

#endif /* YMSearchHintDefines_h */
