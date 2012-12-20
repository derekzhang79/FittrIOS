//
//  NormalLoginProgressViewController.h
//  Fittr
//
//  Created by So Townsend on 12/19/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFittrClient.h"

@interface NormalLoginProgressViewController : UIViewController <AFFittrClientDelegate>

-(void)onCheckUser;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end
