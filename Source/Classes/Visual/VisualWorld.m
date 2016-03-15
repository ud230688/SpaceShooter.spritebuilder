//
//  VisualWorld.m
//  TripleJackPokerGame
//
//  Created by Udit on 12/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
//---------------------------------------------------------------------------------
#pragma Project Imports
//---------------------------------------------------------------------------------

#import "VisualWorld.h"
#import "GamePlayScene.h"
#import "GamePlayLayer.h"
#import "GameEntitySprite.h"
#import "GameWorld.h"
#import "QueueManager.h"
#import "CCSprite.h"
#import "GameConstants.h"

//---------------------------------------------------------------------------------
#pragma Interface
//---------------------------------------------------------------------------------

@interface VisualWorld ()

@property(nonatomic, strong)NSString*               strLevelFileName;
@property(nonatomic, assign)CGRect                  structWorldRect;
@property(nonatomic, strong)GamePlayScene*          objGamePlayScene;
@property(nonatomic, strong)NSMutableDictionary*    dictIdToSprites;
@property(nonatomic, strong)NSMutableDictionary*    dictIdToBetTimer;
@property(nonatomic, strong)GameWorld*              objGameWorld;

@property(nonatomic, strong)CADisplayLink*          objDisplayLink;
@property(nonatomic, strong)NSMutableArray*         arrayTableCommonCards;

@property(nonatomic, assign)CFTimeInterval          fLastTimeStamp;
@property(nonatomic, strong)CCDrawNode*             objTimeProgressDrawNode;

@property(nonatomic, strong)CCLabelTTF*             objMainPotTotalLabel;
@property(nonatomic, strong)CCGLView*               objCCGLView;

@property(nonatomic, assign)BOOL                    bSidePanelShowing;
@property(nonatomic, assign)BOOL                    bBombPanelShowing;
@property(nonatomic, strong)CCLabelTTF*             objHandRankLabel;
@property(nonatomic, strong)CCSprite*               objHandRankBase;

@property(nonatomic, strong)CCNodeColor*            objShowDownWinBase;
@property(nonatomic, strong)CCLabelTTF*             objShowDownWinLabel;
@property(nonatomic, assign)CurrencyType            enumCurrencyType;
@property (nonatomic, weak,   readwrite) id<VWDelegate> objVWdelegate;

@property (nonatomic, strong)NSDictionary             *dictPokerFaceToVariants;


//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
#pragma Implementation
//---------------------------------------------------------------------------------

@implementation VisualWorld

//---------------------------------------------------------------------------------
#pragma mark - Initialization Methods
//---------------------------------------------------------------------------------

- (void)setupDisplaySystemWithViewFrame:(CGRect)lrectViewFrame
                                 config:(NSDictionary*)config
{
    
    CCGLView *lobjCCGLView = [CCGLView
                              viewWithFrame:lrectViewFrame
                              pixelFormat:config[CCSetupPixelFormat] ?: kEAGLColorFormatRGBA8
                              depthFormat:[config[CCSetupDepthFormat] unsignedIntValue]
                              preserveBackbuffer:[config[CCSetupPreserveBackbuffer] boolValue]
                              sharegroup:nil
                              multiSampling:[config[CCSetupMultiSampling] boolValue]
                              numberOfSamples:[config[CCSetupNumberOfSamples] unsignedIntValue]
                              ];
    {
        //#if DEBUG
        // Display FSP and SPF
        [self setDisplayStats:[config[CCSetupShowDebugStats] boolValue]];
        //#endif
        
        // set FPS at 60
        NSTimeInterval animationInterval = [(config[CCSetupAnimationInterval] ?: @(1.0/60.0)) doubleValue];
        [self setAnimationInterval:animationInterval];
        
        self.fixedUpdateInterval = [(config[CCSetupFixedUpdateInterval] ?: @(1.0/60.0)) doubleValue];
        
        // attach the openglView to the director
        [self setView:lobjCCGLView];
        self.objCCGLView = lobjCCGLView;
    }
    
    [self setProjection:CCDirectorProjection2D];
    
    [CCTexture setDefaultAlphaPixelFormat:CCTexturePixelFormat_RGBA8888];
    
}

