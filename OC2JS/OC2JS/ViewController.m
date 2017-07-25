//
//  ViewController.m
//  OC2JS
//
//  Created by imac on 17/7/21.
//  Copyright © 2017年 Guowu. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIButton *nextPage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nextPage = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 20)];
    [_nextPage setTitle:@"下一页" forState:UIControlStateNormal];
    _nextPage.backgroundColor = [UIColor cyanColor];
    [_nextPage addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextPage];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    
    webView.delegate = self;
    
    //https://www.google.com.hk/m?gl=CN&hl=zh_CN&source=ihp
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.google.com.hk/m?gl=CN&hl=zh_CN&source=ihp"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //获取当前页面的url
    NSString *currentUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];

    //获取title
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    //修改界面元素的值
    NSString *js_result = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('q')"];
    
    //表单提交
    NSString *js_result2 = [webView stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit();"];
    
    //插入JS代码
    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction() { "
     "var field = document.getElementsByName('q')[0];"
     "field.value='HiroGuo';"
     "document.forms[0].submit();"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
    
    
     NSLog(@"currentUrl = %@ title = %@ js_result = %@ js_result2 = %@", currentUrl, title, js_result, js_result2);
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    NSLog(@"error = %@", error.description);
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
//    if (webView.canGoBack) {
//        [webView goBack];
//    }else{
//
//    }
}

- (void)next{

    NextViewController *nextVC = [[NextViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:nextVC animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
