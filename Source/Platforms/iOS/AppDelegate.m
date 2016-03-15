//
//  AppDelegate.m
//  SpaceShooter
//
//  Created by Udit AJMERA on 08/03/16.
//  Copyright © 2016 iTeam. All rights reserved.
//
//------------------------------------------------
#pragma mark - Project imports
//------------------------------------------------

#import "AppDelegate.h"
#import "VisualWorld.h"
#import "QueueManager.h"

//------------------------------------------------
#pragma mark - Interface
//------------------------------------------------

@interface AppDelegate ()

@property(nonatomic, strong)VisualWorld*    objVisualWorldGameEngine;

//------------------------------------------------
@end
//------------------------------------------------


//------------------------------------------------
#pragma mark - Interface
//------------------------------------------------

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[QueueManager sharedInstance] initialize];
    UIScreen *mainScreen = [UIScreen mainScreen];
    SLog(@"Screen bounds: %@, Screen resolution: %@, scale: %f, nativeScale: %f",
          NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);

      return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//------------------------------------------------------
#pragma mark -  App delegate  classInstance method
//------------------------------------------------------


static AppDelegate *temp;
+(AppDelegate *)classinstance
{
    if (temp == nil)
    {
        temp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    }
    
    return temp;
}

//------------------------------------------------------
#pragma mark -  GameEngine setter and getter
//------------------------------------------------------

- (void)setVisualWorld:(VisualWorld*)lobjVW
{
    self.objVisualWorldGameEngine = lobjVW;
}

- (VisualWorld*)getVisualWorld
{
    return self.objVisualWorldGameEngine;
}


//------------------------------------------------
@end
//------------------------------------------------