- (id)initGameWithViewFrame:(CGRect)lrectViewFrame;
{
    self = [super init];
    
    if (self)
    {
        SLog(@"VW rect(%f,%f,%f,%f)",lrectViewFrame.origin.x,lrectViewFrame.origin.y,
             lrectViewFrame.size.width, lrectViewFrame.size.height);
        // self.view.frame = lrectViewFrame;
        self.structWorldRect = lrectViewFrame;
        self.bSidePanelShowing = NO;
        self.bBombPanelShowing = NO;
        [self setupDisplaySystemWithViewFrame:lrectViewFrame
                                       config:@{
                                                // Show the FPS and draw call label.
                                                CCSetupShowDebugStats: @(NO),
                                                }];
        
        [self startAnimation];
        
        // Pushing a VisualWorldGameScene, initially, Loading Resources
        // and on finishing the game starts
        
        [self loadGameScene];
        if (self.objGameWorld == nil)
        {
            //            self.objGameWorld = [self initializeGameWorldwithWorldRect:self.structWorldRect
            //                                                      physicsWorldRect:self.structPhysicsWorldRect
            //                                                                 level:self.objLevel];
            
            self.objGameWorld = [[GameWorld alloc]initWithVisualWorld:self
                                                            worldRect:self.structWorldRect];
        }
        
        [self setUpComplete];
        
        float lfContentScaleFactor = [CCDirector sharedDirector].contentScaleFactor;
        NSString *platform = [[UIDevice currentDevice] model];
        
        NSString* lstrScaleFactor = [NSString stringWithFormat:@"platform:%@ ScaleFactor->%f",platform,lfContentScaleFactor];
        
        
    }
    return self;
}

//------------------------------------------------------
#pragma mark - SharedInstance
//------------------------------------------------------


+ (VisualWorld*)sharedInstance
{
    static VisualWorld *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[VisualWorld alloc] init];
                      
                  });
    return sharedInstance;
}


- (void)reloadWithViewFrame:(CGRect)lrectViewFrame
{
    
    {
                  [self resume];
        SLog(@"rect(%f,%f,%f,%f)",lrectViewFrame.origin.x,lrectViewFrame.origin.y,
             lrectViewFrame.size.width, lrectViewFrame.size.height);
        // self.view.frame = lrectViewFrame;
        self.structWorldRect = lrectViewFrame;
        self.bSidePanelShowing = NO;
        self.bBombPanelShowing = NO;
        [self startAnimation];
        
        // Pushing a VisualWorldGameScene, initially, Loading Resources
        // and on finishing the game starts
        
        if (self.objGameWorld == nil)
        {
            //            self.objGameWorld = [self initializeGameWorldwithWorldRect:self.structWorldRect
            //                                                      physicsWorldRect:self.structPhysicsWorldRect
            //                                                                 level:self.objLevel];
            
            self.objGameWorld = [[GameWorld alloc]initWithVisualWorld:self
                                                            worldRect:self.structWorldRect];
        }
        
        [self loadGameScene];
        
        [self setUpComplete];
        
        float lfContentScaleFactor = [CCDirector sharedDirector].contentScaleFactor;
        NSString *platform = [[UIDevice currentDevice] model];
        
        NSString* lstrScaleFactor = [NSString stringWithFormat:@"platform:%@ ScaleFactor->%f",platform,lfContentScaleFactor];
        
        
        
    }
}


