//
//  ViewController.m
//  FittrIOS
//
//  Created by So Townsend on 12/5/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AFFittrClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"Hello World!");
    
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/ip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"IP Address: %@", [JSON valueForKeyPath:@"origin"]);
    } failure:nil];
    
    [operation start];
    
    AFFittrClient *client = [AFFittrClient sharedClient];
    [client checkUserWithUsername:@"jlesko" andPassword:@"test"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
