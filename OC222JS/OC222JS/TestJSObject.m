//
//  TestJSObject.m
//  OC222JS
//
//  Created by imac on 17/7/24.
//  Copyright © 2017年 Guowu. All rights reserved.
//

#import "TestJSObject.h"

@implementation TestJSObject

//以下方法都只是打了个log  等会看log 以及参数能对上 就说明JS调用了此处iOS 原生方法
- (void)TestNOParameter{
    NSLog(@"This is iOS TestNOParameter");
}

- (void)TestOneParameter:(NSString *)message{
    NSLog(@"This is iOS TestOneParameter = %@", message);
}
- (void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2{
    NSLog(@"This is iOS TestTowParameter = %@ second = %@",message1, message2);
}

@end
