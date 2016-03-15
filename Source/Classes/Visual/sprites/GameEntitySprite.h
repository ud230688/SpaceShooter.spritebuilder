//
//  GameEntitySprite.h
//  TripleJackPokerGame
//
//  Created by Udit on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
//---------------------------------------------------------------------------------
#pragma mark - SDK import
//---------------------------------------------------------------------------------

#import "cocos2d.h"
#import "CCAnimation.h"
#import "TypeDefs.h"
#import "GameEntityAnimation.h"

//---------------------------------------------------------------------------------
#pragma mark - Forward class declaration
//---------------------------------------------------------------------------------

@class VisualWorld;

//---------------------------------------------------------------------------------
#pragma mark - interface
//---------------------------------------------------------------------------------

@interface GameEntitySprite : CCSprite<GameEntityAnimationDelegate>

//---------------------------------------------------------------------------------
#pragma mark - Properties
//---------------------------------------------------------------------------------

@property (nonatomic, assign, readonly) NSUInteger                     intId;
@property (nonatomic, weak, readonly)   VisualWorld             *objVisualWorld;
@property (nonatomic, readonly)         NSMutableArray          *arrayAnimations;
@property (nonatomic, assign)           CGPoint                 structHeading;

//---------------------------------------------------------------------------------
#pragma mark - InstanceMethods
//---------------------------------------------------------------------------------

- (id)initWithVisualWorld:(VisualWorld*)lobjVisualWorld
                   withId:(NSUInteger)lintId
                framename:(NSString*)lstrFramename
                 position:(CGPoint)lstructPoint;

- (id)initWithVisualWorld:(VisualWorld*)lobjVisualWorld
                   withId:(NSUInteger)lintId
                 position:(CGPoint)lstructPoint;

- (id)initWithVisualWorld:(VisualWorld*)lobjVisualWorld
                   withId:(NSUInteger)lintId
                framename:(NSString*)lstrFramename
                 position:(CGPoint)lstructPoint
                  heading:(CGPoint)lstructHeading;

//---------------------------------------------------------------------------------
#pragma mark - Instance Methods
//---------------------------------------------------------------------------------

- (void)fadeOutWithDuration:(float)lfloatDuration;

- (void)playBlinkingAnimation;
- (void)playBlinkingAnimationForPowerIcon;

- (void)stopBlinkingAnimation;

- (void)playOnFloorMoveVerticalAndRotateAnimationWithShift:(float)lfloatMoveShift;

- (void)playOnFloorMoveVerticalUpAndDownAnimation;
- (void)stopOnFloorMoveVerticalUpAndDownAnimation;

- (void)playDenyingAnimationForDuration:(float)lfloatDuration
                            repeatCount:(int)lintRepeatCount;

- (void)stopAnimationForIdentifier:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier;

- (BOOL)isAnimationCompleted;

- (void)scaleSpriteToSize:(float)lfloatScaleSize
                 duration:(float)lfloatDuration;

- (void)setActionSpeed:(float)lfloatActionSpeed
       forAnimationETI:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier;

//---------------------------------------------------------------------------------
#pragma mark - Methods To Be Overridden
//---------------------------------------------------------------------------------

- (void)loadAnimations;
- (void)rotateSpriteInDirectionOfHeading:(CGPoint)lstructHeading;

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType;

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
             duration:(float)lfloatDuration;

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
             position:(CGPoint)lstructTargetPoint
             duration:(float)lfloatDuration;

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
        startDuration:(float)lfloatStartDuration
        totalDuration:(float)lfloatTotalDuration;

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
                scale:(float)lfloatScaleFactor
             position:(CGPoint)lstructTargetPoint
           jumpHeight:(float)lfloatJumpHeight
             duration:(float)lfloatDuration;

- (void)runAnimation:(GameEntityAnimation*)lobjGameEntityAnimation;
- (void)animationEndCallBackForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier;

//---------------------------------------------------------------------------------
#pragma mark - update
//---------------------------------------------------------------------------------

- (void)updateHeading:(CGPoint)lstructHeading;
- (void)updatePosition:(CGPoint)lstructPosition;

//---------------------------------------------------------------------------------
#pragma mark - AnimationLoadingMethods
//---------------------------------------------------------------------------------

- (void)loadAnimationsFromPlist:(NSString*)lstrAnimationPlistName;

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------