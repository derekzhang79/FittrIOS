//
//  NormalLoginViewController.h
//  Fittr
//
//  Created by So Townsend on 12/19/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalLoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;

@end
