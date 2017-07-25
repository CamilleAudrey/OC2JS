//
//  NextViewController.m
//  OC222JS
//
//  Created by imac on 17/7/24.
//  Copyright © 2017年 Guowu. All rights reserved.
//  js调用OC方法 分两种情况
/*
 1. JS里面直接调用方法
 2. JS里面通过对象调用方法
 */

#import "NextViewController.h"
#import "TestJSObject.h"


@interface NextViewController ()<UIWebViewDelegate>
{
    UIWebView *myWebView;
    
}
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-40)];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
    
    
    NSString *httpStr = @"https://www.baidu.com";
    NSURL *url = [NSURL URLWithString:httpStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [myWebView loadRequest:request];
    
    
    // Do any additional setup after loading the view.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //开始加载网页调用此方法
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //网页加载完成调用此方法

    //首先创建JSContext对象 （此处通过当前webview的键获取到jscontext）
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //js 调用 iOS
    //第一种情况
    //其中test1 就是js的方法名称 赋给一个block 里面就是iOS代码
    //此方法最终会打印出所有收到的参数 js参数是不固定的
    context[@"test1"] = ^(){
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"参数是：%@", obj);
        }
    };
    //此处我们没有写后台（但是前面我们已经知道ios 是可以 调用js的 我们可以模拟一下）
    //首先准备一下js代码 来调用js函数 test1  然后执行
    //一个参数
    NSString *jsFunctStr = @"test1('参数1')";
    [context evaluateScript:jsFunctStr];
    
    
    //第二个参数
    NSString *jsFunctStr1 = @"test1('参数a', '参数b')";
    [context evaluateScript:jsFunctStr1];
    
    
    //第二种情况， JS是通过对象调用的 我们假设 JS里面有一个对象 testobject 在调用此方法
    //首先，创建我们新建的对象，将他赋值给JS对象
    
    TestJSObject *testjo = [TestJSObject new];
    context[@"testobject"] = testjo;
    
    //同样我们也使用刚才的方法模拟一下js调用方法
    NSString *jsStr1 = @"testobject.TestNOParameter()";
    [context evaluateScript:jsStr1];
    
    
    NSString *jsStr2 = @"testobject.TestOneParameter('参数1')";
    [context evaluateScript:jsStr2];
    
    NSString *jsStr3 = @"testobject.TestTowParameterSecondParameter('参数a', '参数b')";
    [context evaluateScript:jsStr3];
    
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //网页加载失败 调用此方法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
