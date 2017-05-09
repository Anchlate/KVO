//
//  ViewController.m
//  KVO
//
//  Created by Qianrun on 16/11/16.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
//    [self.tableView addObserver:self
//                     forKeyPath:@"contentOffset"
//                        options: NSKeyValueObservingOptionNew
//                        context: nil];
    
    
    
    [self yanjiu];
}

/**
 *  监听属性值发生改变时回调
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    self.navigationController.navigationBar.alpha = MIN(1, delta);
}

- (void)yanjiu {
    
    NSLog(@"%@, %@\n\n", self.class, super.class);
    
    NSLog(@"address: %p", self.tableView);
    NSLog(@"class method: %@", self.tableView.class);
    NSLog(@"description method: %@", self.tableView);
    NSLog(@"use runtime to get class: %@", object_getClass(self.tableView));
    [self.tableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
    NSLog(@"===================================================");
    NSLog(@"address: %p", self.tableView);
    NSLog(@"class method: %@", self.tableView.class);
    NSLog(@"description method: %@", self.tableView);
    NSLog(@"use runtime to get class %@", object_getClass(self.tableView));
    
}

#pragma mark -Getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
    }
    return _tableView;
}


@end