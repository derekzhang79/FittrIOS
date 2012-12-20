//
//  NormalLoginViewController.m
//  Fittr
//
//  Created by So Townsend on 12/19/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "NormalLoginViewController.h"

@implementation NormalLoginViewController

@synthesize username;
@synthesize password;
@synthesize errorMessage;

- (void)viewDidLoad {
    //Setup error handling
    errorMessage = [[NSString alloc] init];
    
    //Setup keyboard nexting
    username.tag = 0;
    password.tag = 1;
    
    [username becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so login
        [self login:Nil];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (IBAction)login:(id)sender {
    //If username and password are filled out, move along
    if ([[username text] length] && [[password text] length])
        [self performSegueWithIdentifier:@"attemptLogin" sender:Nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"attemptLogin"]) {
        [[segue destinationViewController] setUsername: username.text];
        [[segue destinationViewController] setPassword: password.text];
        [[segue destinationViewController] setNormalLoginView: self];
    }
}

@end
