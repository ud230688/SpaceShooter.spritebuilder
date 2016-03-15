 //
//  GameViewController.m
//  SpaceShooter
//
//  Created by Udit AJMERA on 09/03/16.
//  Copyright © 2016 Apportable. All rights reserved.
//
//------------------------------------------------
#pragma mark - Project imports
//------------------------------------------------

#import "GameViewController.h"
#import "VisualWorld.h"

//------------------------------------------------
#pragma mark - Interface imports
//------------------------------------------------

@interface GameViewController ()<VWDelegate>

@property (nonatomic, strong)VisualWorld* objVisualWorld;

//------------------------------------------------
@end
//------------------------------------------------

//------------------------------------------------
#pragma mark - Implementation imports
//------------------------------------------------

@implementation GameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (BOOL)addVisualWorld
{
    
    if (self.objVisualWorld == nil)
    {
        CGRect lstructDeviceFrame ;
        
        lstructDeviceFrame = CGRectMake(0.0f, 0.0f,
                                        CGRectGetWidth([UIScreen mainScreen].applicationFrame),
                                        CGRectGetHeight([UIScreen mainScreen].applicationFrame));
        
        
        
        
        {
            VisualWorld* lobjVisualWorld = nil;
            [THIS getVisualWorld];
            lobjVisualWorld = [THIS getVisualWorld];
            
            if(nil == lobjVisualWorld)
            {
                
                lobjVisualWorld =
                [[VisualWorld alloc] initGameWithViewFrame:lstructDeviceFrame];
                
                
                lobjVisualWorld.delegate = self;
                
                
                [self addChildViewController:lobjVisualWorld];
                [self.view addSubview:lobjVisualWorld.view];
                
                [lobjVisualWorld didMoveToParentViewController:self];
                
                
                self.objVisualWorld = lobjVisualWorld;
                
                [THIS setVisualWorld:lobjVisualWorld];
                
            }
            else
            {
                self.objVisualWorld = lobjVisualWorld;
                
                
                self.objVisualWorld.delegate = self;
                
            }
            
        }
        
    }
    else
    {
        SLog(@"ERROR : Trying to add two VisualWorlds");
        
        return NO;
    }
    
    return YES;
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