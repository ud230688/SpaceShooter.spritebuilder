//
//  GameEntity.h
//  TripleJackPokerGame
//
//  Created by Udit on 2/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
//------------------------------------------------------
#pragma mark - SDK Imports
//------------------------------------------------------

#import <Foundation/Foundation.h>
#import "TypeDefs.h"

//------------------------------------------------------
#pragma mark - Forward class declaration
//------------------------------------------------------

@class GameWorld;

//------------------------------------------------------
#pragma mark - Interface
//------------------------------------------------------

@interface GameEntity : NSObject

@property (nonatomic, assign, readonly) NSUInteger            intId;
@property (nonatomic, weak, readonly)   GameWorld*            objGameWorld;
@property (nonatomic, assign, readonly) EntityTypeIdentifier  enumEntityTypeIdentifier;
@property (nonatomic, assign, readonly) CGPoint               structPosition;

- (id)initWithGameWorld:(GameWorld*)lobjGameWorld
         enumIdentifier:(EntityTypeIdentifier)lenumEntityTypeIdentifier;

- (id)initWithGameWorld:(GameWorld*)lobjGameWorld
         enumIdentifier:(EntityTypeIdentifier)lenumEntityTypeIdentifier
               position:(CGPoint)lstructPosition;

//------------------------------------------------------
#pragma mark - MethodsToBeOverridden
//------------------------------------------------------

- (void)update:(float)lfloatDeltaTime;
- (void)addBody;
- (void)addSprite;
- (void)addToGame;
- (void)setupForGame;
- (void)removeBody;
- (void)removeSprite;



//------------------------------------------------------
@end
//------------------------------------------------------