- (void)loadGameScene
{
    // Rather than Pushing this Scene here pushing it after Resources of it are loaded
    NSArray* larrayResources = nil;
    
    //    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    //    {
    //        larrayResources = [NSArray
    //                           arrayWithObjects:@"All_Avtar_Varient-ipadhd.plist",@"Cards-ipadhd.plist",@"0AllBombs-hd.plist",@"0AllBombs-hd.plist",@"1AllBombs-hd.plist",@"2AllBombs-hd.plist",
    //                           @"3AllBombs-hd.plist",@"4AllBombs-hd.plist",
    //                           @"5AllBombs-hd.plist",@"6AllBombs-hd.plist",@"envirnoment-hd.plist",nil];
    //    }
    //    else
    //    {
    //        larrayResources = [NSArray
    //                           arrayWithObjects:@"All_Avtar_Varient-hd.plist",@"Cards-hd.plist",@"0AllBombs-hd.plist",@"1AllBombs-hd.plist",@"2AllBombs-hd.plist",
    //                           @"3AllBombs-hd.plist",@"4AllBombs-hd.plist",
    //                           @"5AllBombs-hd.plist",@"6AllBombs-hd.plist",@"envirnoment-hd.plist",nil];
    //    }
    //
    
    
    GamePlayScene* lobjSCENE =
    [[GamePlayScene alloc] initWithVisualWorld:self
                                     resources:larrayResources];
    
    //    [[CCSpriteFrameCache sharedSpriteFrameCache]
    //     addSpriteFramesWithFile:@"avatars120-hd.plist"];
    self.objGamePlayScene = lobjSCENE;
    //[self pushScene:lobjSCENE];
    [self replaceScene:lobjSCENE];
    
}


- (void)setUpComplete
{
    
    [self addBackground];
    [self addPlayer];
    
    //[[AudioManager sharedInstance] preloadAllEffectSounds];
    GAME_QUEUE_ASYNC(
                     [self.objGameWorld setUpComplete];
                     );
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokerFaceVariants"
                                                     ofType:@"plist"];
    
    self.dictPokerFaceToVariants = [[NSDictionary alloc]
                                    initWithContentsOfFile:path];
    
}


//---------------------------------------------------------------------------------
#pragma mark - Menu Button
//---------------------------------------------------------------------------------


