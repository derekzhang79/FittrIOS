//
//  LoginViewController.h
//  Fittr
//
//  Created by So Townsend on 12/15/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface LoginViewController : ViewController <NSURLConnectionDelegate>

- (IBAction)loginWithFacebook:(id)sender;
- (IBAction)getTweets:(id)sender;
- (IBAction)loginNormally:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (nonatomic, readwrite) NSMutableData *data;

@end