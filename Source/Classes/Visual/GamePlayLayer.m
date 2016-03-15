//
//  GamePlayLayer.m
//  TripleJackPokerGame
//
//  Created by Udit on 12/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
//--------------------------------------------------------------------------
#pragma Frameworks Imports
//--------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import "CCDrawingPrimitives.h"

//--------------------------------------------------------------------------
#pragma project imports
//--------------------------------------------------------------------------

#import "GamePlayLayer.h"

//--------------------------------------------------------------------------
#pragma interface
//--------------------------------------------------------------------------

@interface GamePlayLayer()<CCPhysicsCollisionDelegate>
{
    
    CCPhysicsNode * _physicsWorld;
}



//--------------------------------------------------------------------------
@end
//--------------------------------------------------------------------------


//--------------------------------------------------------------------------
#pragma implementation
//--------------------------------------------------------------------------


@implementation GamePlayLayer



- (void)setUpGame
{
    self.userInteractionEnabled = YES;

    
        
    //[self addLabelUI];
    
}

- (void)addLabelUI
{
    CGSize lstructWinSize = [CCDirector sharedDirector].viewSize;
    
    {
        CCLabelTTF* lobjStarScoreLabel =
        [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%i",0]
                                 fontName:@"Helvetica"
                                 fontSize:18];
        
        lobjStarScoreLabel.color = [CCColor colorWithRed:1.0 green:0.5 blue:0.0];
        
        [lobjStarScoreLabel setPosition:CGPointMake(lstructWinSize.width * 0.50f,
                                                    lstructWinSize.height - 20.0f)];
        [self addChild:lobjStarScoreLabel
                     z:4
                  name:@"CDV"];
    }
    
    {
        CCLabelTTF* lobjMovedCountLabel =
        [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%i",0]
                                 fontName:@"Helvetica"
                                 fontSize:20];
        
        lobjMovedCountLabel.color = [CCColor colorWithRed:252.0f/255.0f
                                                    green:209.0f/255.0f
                                                     blue:9.0f/255.0f];
        
        [lobjMovedCountLabel setPosition:CGPointMake(lstructWinSize.width - 40.0f,
                                                     lstructWinSize.height - 20.0f)];
        [self addChild:lobjMovedCountLabel
                     z:4
                  name:@"KM"];
    }
    
    
}


// -----------------------------------------------------------------------
#pragma mark - Touch Handler & Drawing
// -----------------------------------------------------------------------

- (BOOL)touchBegin:(CGPoint)lstructTouchPoint
{
    
    
    return YES;
}

- (void)touchBegan:(UITouch *)touch
         withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [self convertToNodeSpace:touchLocation];
    
    
    [self touchBegin:local];
    SLog(@"local->(%f,%f)",local.x,local.y);
}


- (void)touchMoved:(UITouch *)touch
         withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [self convertToNodeSpace:touchLocation];
    //SLog(@"local->(%f,%f)",local.x,local.y);
    
}


- (void)touchEnded:(UITouch *)touch
         withEvent:(UIEvent *)event
{
    //its need to be add score = lintDisappearCount
    
}


-(void)draw
{
}



@end