- (void)addMenuButton
{
    //index button
    {
        
        NSString* lstrMenuButtonImageName = [self frameNameFromName:@"index88x88.png"];
        
        CCSpriteFrame* lobjSpriteFrame = [CCSpriteFrame frameWithImageNamed:lstrMenuButtonImageName];
        
        
        
        CCButton* lobjMenuButton = [[CCButton alloc]initWithTitle:@""
                                                      spriteFrame:lobjSpriteFrame];
        
        lobjMenuButton.label.color = [CCColor colorWithUIColor:[UIColor blackColor]];
        
        
        lobjMenuButton.position = CGPointMake(lobjMenuButton.contentSize.width * 0.50f,
                                              self.structWorldRect.size.height -(lobjMenuButton.contentSize.height * 0.50f));
        
        [lobjMenuButton setTarget:self
                         selector:@selector(menuButtonPressed:)];
        
        [self.objGamePlayScene.objGamePlayLayer addChild:lobjMenuButton
                                                       z:100];
    }
    
    CCButton* lobjChatSidePanelToggleButton = nil;
    //chat button
    {
        CCSpriteFrame* lobjSpriteFrame = [[CCSpriteFrameCache
                                           sharedSpriteFrameCache]
                                          spriteFrameByName:[self frameNameFromName:@"ChatBTN84x84.png"]];
        
        lobjChatSidePanelToggleButton = [[CCButton alloc]initWithTitle:@""
                                                           spriteFrame:lobjSpriteFrame];
        
        lobjChatSidePanelToggleButton.label.color = [CCColor colorWithUIColor:[UIColor blackColor]];
        
        
        float lfXPosition = self.structWorldRect.size.width - (lobjChatSidePanelToggleButton.contentSize.width * 0.50f * lobjChatSidePanelToggleButton.scale) - 5.0f;
        
        lobjChatSidePanelToggleButton.position = CGPointMake(lfXPosition,
                                                             self.structWorldRect.size.height -(lobjChatSidePanelToggleButton.contentSize.height * 0.50f * lobjChatSidePanelToggleButton.scale));
        
        [lobjChatSidePanelToggleButton setTarget:self
                                        selector:@selector(showChatPanel)];
        
        [self.objGamePlayScene.objGamePlayLayer addChild:lobjChatSidePanelToggleButton
                                                       z:100
                                                    name:@"MessagePanelButton"];
        
    }
    
    //friendsbutton
    {
        CCSpriteFrame* lobjSpriteFrame = [[CCSpriteFrameCache
                                           sharedSpriteFrameCache]
                                          spriteFrameByName:[self frameNameFromName:@"FriendsList84x84.png"]];
        
        
        CCButton* lobjFriendsToggleButton = [[CCButton alloc]initWithTitle:@""
                                                               spriteFrame:lobjSpriteFrame];
        
        lobjFriendsToggleButton.label.color = [CCColor colorWithUIColor:[UIColor blackColor]];
        
        
        CGPoint lstructChatBtnPos = lobjChatSidePanelToggleButton.position;
        
        
        float lfXPosition = lstructChatBtnPos.x - (lobjChatSidePanelToggleButton.contentSize.width * 0.50f * lobjChatSidePanelToggleButton.scale) - 25.0f;
        
        
        
        lobjFriendsToggleButton.position = CGPointMake(lfXPosition, lstructChatBtnPos.y);
        
        [lobjFriendsToggleButton setTarget:self
                                  selector:@selector(friendsListButtonPressed)];
        
        [self.objGamePlayScene.objGamePlayLayer addChild:lobjFriendsToggleButton
                                                       z:100
                                                    name:@"FriendsListButton"];
        
        
    }
    
    
    //bomb button
    {
        CCSpriteFrame* lobjSpriteFrame = [[CCSpriteFrameCache
                                           sharedSpriteFrameCache]
                                          spriteFrameByName:[self frameNameFromName:@"Bomb00.png"]];
        
        CCButton* lobjBombButton = [[CCButton alloc]initWithTitle:@""
                                                      spriteFrame:lobjSpriteFrame];
        
        lobjBombButton.label.color = [CCColor colorWithUIColor:[UIColor blackColor]];
        
        
        float lfXPosition = self.structWorldRect.size.width * 0.50f;
        
        float lfYPosition = self.structWorldRect.size.height * 0.50f;
        
        //        - (lobjBombButton.contentSize.width * 0.50f * lobjBombButton.scale) - 5.0f;
        
        //        float lfYpos =  self.structWorldRect.size.height -(lobjBombButton.contentSize.height * 0.50f * lobjBombButton.scale)
        
        lobjBombButton.position = CGPointMake(lfXPosition,
                                              lfYPosition);
        
        [lobjBombButton setTarget:self
                         selector:@selector(bombButtonPressed)];
        
        //        [self.objGamePlayScene.objGamePlayLayer addChild:lobjBombButton
        //                                                       z:100
        //                                                    name:@"BombButton"];
        
    }
    
    
    //[self addChatMessageDisplayUI];
    
}



//---------------------------------------------------------------------------------
#pragma mark - add and remove sprites
//---------------------------------------------------------------------------------

- (void)addPlayer
{
    NSString* lstrBGImageName = [self frameNameFromName:@"rocket1.png"];
    CCSprite* lobjPlayerSprite = [CCSprite spriteWithImageNamed:lstrBGImageName];
    
    //[CCSprite spriteWithImageNamed:];
    
    CGSize lstructVWSize = self.structWorldRect.size;
    [lobjPlayerSprite setPosition:CGPointMake(lstructVWSize.width * 0.50f,lstructVWSize.height * 0.25f)];
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //lobjBGSprite.scale = 1.25f;
    }
    
    //    [self.objGamePlayScene.objGamePlayLayer addChild:lobjPlayerSprite
    //                                                   z:Z_ORDER_PLAYERS];
    
    if(self.objGamePlayScene.objPhysicsWorld)
    {
        lobjPlayerSprite.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, lobjPlayerSprite.contentSize} cornerRadius:0]; // 1
        lobjPlayerSprite.physicsBody.collisionGroup = @"playerGroup"; // 2
        [self.objGamePlayScene.objPhysicsWorld addChild:lobjPlayerSprite
                                                      z:Z_ORDER_PLAYERS];
        

    }
    
    
    
}


