//
//  ViewController.m
//  RouterDemo
//
//  Created by caochao on 16/10/14.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import "ViewController.h"
#import "CCBusinessManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.正确调用
    NSString *testUrl = @"loginmodule://login?userName=9ygm471&password=a123456";
    
    [[CCBusinessManager sharedInstance] openLocalURL:[NSURL URLWithString:testUrl] completion:^(NSDictionary *result, NSError *error) {
       
        NSLog(@"%@,%@",result,error);
    }];
    
    //2.却少参数
    testUrl = @"loginmodule://login?account=9ygm471";
    
    [[CCBusinessManager sharedInstance] openLocalURL:[NSURL URLWithString:testUrl] completion:^(NSDictionary *result, NSError *error) {
        
        NSLog(@"%@,%@",result,error);
    }];
    
    //3.接口不存在
    testUrl = @"loginmodule://check?account=9ygm471&password=a123456";
    
    [[CCBusinessManager sharedInstance] openLocalURL:[NSURL URLWithString:testUrl] completion:^(NSDictionary *result, NSError *error) {
        
        NSLog(@"%@,%@",result,error);
    }];
    
    //3.业务不存在
    testUrl = @"registermodule://register?account=9ygm471&password=a123456";
    
    [[CCBusinessManager sharedInstance] openLocalURL:[NSURL URLWithString:testUrl] completion:^(NSDictionary *result, NSError *error) {
        
        NSLog(@"%@,%@",result,error);
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
