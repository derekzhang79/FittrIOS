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
}

- (void)viewDidAppear:(BOOL)animated {
    AFFittrClient *client = [AFFittrClient sharedClient];
    [client checkUserWithUsername:username andPassword:password delegate:self];
}

-(void)onCheckUser:(BOOL)userExists {
    if (userExists) {
        [self performSegueWithIdentifier:@"login" sender:Nil];
    } else {
        [self dismissViewControllerAnimated:TRUE completion:Nil];
        [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry, the username or password you provided was not valid." delegate:Nil cancelButtonTitle:@"Argh!" otherButtonTitles:Nil] show];
    }
}

@end