- (void)addBackground
{
    
    {
        NSString* lstrBGImageName = [self frameNameFromName:@"BG.png"];
        CCSprite* lobjBGSprite = [CCSprite spriteWithImageNamed:lstrBGImageName];
                 
        //[CCSprite spriteWithImageNamed:];
        {
            CGSize lstructVWSize = self.structWorldRect.size;
            [lobjBGSprite setPosition:CGPointMake(lstructVWSize.width * 0.50f,lstructVWSize.height * 0.50f)];
            
            if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                //lobjBGSprite.scale = 1.25f;
            }
            
            [self.objGamePlayScene.objGamePlayLayer addChild:lobjBGSprite
                                                           z:Z_ORDER_BACKGROUND];
            
            
            //        [self addSpriteForId:10
            //                    position:CGPointMake(130, 130)
            //                     heading:CGPointMake(-1, 0)
            //                    maxSpeed:0];
        }
    }
    
}


- (void)addGameEntitySprite:(GameEntitySprite*)lobjGameEntitySprite
{
    if([CCDirector sharedDirector])
    {
        if (lobjGameEntitySprite)
        {
            if (self.dictIdToSprites == nil)
            {
                NSMutableDictionary* lobjDictIdToSprites = [NSMutableDictionary dictionaryWithCapacity:30];
                {
                    self.dictIdToSprites = lobjDictIdToSprites;
                }
            }
            
            [self.dictIdToSprites setObject:lobjGameEntitySprite
                                     forKey:[NSNumber numberWithInteger:lobjGameEntitySprite.intId]];
            
        }
        else
        {
            NSLog(@"Error: GameEntity nil");
        }
    }
}


- (void)removeSpriteForId:(NSInteger)lintCharacterId
{
    GameEntitySprite* lobjCharacterSprite = [self.dictIdToSprites objectForKey:[NSNumber numberWithInteger:lintCharacterId]];
    
    if(lobjCharacterSprite != nil)
    {
        [lobjCharacterSprite removeFromParentAndCleanup:YES];
    }
    
    [self.dictIdToSprites removeObjectForKey:[NSNumber numberWithInteger:lintCharacterId]];
    
}


- (void)removeSeatButtonForId:(NSInteger)lintSeatId
{
    [[self.objGamePlayScene.objGamePlayLayer
      getChildByName:[NSString stringWithFormat:@"Seat:%ld",(long)lintSeatId]
      recursively:NO] removeFromParentAndCleanup:YES];
}

- (void)animationCallbackForId:(NSInteger)lintId
                 animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
{
    GAME_QUEUE_ASYNC(
                     [self.objGameWorld animationStoppedForId:lintId
                                                animationType:lenumAnimationTypeIdentifier];
                     );
}

- (NSString*)addhdSuffixForImageName:(NSString*)lstrName
{
    NSString* lstrNameToReturn = nil;
    
    if (lstrName)
    {
        NSString* lstrExtension = [lstrName pathExtension];
        lstrNameToReturn = [lstrName stringByDeletingPathExtension];
        
        lstrNameToReturn = [lstrNameToReturn stringByAppendingString:@"-hd"];
        
        lstrNameToReturn = [lstrNameToReturn stringByAppendingPathExtension:lstrExtension];
    }
    else
    {
        SLog(@"ERROR : name given is nil");
    }
    
    return lstrNameToReturn;
    
}

