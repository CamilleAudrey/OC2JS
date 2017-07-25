//
//  ViewController.m
//  JSCallOC
//
//  Created by imac on 17/7/24.
//  Copyright © 2017年 Guowu. All rights reserved.
//  http://blog.csdn.net/LeaderQiu/article/details/51955956

#import "ViewController.h"
#import "MySDK.h"

@interface ViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation ViewController

-(BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [MySDK sayLiuMan];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.webView];
    
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.webView.delegate=self;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
 
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //JS给OC传值
    context[@"postStr"] = ^(){
        NSArray *args = [JSContext currentArguments];//得到的是实参数的数组
        
        for (id obj in args) {
            NSLog(@"%@", obj);
        }
    };

    //OC给JS传值
    //NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"postStr();"];
    //要传递的参数一
    NSString *str1 = @"我来自于oc";
    //要传递的参数二
    NSString *str2 = @"我来自于地球";
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@','%@');",str1,str2]];
    NSLog(@"JS返回值：%@",str);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}


@end
