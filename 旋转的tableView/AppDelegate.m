//
//  AppDelegate.m
//  旋转的tableView
//
//  Created by 王奥东 on 16/9/19.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "AppDelegate.h"
#import "ADHorizonalTableViewController.h"

#define  kScreenW [UIScreen mainScreen].bounds.size.width
#define  kScreenH [UIScreen mainScreen].bounds.size.height

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0,kScreenW, kScreenH)];
    ADHorizonalTableViewController *horizonal = [[ADHorizonalTableViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:horizonal];
    window.rootViewController = nav;
    
    self.window = window;
    
    [window makeKeyAndVisible];
    
    
    return YES;
}



@end
