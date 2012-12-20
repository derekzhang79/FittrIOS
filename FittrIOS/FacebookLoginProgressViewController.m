//
//  FacebookLoginProgressViewController.m
//  Fittr
//
//  Created by So Townsend on 12/20/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "FacebookLoginProgressViewController.h"

@implementation FacebookLoginProgressViewController

- (void)viewDidAppear:(BOOL)animated {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    BOOL res = [delegate openSessionWithAllowLoginUI:true];
    
    //If facebook login was successful
    if (res) {
        [self performSegueWithIdentifier:@"login" sender:0];
    } else {
        [self dismissViewControllerAnimated:TRUE completion:Nil];
        [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"I couldn't connect to your facebook account." delegate:Nil cancelButtonTitle:@"Argh!" otherButtonTitles:nil] show];
    }
}

@end