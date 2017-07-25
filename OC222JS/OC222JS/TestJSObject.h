//
//  TestJSObject.h
//  OC222JS
//
//  Created by imac on 17/7/24.
//  Copyright © 2017年 Guowu. All rights reserved.
// JSExport 凡是添加了JSExport 协议的协议  所规定的方法 变量 等 就会对JS开放 我们可以JS调用到


#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//首先创建以个实现了JSExport协议的协议
@protocol TestJSObjectProtocol <JSExport>

//如果JS是一个参数或者没有参数的话就比较简单 我们的方法名和JS的方法名保持一致即可
//此处我么测试几种参数的情况
- (void)TestNOParameter;
- (void)TestOneParameter:(NSString *)message;
- (void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2;

@end

//让我们创建的类实现上边的协议
@interface TestJSObject : NSObject <TestJSObjectProtocol>


@end
