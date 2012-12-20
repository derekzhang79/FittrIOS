//
//  LoginViewController.h
//  Fittr
//
//  Created by So Townsend on 12/15/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface LoginSelectionController : ViewController <NSURLConnectionDelegate>

- (IBAction)getTweets:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (nonatomic, readwrite) NSMutableData *data;

@end