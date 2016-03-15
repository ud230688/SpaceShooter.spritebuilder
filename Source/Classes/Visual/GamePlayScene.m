//
//  GamePlayScene.m
//  TripleJackPokerGame
//
//  Created by Udit on 12/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
// -----------------------------------------------------------------------
#pragma mark - Project Imports
// -----------------------------------------------------------------------

#import "GamePlayScene.h"
#import "VisualWorld.h"
#import "GamePlayLayer.h"
#import "FileUtils.h"

// -----------------------------------------------------------------------
#pragma mark - Interface
// -----------------------------------------------------------------------

@interface GamePlayScene()

@property(nonatomic, weak)  VisualWorld*       objVisualWorld;
@property(nonatomic, strong)GamePlayLayer*     objGamePlayLayer;


// -----------------------------------------------------------------------
@end
// -----------------------------------------------------------------------


@implementation GamePlayScene
{
    
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (GamePlayScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)initWithVisualWorld:(VisualWorld*)lobjVW
                resources:(NSArray*)larrayResources
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    self.objVisualWorld = lobjVW;
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    [self loadResources:larrayResources];
    
    GamePlayLayer *lobjGamePlayLayer =
    [GamePlayLayer nodeWithColor:[CCColor colorWithRed:255
                                               green:255
                                                blue:255
                                               alpha:255]];
    [self addChild:lobjGamePlayLayer
                 z:0];
    
    
    [lobjGamePlayLayer setUpGame];
    
    self.objGamePlayLayer = lobjGamePlayLayer;
    
    //Physics Setup
    {
        self.objPhysicsWorld = nil;
        self.objPhysicsWorld = [CCPhysicsNode node];
        self.objPhysicsWorld.gravity = ccp(0,0);
        self.objPhysicsWorld.debugDraw = YES;
        self.objPhysicsWorld.collisionDelegate = self;
        [self addChild:self.objPhysicsWorld];
    }

    // done
    return self;
}

- (void)loadResources:(NSArray*)larrayResources
{
    for (NSString* lstrResourceName in larrayResources)
    {
        NSString* lstrFilePathForTextureAtlas = [FileUtils pathForFileName:lstrResourceName];
        
        if (lstrFilePathForTextureAtlas)
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache]
             addSpriteFramesWithFile:lstrFilePathForTextureAtlas];
        }
        else
        {
            NSLog(@"ERROR : Requested Resource (%@) not availble", lstrResourceName);
        }
    }
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

-(void)update:(CCTime)delta
{
    
}


// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch
         withEvent:(UIEvent *)event
{
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    //    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
    //                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5f]];
}

// -----------------------------------------------------------------------
@end
// -----------------------------------------------------------------------