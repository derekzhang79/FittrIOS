//
//  AppDelegate.m
//  FittrIOS
//
//  Created by So Townsend on 12/5/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "AppDelegate.h"

NSString *const FBSessionStateChangedNotification =
@"com.gndfloor.Login:FBSessionStateChangedNotification";


@implementation AppDelegate

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                NSLog(@"User session found");
                
                if (FBSession.activeSession.isOpen) {
                    NSLog(@"Good");
                    
                    [FBRequestConnection
                     startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                       id<FBGraphUser> user,
                                                       NSError *error) {
                         if (!error) {
                             NSString *userInfo = @"";
                             
                             // Example: typed access (name)
                             // - no special permissions required
                             userInfo = [userInfo
                                         stringByAppendingString:
                                         [NSString stringWithFormat:@"Name: %@\n\n",
                                          user.name]];
                             
                             userInfo = [userInfo
                                         stringByAppendingString:
                                         [NSString stringWithFormat:@"Birthday: %@\n\n",
                                          [user location]]];
                             
                             userInfo = [userInfo
                                         stringByAppendingString:
                                         [NSString stringWithFormat:@"Birthday: %@\n\n",
                                          [user id]]];
                             
                             userInfo = [NSString stringWithFormat:@"%@", FBSession.activeSession.accessToken];
                             
                             NSLog(@"%@", userInfo);
                             
                         }
                     }];
                    
                }
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    return [FBSession openActiveSessionWithReadPermissions:nil
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* ###################### UI Related ###################### */
    //Colors
    UIColor *fittrBlue = [UIColor colorWithRed:0.152941 green:0.650980 blue:0.678431 alpha:1];
    UIColor *fittrLightBlue = [UIColor colorWithRed:0.623529 green:0.843137 blue:0.933333 alpha:1];
    UIColor *fittrWhite = [UIColor colorWithRed:0.972549 green:0.972549 blue:0.972549 alpha:1];
    UIColor *fittrBlack = [UIColor colorWithRed:0.196078 green:0.196078 blue:0.196078 alpha:1];
    
    //Tab bar
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setSelectedImageTintColor: [UIColor whiteColor]];
	[tabBar setBackgroundImage:[UIImage imageNamed:@"tabbg.png"]];
	[tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabselected.png"]];
    [tabBar setTintColor:fittrBlue];
    
    //Tab bar item
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    //Non selected tab bar text
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    fittrLightBlue,
                                    UITextAttributeTextColor,
                                    fittrLightBlue,
                                    UITextAttributeTextShadowColor,
                                    [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                    UITextAttributeTextShadowOffset,
                                    [UIFont fontWithName:@"System Bold" size:12.0],
                                    UITextAttributeFont,
                                    nil] forState:UIControlStateNormal];
    
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor],
                                        UITextAttributeTextColor,
                                        [UIColor whiteColor],
                                        UITextAttributeTextShadowColor,
                                        [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                        UITextAttributeTextShadowOffset,
                                        [UIFont fontWithName:@"System Bold" size:12.0],
                                        UITextAttributeFont,
                                        nil] forState:UIControlStateSelected];
    
    //Navigation bar
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor: fittrBlue];
    [navBar setBackgroundImage:[UIImage imageNamed:@"titlebg.png"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor clearColor],
                                                                     UITextAttributeTextColor,
                                                                     [UIColor whiteColor],
                                                                     UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 3)],
                                                                     UITextAttributeTextShadowOffset,
                                                                     [UIFont fontWithName:@"Lobster 13" size:23.0],
                                                                     UITextAttributeFont,
                                                                     nil]];
    
    //Navigation bar buttons like 'back'
    UIBarButtonItem *navBarItem = [UIBarButtonItem appearance];
    [navBarItem setTintColor: fittrBlue];
    
    /* ###################### End UI Related ###################### */
    
    //Setup restkit singleton (automatically used globally
    //RKClient* client = [RKClient clientWithBaseURL:@"http://www.fittr.com"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
