//
//  YMViewController.m
//  YMSearch
//
//  Created by nightxu on 05/07/2018.
//  Copyright (c) 2018 nightxu. All rights reserved.
//

#import "YMViewController.h"
#import "YMSearchApi.h"

@interface YMViewController ()
{
    YMSearchApi *_searchApi;
}
@end

@implementation YMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchApi = [[YMSearchApi alloc] init];
    
    [_searchApi ym_searchWord:@"mahuateng" callback:^(NSError *error, NSArray<NSString *> *hintTitles) {
        NSLog(@"%@ - %@",error,hintTitles);
    }];
    [_searchApi ym_searchWord:@"jingdong" callback:^(NSError *error, NSArray<NSString *> *hintTitles) {
        NSLog(@"%@ - %@",error,hintTitles);
    }];
    [_searchApi ym_searchWord:@"taoba" callback:^(NSError *error, NSArray<NSString *> *hintTitles) {
        NSLog(@"%@ - %@",error,hintTitles);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_searchApi ym_searchWord:@"花" callback:^(NSError *error, NSArray<NSString *> *hintTitles) {
            NSLog(@"%@ - %@",error,hintTitles);
        }];
    });
    [_searchApi ym_searchWord:@"雨" callback:^(NSError *error, NSArray<NSString *> *hintTitles) {
        NSLog(@"%@ - %@",error,hintTitles);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
