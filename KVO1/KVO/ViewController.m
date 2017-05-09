//
//  ViewController.m
//  KVO
//
//  Created by Qianrun on 16/11/16.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = [[Person alloc] init];
    p.name = @"abc";
    p.age = @25;
    
    // 1.
    [p addObserver:self
        forKeyPath:@"age"
           options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
           context:nil];
    
    p.age = @24;
    
    // 3.
    [p removeObserver:self forKeyPath:@"age" context:nil];
    
    
    
    Person *p1 = [Person new];
    p1.name = @"ddd";
    p1.age = @22;
    
    
    NSArray *datasource = @[p, p1];
    
    NSArray *gradeTotal = [datasource valueForKeyPath:@"@unionOfObjects.name"];// 获取所有person对象的name集合
    NSLog(@"......gradeTotal:%@", gradeTotal);
    
}


// 2.
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    NSLog(@"keyPath = %@, object = %@ , change = %@, context = %@", keyPath, object, change, context);
    // 对比 change 字典中 NSKeyValueChangeOldKey 与 NSKeyValueChangeNewKey，可判断监听属性的变化
    NSNumber *oldAge = change[NSKeyValueChangeOldKey];
    NSNumber *newAge = change[NSKeyValueChangeNewKey];
    
    NSLog(@"oldAge = %@, newAge = %@",oldAge, newAge);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