- (NSString*)frameNameFromName:(NSString*)lstrName
{
    NSString* lstrNameToReturn = nil;
    
    if (lstrName)
    {
        NSString* lstrExtension = [lstrName pathExtension];
        lstrNameToReturn = [lstrName stringByDeletingPathExtension];
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            if([CCDirector sharedDirector].contentScaleFactor == 2 ||
               [CCDirector sharedDirector].contentScaleFactor == 3)
            {
                lstrNameToReturn = [lstrNameToReturn stringByAppendingString:@"-ipadhd"];
            }
            else
            {
                lstrNameToReturn = [lstrNameToReturn stringByAppendingString:@"-ipad"];
            }
        }
        else
        {
 //           if([CCDirector sharedDirector].contentScaleFactor == 3)
 //           {
 //               lstrNameToReturn = [lstrNameToReturn stringByAppendingString:@"3x-hd"];
                
 //           }
//            else
            {
                lstrNameToReturn = [lstrNameToReturn stringByAppendingString:@"-hd"];
            }
        }
        
        lstrNameToReturn = [lstrNameToReturn stringByAppendingPathExtension:lstrExtension];
    }
    else
    {
        NSLog(@"ERROR : name given is nil");
        
        lstrNameToReturn = nil;
    }
    
    return lstrNameToReturn;
}

- (CCSpriteFrame*)spriteFrameForSpriteName:(NSString*)lstrSpriteName
{
    lstrSpriteName = [self frameNameFromName:lstrSpriteName];
    
    CCSpriteFrame* lobjSpriteFrame = [[CCSpriteFrameCache
                                       sharedSpriteFrameCache]
                                      spriteFrameByName:lstrSpriteName];
    
    
    return lobjSpriteFrame;
}


//-------------------------------------------------------------------------------
#pragma mark - Utility Methods
//-------------------------------------------------------------------------------

- (CGSize)setSpriteFrame:(NSString*)lstrSpriteFrameName
                   forId:(NSInteger)lintId
{
    CGSize lstructSize;
    
    GameEntitySprite* lobjGameEntitySprite = [self.dictIdToSprites objectForKey:[NSNumber numberWithInteger:lintId]];
    
    if (lobjGameEntitySprite)
    {
        lstructSize = lobjGameEntitySprite.contentSize;
        
        CCSpriteFrame* lobjSpriteFrame = [self spriteFrameForSpriteName:lstrSpriteFrameName];
        
        if(!lobjSpriteFrame)
        {
            
            lobjSpriteFrame = [self spriteFrameForSpriteName:@"crash.png"];
        }
        else
        {
            //DO NOTHING
        }
        
        [lobjGameEntitySprite setSpriteFrame:lobjSpriteFrame];
    }
    else
    {
        SLog(@"ERROR: Requested Sprite for animation not present");
    }
    
    return lstructSize;
}


- (CGSize)addSpriteForId:(NSInteger)lintId
                position:(CGPoint)lstructPosition
                 heading:(CGPoint)lstructHeading
                maxSpeed:(float)lfloatMaxSpeed
{
    CGSize lstructSizeToReturn = CGSizeZero;
    if(0 == lstructPosition.x && lstructPosition.y == 0)
        return CGSizeZero;
    
    NSString* lstrFrameName = [self frameNameFromName:@"avatar112x112_01.png"];
    
    GameEntitySprite* lobjSprite = [[GameEntitySprite alloc]initWithVisualWorld:self
                                                                         withId:10
                                                                      framename:lstrFrameName
                                                                       position:CGPointMake(130.0f, 130.0f)];
    
    
    
    lstructSizeToReturn = lobjSprite.contentSize;
    
    
    [self.objGamePlayScene.objGamePlayLayer addChild:lobjSprite
                                                   z:Z_ORDER_PLAYERS];
    
    [lobjSprite playAnimation:MoleLaughAnimationTypeIdentifier
                   actionType:RepeatingActionType];
    
    return lstructSizeToReturn;
    
}



//--------------------------------------------------------------------------------
#pragma mark - Add images method
//--------------------------------------------------------------------------------




