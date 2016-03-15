//
//  GameWorld.m
//  SpaceShooter
//
//  Created by Udit AJMERA on 10/03/16.
//  Copyright © 2016 Apportable. All rights reserved.
//
//------------------------------------------------------
#pragma mark - Project Imports
//------------------------------------------------------

#import "GameWorld.h"
#import "GameEntity.h"

//------------------------------------------------------
#pragma mark - Forward class declaration
//------------------------------------------------------

@class VisualWorld;

//------------------------------------------------------
#pragma mark - Interface
//------------------------------------------------------

@interface  GameWorld()

@property(nonatomic, weak)VisualWorld*   objVisualWorld;
@property(nonatomic, assign)CGRect       structWorldRect;

@property(nonatomic, strong)NSMutableDictionary*        dictIdToGameEntity;


//------------------------------------------------------
@end
//------------------------------------------------------

//------------------------------------------------------
#pragma mark - Implementation
//------------------------------------------------------

@implementation GameWorld


- (id)initWithVisualWorld:(VisualWorld*)lobjVW
                worldRect:(CGRect)lstructWorldSize
{
    self = [super init];
    
    if(self)
    {
        self.objVisualWorld = lobjVW;

        self.structWorldRect = lstructWorldSize;
  
    }
    
    return self;
}


- (void)setUpComplete
{
    
}

//------------------------------------------------------
#pragma mark - Entity Related Methods
//------------------------------------------------------


- (void)addGameEntity:(GameEntity*)lobjGameEntity
{
    if (lobjGameEntity)
    {
        if (self.dictIdToGameEntity == nil)
        {
            self.dictIdToGameEntity = [NSMutableDictionary dictionaryWithCapacity:30];
        }
        
        [self.dictIdToGameEntity setObject:lobjGameEntity
                                    forKey:[NSNumber numberWithInteger:lobjGameEntity.intId]];
        
        switch (lobjGameEntity.enumEntityTypeIdentifier)
        {
            default:
            {
                
                break;
            }
        }
    }
    else
    {
        SLog(@"Error: GameEntity nil");
    }
}


- (void)removeGameEntity:(GameEntity*)lobjGameEntity
{
    if (lobjGameEntity)
    {
        switch (lobjGameEntity.enumEntityTypeIdentifier)
        {
            default:
            {
                if(lobjGameEntity.enumEntityTypeIdentifier == SeatButtonEntityTypeIdentifier)
                {
                    SLog(@"check");
                }
                
                [lobjGameEntity removeSprite];
                break;
            }
        }
        
        //        [[PDAudioEngine sharedEngine] removeSourceGroupIdForEntityId:lobjGameEntity.intId];
        
        [self.dictIdToGameEntity removeObjectForKey:[NSNumber numberWithInteger:lobjGameEntity.intId]];
        
        if([self.dictIdToGameEntity count] == 0)
        {
            
        }
        
    }
    else
    {
        SLog(@"Error: GameEntity nil");
    }
}

- (void)animationStoppedForId:(NSInteger)lintId
                animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
{
    if (lenumAnimationTypeIdentifier == BombDelayAnimationTypeIdentifier)
    {
        //        BombGameEntity* lobjBombGE =
        //        (BombGameEntity*)[self.dictIdToGameEntity objectForKey:[NSNumber numberWithInteger:lintId]];
        //
        //        [self removeGameEntity:lobjBombGE];
        
    }
    
}




//------------------------------------------------------
@end
//------------------------------------------------------