//
//  LoginViewController.m
//  Fittr
//
//  Created by So Townsend on 12/15/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "LoginSelectionController.h"

@implementation LoginSelectionController

@synthesize data;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Hello!");
    
    data = [[NSMutableData alloc] init];
    
    self.logo.alpha = 0.0f;
    [UIView animateWithDuration:1.0f
        delay:0.5f
        options:UIViewAnimationOptionCurveLinear
        animations:^(void) {
            self.logo.alpha = 1.0f;
        }
        completion:NULL];
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
