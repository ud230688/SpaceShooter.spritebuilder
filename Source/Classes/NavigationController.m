//
//  NavigationController.m
//  SpaceShooter
//
//  Created by Udit AJMERA on 09/03/16.
//  Copyright © 2016 Apportable. All rights reserved.
//
//------------------------------------------------
#pragma mark - Project imports
//------------------------------------------------

#import "NavigationController.h"

//------------------------------------------------
#pragma mark - Interface
//------------------------------------------------

@interface NavigationController ()

//------------------------------------------------
@end
//------------------------------------------------

//------------------------------------------------
#pragma mark - Implementation
//------------------------------------------------

@implementation NavigationController

- (void)viewWillAppear:(BOOL)animated
{
    [self setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//------------------------------------------------
@end
//------------------------------------------------