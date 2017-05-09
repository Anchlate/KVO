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


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //[self test];
    
    [self allocClass];
    
    
}

// 动态创建类并添加方法
-  (void)test {
    
    Class newClass =
    objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    objc_registerClassPair(newClass);
    
    
    id instanceOfNewClass = [[newClass alloc]initWithDomain:@"some Domain" code:0 userInfo:nil];
    
    [instanceOfNewClass performSelector:@selector(report)];
    
}

void ReportFunction(id self, SEL _cmd) {
    NSLog(@"This object is %p.",self);
    NSLog(@"Class is %@, and super is %@.",[self class],[self superclass]);
    Class currentClass = [self class];
    for( int i = 1; i < 5; ++i )
    {
        NSLog(@"Following the isa pointer %d times gives %p",i,currentClass);
        currentClass = object_getClass(currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p",object_getClass([NSObject class]));
}

- (void)report {
    
    NSLog(@"......report");
    
}

// 动态创建类
- (void)allocClass{
    Class clas = objc_allocateClassPair([NSObject class], "FYss", 0);
    
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    
    bool success = class_addProperty(clas, "nameIvar", attrs, 3);
    if (success) {
        NSLog(@"addIvar success");
        if (class_isMetaClass(clas)) {
            NSLog(@"是一个类");
        }
    }
    objc_registerClassPair(clas);
    
    
    id instanceOfNewClass = [[clas alloc]init];
    NSLog(@"......:%@", instanceOfNewClass);
}




@end
