//
//  LoginViewController.m
//  Fittr
//
//  Created by So Townsend on 12/15/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Hello!");
}

- (IBAction)loginWithFacebook:(id)sender
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    BOOL res = [delegate openSessionWithAllowLoginUI:true];
    
    //If facebook login was successful
    if (res) {
        [self performSegueWithIdentifier:@"login" sender:0];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Oy Vay!" message:@"Your cat died. Just kidding.  I couldn't connect to facebook." delegate:0 cancelButtonTitle:@"Errgh!" otherButtonTitles:nil] show];
        
    }
}

@end