- (CGSize)addSpriteForId:(NSInteger)lintId
    entityTypeIdentifier:(EntityTypeIdentifier)lenumEntityTypeIdentifier
                position:(CGPoint)lstructPosition
                 heading:(CGPoint)lstructHeading
{
    if(lstructPosition.x == 0 && lstructPosition.y == 0)
        return CGSizeZero;
    
    GameEntitySprite* lobjSprite = nil;
    
    CGSize lstructSizeToReturn = CGSizeZero;
    
    if([CCDirector sharedDirector])
    {
        switch (lenumEntityTypeIdentifier)
        {
            case WinVisualEntityTypeIdentifier:
            {
                //                lobjSprite.position = lstructPosition;
                //
                //                lobjSprite = [[WinVisualSprite alloc]initWithVisualWorld:self
                //                                                                  withId:lintId
                //                                                               framename:[self frameNameFromName:@"win140x140.png"]
                //                                                                    position:lstructPosition];
                
                CCSpriteFrame* lobjSpriteFrame = [CCSpriteFrame frameWithImageNamed:@"win160x150-hd.png"];
                
                CCSprite* lobjBGSprite = [CCSprite spriteWithSpriteFrame:lobjSpriteFrame];
                
                lobjBGSprite.position = lstructPosition;
                
                if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    lobjBGSprite.scale = 2.0f;
                }
                
                
                lstructSizeToReturn = lobjBGSprite.contentSize;
                [self.objGamePlayScene.objGamePlayLayer addChild:lobjBGSprite
                                                               z:Z_ORDER_PLAYERS - 1];
                
                
                
                break;
            }
                
            default:
                break;
        }
    }
    
    return lstructSizeToReturn;
}

//-----------------------------------------------------
#pragma mark - animation
//-----------------------------------------------------

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
                forId:(NSInteger)lintId

{
    GameEntitySprite* lobjGameEntitySprite = [self.dictIdToSprites objectForKey:[NSNumber numberWithInteger:lintId]];
    
    if (lobjGameEntitySprite)
    {
        [lobjGameEntitySprite playAnimation:lenumAnimationTypeIdentifier
                                 actionType:lenumActionType];
    }
    else
    {
        SLog(@"ERROR: Requested Sprite for animation not present");
    }
}

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
             duration:(float)lfloatDuration
                forId:(NSInteger)lintId
{
    GameEntitySprite* lobjGameEntitySprite = [self.dictIdToSprites objectForKey:[NSNumber numberWithInteger:lintId]];
    
    if (lobjGameEntitySprite)
    {
        [lobjGameEntitySprite playAnimation:lenumAnimationTypeIdentifier
                                 actionType:lenumActionType
                                   duration:lfloatDuration];
    }
    else
    {
        SLog(@"ERROR: Requested Sprite for animation not present");
    }
}

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
             position:(CGPoint)lstructTargetPoint
             duration:(float)lfloatDuration
                forId:(NSInteger)lintId
{
    GameEntitySprite* lobjGameEntitySprite = [self.dictIdToSprites objectForKey:[NSNumber numberWithInteger:lintId]];
    
    if (lobjGameEntitySprite)
    {
        
        
        [lobjGameEntitySprite playAnimation:lenumAnimationTypeIdentifier
                                 actionType:lenumActionType
                                   position:lstructTargetPoint
                                   duration:lfloatDuration];
    }
    else
    {
        SLog(@"ERROR: Requested Sprite for animation not present");
    }
}



- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
                scale:(float)lfloatScaleFactor
             position:(CGPoint)lstructTargetPoint
           jumpHeight:(float)lfloatJumpHeight
             duration:(float)lfloatDuration
                forId:(NSInteger)lintID
{
    GameEntitySprite* lobjGES = [self.dictIdToSprites objectForKey:[NSNumber numberWithInteger:lintID]];
    
    if(lobjGES)
    {
        [lobjGES playAnimation:lenumAnimationTypeIdentifier
                    actionType:lenumActionType
                         scale:lfloatScaleFactor
                      position:lstructTargetPoint
                    jumpHeight:lfloatJumpHeight
                      duration:lfloatDuration];
    }
    else
    {
        SLog(@"ERROR: GameEntitySprite is nil");
    }
}


