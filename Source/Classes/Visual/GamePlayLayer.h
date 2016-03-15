//
//  GamePlayLayer.h
//  TripleJackPokerGame
//
//  Created by Udit on 12/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
//------------------------------------------------------
#pragma project imports
//------------------------------------------------------

#import "CCNodeColor.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Level;
@class Dot;

//------------------------------------------------------
#pragma interface
//------------------------------------------------------

@interface GamePlayLayer : CCNodeColor

- (void)setUpGame;

@property(nonatomic, assign, readonly) ccColor4F              structCommonDotColor;
@property(nonatomic, strong, readonly) Level*                 objLevel;

//------------------------------------------------------
@end
//------------------------------------------------------