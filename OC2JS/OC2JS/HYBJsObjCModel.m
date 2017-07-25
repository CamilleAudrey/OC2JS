//
//  HYBJsObjCModel.m
//  OC2JS
//
//  Created by imac on 17/7/24.
//  Copyright © 2017年 Guowu. All rights reserved.
//

#import "HYBJsObjCModel.h"

@implementation HYBJsObjCModel

//JS 调用这个方法 并且传入 一个字典作为参数
- (void)callWithDict:(NSDictionary *)params {
    NSLog(@"Js调用了OC的方法，参数为：%@", params);
}

// Js调用了callSystemCamera
- (void)callSystemCamera {
    NSLog(@"JS调用了OC的方法，调起系统相册");
    
    // JS调用后OC后，又通过OC调用JS，但是这个是没有传参数的  这里调用了JS中的 jsFunc 方法
    JSValue *jsFunc = self.jsContext[@"jsFunc"];
    [jsFunc callWithArguments:nil];
}
//JS 调用了这个方法 并且传入了一个字典作为参数
- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params {
    NSLog(@"jsCallObjcAndObjcCallJsWithDict was called, params is %@", params);
    
    //JS 调用OC后 ， 又通过OC 调用JS的方法 并传入一个字典 作为参数
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"age": @10, @"name": @"lili", @"height": @158}]];
}

//JS 调用此方法 并且由JS传入 title 和 Message 这两个参数
- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [a show];

    });
}

/*
 测试
 */

- (void)JSCallOCWithTitle:(NSString *)title number:(int) num{
    
    NSLog(@"title = %@ number = %d", title, num);
}
- (void)OCCallJS{
    JSValue *value = _jsContext[@"jsFuncWithOCParam"];
    [value callWithArguments:@[@"lili",@"10"]];
}
@end
