//
//  ViewController.m
//  OC222JS
//
//  Created by imac on 17/7/24.
//  Copyright © 2017年 Guowu. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()<UIWebViewDelegate>

{
    UIWebView *myWebView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-40)];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
    
    
    NSString *httpStr = @"https://www.baidu.com";
    NSURL *url = [NSURL URLWithString:httpStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [myWebView loadRequest:request];
    
    
    UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    next.backgroundColor = [UIColor cyanColor];
    [next setTitle:@"下一页" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)next{
    NextViewController *next = [[NextViewController alloc] init];
    [self presentViewController:next animated:YES completion:nil];
    
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
    
    //准备执行的js代码
    NSString *alertJS = @"alert('iOS 调用 JS')";
    
    //通过OC方法调用JS的alert
    [context evaluateScript:alertJS];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //网页加载失败 调用此方法
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
