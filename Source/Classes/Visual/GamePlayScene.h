//
//  GamePlayScene.h
//  TripleJackPokerGame
//
//  Created by Udit on 12/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
// -----------------------------------------------------------------------
#pragma mark - cocos2D Imports
// -----------------------------------------------------------------------

#import "CCScene.h"

// -----------------------------------------------------------------------
#pragma mark - Forward class declaration
// -----------------------------------------------------------------------

@class VisualWorld;
@class GamePlayLayer;

// -----------------------------------------------------------------------
#pragma mark - Interface
// -----------------------------------------------------------------------

@interface GamePlayScene : CCScene<CCPhysicsCollisionDelegate>

@property(nonatomic, strong, readonly)GamePlayLayer*     objGamePlayLayer;
@property(nonatomic, strong) CCPhysicsNode*              objPhysicsWorld;

// -----------------------------------------------------------------------
#pragma mark - Instance methods
// -----------------------------------------------------------------------

+ (GamePlayScene *)scene;
- (id)initWithVisualWorld:(VisualWorld*)lobjVW
                resources:(NSArray*)larrayResources;

// -----------------------------------------------------------------------
@end
// -----------------------------------------------------------------------