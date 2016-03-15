//
//  GameEntityAnimation.h
//  TripleJackPokerGame
//
//  Created by Udit on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
//---------------------------------------------------------------------------------
#pragma mark - ProjectImports
//---------------------------------------------------------------------------------

#import "Typedefs.h"
#import "cocos2d.h"

//---------------------------------------------------------------------------------
#pragma mark - ForwardDeclaration
//---------------------------------------------------------------------------------

@class GameEntityAnimation;

//---------------------------------------------------------------------------------
#pragma mark - Protocol Declaration
//---------------------------------------------------------------------------------

@protocol GameEntityAnimationDelegate <NSObject>

//---------------------------------------------------------------------------------
#pragma mark - Protocol Methods
//---------------------------------------------------------------------------------

- (void)animationEndCallBackForAction:(GameEntityAnimation*)lobjActionEnded;

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
#pragma mark - Interface
//---------------------------------------------------------------------------------

@interface GameEntityAnimation : NSObject

//---------------------------------------------------------------------------------
#pragma mark - Properties
//---------------------------------------------------------------------------------

@property (nonatomic,         readonly) CCAction*                    objAction;
@property (nonatomic, assign ,readonly) ActionType                   enumActionType;
@property (nonatomic, assign ,readonly) AnimationTypeIdentifier      enumAnimationTypeIdentifier;
@property (nonatomic, assign ,readonly) NSInteger                    intActionTag;
@property (nonatomic, strong ,readonly) CCAnimation*                 objAnimation;

//---------------------------------------------------------------------------------
#pragma mark - Init
//---------------------------------------------------------------------------------

- (id)initWithAction:(CCAction*)lobjAction
           actionTag:(NSInteger)lintTag
          actionType:(ActionType)lenumActionType
       animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
            delegate:(id<GameEntityAnimationDelegate>)lobjDelegate;

//---------------------------------------------------------------------------------
#pragma mark - Class Methods
//---------------------------------------------------------------------------------

+ (CCAnimation*)animationForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                             targetSprite:(CCSprite*)lobjSprite;

+ (id)actionWithAction:(CCAction*)lobjAction
             actionTag:(NSInteger)lintTag
            actionType:(ActionType)lenumActionType
         animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
              delegate:(id<GameEntityAnimationDelegate>)lobjDelegate;

+ (id)actionWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                    actionTag:(NSInteger)lintTag
                   actionType:(ActionType)lenumActionType
                 targetSprite:(CCSprite*)lobjSprite
                     delegate:(id<GameEntityAnimationDelegate>)lobjDelegate;

+ (id)actionWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                    actionTag:(NSInteger)lintTag
                   actionType:(ActionType)lenumActionType
                 targetSprite:(CCSprite*)lobjSprite
                     delegate:(id<GameEntityAnimationDelegate>)lobjDelegate
            animationDuration:(float)lfloatAnimationDuration;

+ (id)actionWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
            animStartDuration:(float)lfloatStartDuration
            animTotalDuration:(float)lfloatTotalDuration
                    actionTag:(NSInteger)lintTag
                   actionType:(ActionType)lenumActionType
                 targetSprite:(CCSprite*)lobjSprite
                     delegate:(id<GameEntityAnimationDelegate>)lobjDelegate;

+ (id)actionWithDelayWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                             actionTag:(NSInteger)lintTag
                            actionType:(ActionType)lenumActionType
                          targetSprite:(CCSprite*)lobjSprite
                                 speed:(float)lfloatSpeed
                              delegate:(id<GameEntityAnimationDelegate>)lobjDelegate;

+ (id)speedActionForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                        actionTag:(NSInteger)lintActionTag
                       actionType:(ActionType)lenumActionType
                     targetSprite:(CCSprite*)lobjSprite
                        withSpeed:(float)lfloatSpeed;



+ (CCAction*)actionForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                       targetSprite:(CCSprite*)lobjSprite
                         actionType:(ActionType)lenumActionType;

//---------------------------------------------------------------------------------
#pragma mark - Instance Methods
//---------------------------------------------------------------------------------

- (void)interruptNonRepeatingActionCallBack;
- (void)setActionSpeed:(float)lfloatSpeed;
- (void)runAnimationOnTarget:(CCSprite*)lobjSprite;

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------
