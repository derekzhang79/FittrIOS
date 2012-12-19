//
//  LoginViewController.m
//  Fittr
//
//  Created by So Townsend on 12/15/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize data;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Hello!");
    
    data = [[NSMutableData alloc] init];
    
    self.logo.alpha = 0.0f;
    [UIView animateWithDuration:1.0f
        delay:1.0f
        options:UIViewAnimationOptionCurveEaseIn
        animations:^(void) {
            self.logo.alpha = 1.0f;
        }
        completion:NULL];
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

- (IBAction)getTweets:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=@scottgu"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
}

- (IBAction)loginNormally:(id)sender {
    [self performSegueWithIdentifier:@"login" sender:0];
}



@end
