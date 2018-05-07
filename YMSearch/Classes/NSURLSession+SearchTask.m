//
//  NSURLSession+SearchTask.m
//  SearchHint
//
//  Created by JoeXu on 2018/5/7.
//  Copyright © 2018年 JoeXu. All rights reserved.
//

#import "NSURLSession+SearchTask.h"

@implementation NSURLSession (SearchTask)
- (NSURLSessionDataTask *)searchTaskWithWord:(NSString *)word callback:(YMSearchCallback)callback
{
    
    NSURLRequest *request =__generateURLRequest(word);
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (callback == nil) return ;
        
        if (error || data.length <= 5){
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error,nil);
            });
        }else{
            NSArray<NSString *> * hintTitles = __getHintTitles(data);
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil,hintTitles);
            });
        }
    }];
    return task;
}
static NSArray<NSString *> * __getHintTitles(NSData *response)
{
    
    NSError *error;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *string = [[NSString alloc] initWithData:response encoding:enc];
    NSString *prefix = @"window.baidu.sug(";
    NSString *suffix = @");";
    
    if (![string hasPrefix:prefix] || ![string hasSuffix:suffix]){
        return @[];
    }
    string = [string substringFromIndex:prefix.length];
    string = [string substringToIndex:string.length-suffix.length];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray<NSString *> *s = jsonDict[@"s"];
    if (s == nil || ![s isKindOfClass:[NSArray class]]) return @[];
    return s;
}

static NSURLRequest * __generateURLRequest(NSString *word)
{
    
    NSString *urlString = [ NSString stringWithFormat:@"https://sp0.baidu.com/5a1Fazu8AA54nxGko9WTAnF6hhy/su?wd=%@&json=1",word];
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *result = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [result setHTTPMethod:@"Get"];
    [result setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [result setValue:@"gzip, deflate, br" forHTTPHeaderField:@"Accept-Encoding"];
    [result setValue:@"zh-CN,zh;q=0.9,en;q=0.8" forHTTPHeaderField:@"Accept-Language"];
    [result setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    [result setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [result setValue:@"Mozilla/5.0 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    
    return result;
}

@end
