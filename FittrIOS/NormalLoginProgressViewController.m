//
//  NormalLoginProgressViewController.m
//  Fittr
//
//  Created by So Townsend on 12/19/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "NormalLoginProgressViewController.h"

@implementation NormalLoginProgressViewController

@synthesize username;
@synthesize password;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFFittrClient *client = [AFFittrClient sharedClient];
    [client checkUserWithUsername:username andPassword:password];
}

- (IBAction)back:(id)sender {
    [self performSegueWithIdentifier:@"login" sender:Nil];
    
}
@end
