//
//  HYBJsObjCModel.h
//  OC2JS
//
//  Created by imac on 17/7/24.
//  Copyright © 2017年 Guowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol JavaScriptObjectiveCDelegate <JSExport>

// JS调用此方法来调用OC的系统相册方法
- (void)callSystemCamera;
// 在JS中调用时，函数名应该为showAlertMsg(arg1, arg2)
// 这里是只两个参数的。
- (void)showAlert:(NSString *)title msg:(NSString *)msg;
// 通过JSON传过来
- (void)callWithDict:(NSDictionary *)params;
// JS调用Oc，然后在OC中通过调用JS方法来传值给JS。
- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params;

- (void)JSCallOCWithTitle:(NSString *)title number:(int) num;
- (void)OCCallJS;

@end

// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
@interface HYBJsObjCModel : NSObject <JavaScriptObjectiveCDelegate>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;

@end
