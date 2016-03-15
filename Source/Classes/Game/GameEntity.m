//
//  GameEntity.m
//  TripleJackPokerGame
//
//  Created by Udit on 2/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
//---------------------------------------------------------------------------------
#pragma mark - Project Imports
//---------------------------------------------------------------------------------

#import "GameEntity.h"
#import "GameWorld.h"
#import "TypeDefs.h"
#import "QueueManager.h"
#import "VisualWorld.h"

//---------------------------------------------------------------------------------
#pragma mark - GlobalIDCounter
//---------------------------------------------------------------------------------

static NSInteger intCurrentId = 0;

//---------------------------------------------------------------------------------
#pragma mark - Private
//---------------------------------------------------------------------------------

@interface GameEntity()

@property (nonatomic, assign) NSUInteger                intId;
@property (nonatomic, weak)   GameWorld*                objGameWorld;
@property (nonatomic, assign) EntityTypeIdentifier      enumEntityTypeIdentifier;
@property (nonatomic, assign) CGPoint                   structPosition;
@property(nonatomic, strong)  NSMutableDictionary*      dictIdToGameEntity;


//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
#pragma mark - Implemenattion
//---------------------------------------------------------------------------------

@implementation GameEntity

//---------------------------------------------------------------------------------
#pragma mark - Initialization
//---------------------------------------------------------------------------------

- (id)initWithGameWorld:(GameWorld*)lobjGameWorld
         enumIdentifier:(EntityTypeIdentifier)lenumEntityTypeIdentifier
{
    self = [super init];
    
    if(self)
    {
        self.objGameWorld = lobjGameWorld;
        
        // This provides every entity object a unique Id
        self.intId = intCurrentId++;
        
        // This enum will control what type of entity we have
        self.enumEntityTypeIdentifier = lenumEntityTypeIdentifier;
        
    }
    return self;
}

- (id)initWithGameWorld:(GameWorld*)lobjGameWorld
         enumIdentifier:(EntityTypeIdentifier)lenumEntityTypeIdentifier
               position:(CGPoint)lstructPosition
{
    self = [super init];
    
    if(self)
    {
        self.objGameWorld = lobjGameWorld;
        
        // This provides every entity object a unique Id
        self.intId = intCurrentId++;
        
        // This enum will control what type of entity we have
        self.enumEntityTypeIdentifier = lenumEntityTypeIdentifier;
        
        self.structPosition = lstructPosition;
    }
    return self;
}


//---------------------------------------------------------------------------------
#pragma mark - MethodsToBeOverridden
//---------------------------------------------------------------------------------

- (void)update:(float)lfloatDeltaTime
{
}

- (void)addBody
{
    // To be overidden by subclasses
}

- (void)removeBody
{
    
}

- (void)addSprite
{
    // To be overidden by subclasses
}

- (void)addToGame
{
    
    // This method needs to be called after init
    VISUAL_QUEUE_ASYNC([self addSprite];
                       GAME_QUEUE_ASYNC(
                                        [self.objGameWorld addGameEntity:self];
                                        [self setupForGame];););
    
    
}

- (void)setupForGame
{
    // Subclasses should always call super
    // This method will be called when all three worlds
    // are ready for this entity
    
//    [self.objGameWorld entityReadyForUse:self];
    
}


- (void)removeSprite
{
    VisualWorld* lobjVisualWorld = self.objGameWorld.objVisualWorld;
    
    VISUAL_QUEUE_ASYNC(
                       [lobjVisualWorld removeSpriteForId:self.intId];
                       );
}


//---------------------------------------------------------------------------------
#pragma mark - UtilityMethods
//---------------------------------------------------------------------------------

- (void)debugDraw:(NSValue*)lptrGLESDebugDraw
{
    // Do Nothing
}

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------