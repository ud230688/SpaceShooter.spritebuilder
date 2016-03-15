//
//  AppDelegate.h
//  SpaceShooter
//
//  Created by Udit AJMERA on 08/03/16.
//  Copyright © 2016 iTeam. All rights reserved.
//
//------------------------------------------------
#pragma mark - SDK imports
//------------------------------------------------

#import <UIKit/UIKit.h>

//------------------------------------------------
#pragma mark - Forward Class Declaration
//------------------------------------------------

@class VisualWorld;

//------------------------------------------------
#pragma mark - Interface imports
//------------------------------------------------

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)setVisualWorld:(VisualWorld*)lobjVW;
- (VisualWorld*)getVisualWorld;
+ (AppDelegate *)classinstance;

//------------------------------------------------
@end
//------------------------------------------------
