//
//  GameMenuViewController.m
//  SpaceShooter
//
//  Created by Udit AJMERA on 09/03/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "GameMenuViewController.h"
#import "GameViewController.h"

@interface GameMenuViewController ()

@end

@implementation GameMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonPressed:(id)sender
{
    [self loadGame];
}

- (void)loadGame
{
    
    
    //UIViewController* lobjGamesTableVC = [NetworkMessageUtils currentViewController];
    //
    //        [lobjGamesTableVC performSegueWithIdentifier:@"GamesTVCToGameVC"
    //                                              sender:lobjGamesTableVC];
    //
    //        //  if([viewController isKindOfClass:[CreateGame class]])
    //        {
    //            SLog(@"class->%@",[lobjGamesTableVC class]);
    //        }
    
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName
                                                         bundle: nil];
    
    GameViewController* lobjGameVC = (GameViewController*)[storyboard instantiateViewControllerWithIdentifier:@"GameVCSBID"];
    
    //    MMDrawerController *obj_drawer = [LoadMMdrawerclass Loaddrawerclass:lobjGameVC];
    
    [self presentViewController:lobjGameVC
                                   animated:NO
                                 completion:
     ^{
         
         [lobjGameVC addVisualWorld];
         
     }];
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
