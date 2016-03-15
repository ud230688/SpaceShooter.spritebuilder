//
//  GameWorld.h
//  SpaceShooter
//
//  Created by Udit AJMERA on 10/03/16.
//  Copyright © 2016 Apportable. All rights reserved.
//
//------------------------------------------------------
#pragma mark - SDK Imports
//------------------------------------------------------

#import <Foundation/Foundation.h>

//------------------------------------------------------
#pragma mark - Project Imports
//------------------------------------------------------

#import "TypeDefs.h"

//------------------------------------------------------
#pragma mark - Forward class declaration
//------------------------------------------------------

@class VisualWorld;
@class GameEntity;

//------------------------------------------------------
#pragma mark - Interface
//------------------------------------------------------

@interface GameWorld : NSObject

@property(nonatomic, weak, readonly)VisualWorld*   objVisualWorld;


- (id)initWithVisualWorld:(VisualWorld*)lobjVW
                worldRect:(CGRect)lstructWorldSize;

- (void)setUpComplete;
- (void)addGameEntity:(GameEntity*)lobjGameEntity;
- (void)removeGameEntity:(GameEntity*)lobjGameEntity;

- (void)animationStoppedForId:(NSInteger)lintId
                animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier;


//------------------------------------------------------
@end
//------------------------------------------------------