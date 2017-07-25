//
//  NextViewController.m
//  OC2JS
//
//  Created by imac on 17/7/21.
//  Copyright © 2017年 Guowu. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIButton *nextPage1;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong)UIWebView *webView2;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _nextPage1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 20)];
    [_nextPage1 setTitle:@"下一页" forState:UIControlStateNormal];
    _nextPage1.backgroundColor = [UIColor cyanColor];
    [_nextPage1 addTarget:self action:@selector(back1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextPage1];

    
    _webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    _webView2.backgroundColor = [UIColor clearColor];
    _webView2.scalesPageToFit = YES;
    _webView2.delegate = self;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView2 loadRequest:request];
    [self.view addSubview:_webView2];
    
    

    // Do any additional setup after loading the view.
}
- (void)back1{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    HYBJsObjCModel *model  = [[HYBJsObjCModel alloc] init];
    self.jsContext[@"OCModel"] = model;
    model.jsContext = self.jsContext;
    //model.webView = self.webView2;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
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