//-----------------------------------------------------
#pragma mark - cleanup
//-----------------------------------------------------


- (void)cleanUp
{
    GameWorld* lobjGW = self.objGameWorld;
    
    GAME_QUEUE_ASYNC
    (
     // [lobjGW cleanup];
     
     VISUAL_QUEUE_ASYNC(
                        
                        self.objVWdelegate = self.delegate;
                        [self.objGamePlayScene.objGamePlayLayer removeFromParentAndCleanup:YES];
                        
                        self.strLevelFileName = nil;
                        self.structWorldRect = CGRectMake(0, 0, 0, 0);
                        [self.objGamePlayScene removeFromParentAndCleanup:YES];
                        self.objGamePlayScene = nil;
                        self.dictIdToSprites = nil;
                        self.dictIdToBetTimer = nil;
                        
                        
                        self.objDisplayLink = nil;
                        self.arrayTableCommonCards = nil;
                        
                        self.fLastTimeStamp = 0.0f;
                        self.objTimeProgressDrawNode = nil;
                        
                        self.objMainPotTotalLabel = nil;
                        
                        self.objHandRankLabel = nil;
                        self.objHandRankBase = nil;
                        
                        self.objShowDownWinBase = nil;
                        self.objShowDownWinLabel = nil;
                        self.objGameWorld = nil;
                        //                        [[AudioManager sharedInstance] stopBgMusicAndAllEffects];
                        //                        [[AudioManager sharedInstance] unloadAllSounds];
                        //                        [self.objVWdelegate cleanUpComplete];
                        [self pause];
                        ););
    
    
    // Purge all managers / caches
    //    [CCAnimationCache purgeSharedAnimationCache];
    //    [CCSpriteFrameCache purgeSharedSpriteFrameCache];
    //    [CCTextureCache purgeSharedTextureCache];
    //    [[CCFileUtils sharedFileUtils] purgeCachedEntries];
    
}


//-----------------------------------------------------
#pragma mark - touch methods
//-----------------------------------------------------


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SLog(@"touch began");
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    SLog(@"touch moved");
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    SLog(@"touch ended");
}


//-----------------------------------------------------
#pragma mark - Update
//-----------------------------------------------------


- (void)mainLoop:(id)sender
{
    [super mainLoop:sender];
    
    CADisplayLink* lobjDisplayLink = (CADisplayLink*)sender;
    
    static CFTimeInterval ltimeStampLast = 0;
    
    
    if(lobjDisplayLink != self.objDisplayLink)
    {
        self.objDisplayLink = [[CADisplayLink alloc]init];
        ltimeStampLast = lobjDisplayLink.timestamp;
    }
    
    
    float lfDeltaTime = lobjDisplayLink.timestamp - ltimeStampLast;
    
    if([self runningScene] == nil)
    {
        //        GamePlayScene* lobjSCENE = [GamePlayScene scene];
        //        self.objGamePlayScene = lobjSCENE;
        //        [self pushScene:lobjSCENE];
        SLog(@"Director->%@  running scene->%@",self,_scenesStack);
        
        
    }
    
    //    glPushGroupMarkerEXT(0, "Draw Spaceship");
    ////    glBindTexture(GL_TEXTURE_2D, _spaceshipTexture);
    ////    glUseProgram(_diffuseShading);
    ////    glBindVertexArrayOES(_spaceshipMesh);
    //    glDrawElements(GL_TRIANGLE_STRIP, 256, GL_UNSIGNED_SHORT, 0);
    //    glPopGroupMarkerEXT();
    
    
    ltimeStampLast = lobjDisplayLink.timestamp;
    
}


//-----------------------------------------------------
@end
//-----------------------------------------------------

