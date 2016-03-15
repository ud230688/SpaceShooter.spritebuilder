//
//  GameEntityAnimation.m
//  TripleJackPokerGame
//
//  Created by Udit on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
//---------------------------------------------------------------------------------
#pragma mark - ProjectImports
//---------------------------------------------------------------------------------

#import "GameEntityAnimation.h"
#import "TypeIdentifierUtils.h"
#import "CCAnimation.h"
#import "CCAnimationCache.h"
#import "Typedefs.h"
#import "GameEntitySprite.h"

//---------------------------------------------------------------------------------
#pragma mark - Private Interface
//---------------------------------------------------------------------------------

@interface GameEntityAnimation()

//---------------------------------------------------------------------------------
#pragma mark - Private Properties
//---------------------------------------------------------------------------------

@property (nonatomic)           CCAction*                           objAction;
@property (nonatomic, assign)   ActionType                          enumActionType;
@property (nonatomic, assign)   AnimationTypeIdentifier             enumAnimationTypeIdentifier;
@property (nonatomic, assign)   NSInteger                           intActionTag;
@property (nonatomic, weak  )   id<GameEntityAnimationDelegate>     objDelegate;
@property (nonatomic, strong)   CCAnimation                         *objAnimation;

//---------------------------------------------------------------------------------
#pragma mark - Private Class Methods
//---------------------------------------------------------------------------------

+ (CCAction*)actionForAnimationName:(NSString*)lstrAnimationName
                         actionType:(ActionType)lenumActionType;

+ (CCAction*)actionForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                       targetSprite:(CCSprite*)lobjSprite
                         actionType:(ActionType)lenumActionType;

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
#pragma mark - Implementation
//---------------------------------------------------------------------------------

@implementation GameEntityAnimation

//---------------------------------------------------------------------------------
#pragma mark - Init
//---------------------------------------------------------------------------------

- (id)initWithAction:(CCAction*)lobjAction
           actionTag:(NSInteger)lintTag
          actionType:(ActionType)lenumActionType
       animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
            delegate:(id<GameEntityAnimationDelegate>)lobjDelegate
{
    self  = [super init];
    {
        self.enumAnimationTypeIdentifier = lenumAnimationTypeIdentifier;
        self.enumActionType = lenumActionType;
        self.objDelegate = lobjDelegate;
        self.objAnimation = nil;
        
        CCAction *lobjActionToRun = nil;
        
        if (lenumActionType == NonRepeatingActionType)
        {
            
            if([lobjAction isKindOfClass:[CCActionSpeed class]])
            {
                lobjActionToRun = lobjAction;
            }
            else
            {
                
                CCActionCallFunc *lobjActionEndCallBack = [CCActionCallFunc actionWithTarget:self
                                                                                    selector:@selector(actionEndCallBack)];
                
                lobjActionToRun = (CCAction*)[CCActionSequence actions:(id)lobjAction, lobjActionEndCallBack, nil];
                
            }
        }
        else if(lenumActionType == RepeatingActionType)
        {
            lobjActionToRun = lobjAction;
        }
        else
        {
            lobjActionToRun = nil;
            
            NSLog(@"ERROR : actionType must not be NoneActionType");
        }
        
        self.objAction = lobjActionToRun;
        
        self.intActionTag = lintTag;
    }
    
    return self;
}

//---------------------------------------------------------------------------------
#pragma mark - Class Methods
//---------------------------------------------------------------------------------

+ (id)actionWithDelayWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                             actionTag:(NSInteger)lintTag
                            actionType:(ActionType)lenumActionType
                          targetSprite:(CCSprite*)lobjSprite
                                 speed:(float)lfloatSpeed
                              delegate:(id<GameEntityAnimationDelegate>)lobjDelegate
{
    NSString* lstrClassName =  NSStringFromClass([lobjSprite class]);
    
    NSString *lstrAnimationTypeIdentifier = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lenumAnimationTypeIdentifier];
    
    NSString* lstrAnimationName = [lstrClassName stringByAppendingString:lstrAnimationTypeIdentifier];
    
    CCAnimation *lobjAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:lstrAnimationName];
    
    //    float lfNumberOfFrames = [[lobjAnimation frames] count];
    //    lobjAnimation.delayPerUnit = (lfloatSpeed / lfNumberOfFrames);
    
    CCAction *lobjAction = [CCActionAnimate actionWithAnimation:lobjAnimation];
    
    return [[self alloc] initWithAction:lobjAction
                              actionTag:lintTag
                             actionType:lenumActionType
                          animationType:lenumAnimationTypeIdentifier
                               delegate:lobjDelegate];
}

+ (id)actionWithAction:(CCAction*)lobjAction
             actionTag:(NSInteger)lintTag
            actionType:(ActionType)lenumActionType
         animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
              delegate:(id<GameEntityAnimationDelegate>)lobjDelegate
{
    return [[self alloc] initWithAction:lobjAction
                              actionTag:lintTag
                             actionType:lenumActionType
                          animationType:lenumAnimationTypeIdentifier
                               delegate:lobjDelegate];
}

+ (id)actionWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                    actionTag:(NSInteger)lintTag
                   actionType:(ActionType)lenumActionType
                 targetSprite:(CCSprite*)lobjSprite
                     delegate:(id<GameEntityAnimationDelegate>)lobjDelegate
{
    CCAction* lobjAction = [GameEntityAnimation actionForAnimationType:lenumAnimationTypeIdentifier
                                                          targetSprite:lobjSprite
                                                            actionType:lenumActionType];
    return [[self alloc] initWithAction:lobjAction
                              actionTag:lintTag
                             actionType:lenumActionType
                          animationType:lenumAnimationTypeIdentifier
                               delegate:lobjDelegate];
}

+ (id)actionWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                    actionTag:(NSInteger)lintTag
                   actionType:(ActionType)lenumActionType
                 targetSprite:(CCSprite*)lobjSprite
                     delegate:(id<GameEntityAnimationDelegate>)lobjDelegate
            animationDuration:(float)lfloatAnimationDuration
{
    CCAction* lobjAction = [GameEntityAnimation actionForAnimationType:lenumAnimationTypeIdentifier
                                                          targetSprite:lobjSprite
                                                            actionType:lenumActionType
                                                     animationDuration:lfloatAnimationDuration];
    
    return [[self alloc] initWithAction:lobjAction
                              actionTag:lintTag
                             actionType:lenumActionType
                          animationType:lenumAnimationTypeIdentifier
                               delegate:lobjDelegate];
}


+ (id)actionWithAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
            animStartDuration:(float)lfloatStartDuration
            animTotalDuration:(float)lfloatTotalDuration
                    actionTag:(NSInteger)lintTag
                   actionType:(ActionType)lenumActionType
                 targetSprite:(CCSprite*)lobjSprite
                     delegate:(id<GameEntityAnimationDelegate>)lobjDelegate
{
    CCAction* lobjAction = [GameEntityAnimation actionForAnimationType:lenumAnimationTypeIdentifier
                                                     animStartDuration:lfloatStartDuration
                                                     animTotalDuration:lfloatTotalDuration
                                                          targetSprite:lobjSprite
                                                            actionType:lenumActionType];
    return [[self alloc] initWithAction:lobjAction
                              actionTag:lintTag
                             actionType:lenumActionType
                          animationType:lenumAnimationTypeIdentifier
                               delegate:lobjDelegate];
}

+ (id)speedActionForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                        actionTag:(NSInteger)lintActionTag
                       actionType:(ActionType)lenumActionType
                     targetSprite:(CCSprite*)lobjSprite
                        withSpeed:(float)lfloatSpeed
{
    NSString* lstrClassName =  NSStringFromClass([lobjSprite class]);
    
    NSString *lstrAnimationTypeIdentifier = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lenumAnimationTypeIdentifier];
    
    NSString* lstrAnimationName = [lstrClassName stringByAppendingString:lstrAnimationTypeIdentifier];
    
    id lobjAction = [GameEntityAnimation actionForAnimationName:lstrAnimationName
                                                     actionType:lenumActionType];
    
    CCActionSpeed *lobjSpeedAction = nil;
    lobjSpeedAction = [CCActionSpeed actionWithAction:lobjAction
                                          speed:lfloatSpeed];
    
    
    
    return [[self alloc] initWithAction:lobjSpeedAction
                              actionTag:lintActionTag
                             actionType:lenumActionType
                          animationType:lenumAnimationTypeIdentifier
                               delegate:nil];
}

//---------------------------------------------------------------------------------
#pragma mark - Instance Methods
//---------------------------------------------------------------------------------

- (void)setActionSpeed:(float)lfloatSpeed
{
    CCActionSpeed *lobjSpeedAction =  (CCActionSpeed*)self.objAction;
    
    [lobjSpeedAction setSpeed:lfloatSpeed];
}

- (void)runAnimationOnTarget:(CCSprite*)lobjSprite
{
    if (self.intActionTag == TAG_FRAMES_ANIMATION)
    {
        CCAnimation *lobjCurrentAnimation = [GameEntityAnimation
                                             animationForAnimationType:self.enumAnimationTypeIdentifier
                                             targetSprite:lobjSprite];
        self.objAnimation = lobjCurrentAnimation;
    }
    
    if (self.objAction)
    {
        [lobjSprite runAction:self.objAction];
    }
    else
    {
        NSString* lstrAnimationIdentifier = [TypeIdentifierUtils stringForAnimationTypeIdentifier:self.enumAnimationTypeIdentifier];
        
        NSLog(@"ERROR: Action of Animation:%@ is nil for Sprite:%@", lstrAnimationIdentifier, lobjSprite);
    }
    
}

//---------------------------------------------------------------------------------
#pragma mark - animation Call Back Method
//---------------------------------------------------------------------------------

- (void)interruptNonRepeatingActionCallBack
{
    self.objAction = nil;
}

- (void)actionEndCallBack
{
    self.objAction = nil;
    
    if (self.objDelegate && [self.objDelegate respondsToSelector:@selector(animationEndCallBackForAction:)])
    {
        [self.objDelegate animationEndCallBackForAction:self];
    }
    else
    {
        NSLog(@"ERROR: Delegate is nil");
    }
}

//---------------------------------------------------------------------------------
#pragma mark - Private Class Methods
//---------------------------------------------------------------------------------

+ (CCAnimation*)animationForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                             targetSprite:(CCSprite*)lobjSprite
{
    NSString* lstrClassName =  NSStringFromClass([lobjSprite class]);
    
    NSString *lstrAnimationTypeIdentifier = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lenumAnimationTypeIdentifier];
    
    NSString* lstrAnimationName = [lstrClassName stringByAppendingString:lstrAnimationTypeIdentifier];
    
    return [[CCAnimationCache sharedAnimationCache] animationByName:lstrAnimationName];
}

+ (CCAction*)actionForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                       targetSprite:(CCSprite*)lobjSprite
                         actionType:(ActionType)lenumActionType

{
    NSString* lstrClassName =  NSStringFromClass([lobjSprite class]);
    
    NSString *lstrAnimationTypeIdentifier = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lenumAnimationTypeIdentifier];
    
    NSString* lstrAnimationName = [lstrClassName stringByAppendingString:lstrAnimationTypeIdentifier];
    return [GameEntityAnimation actionForAnimationName:lstrAnimationName
                                            actionType:lenumActionType];
    
}

+ (CCAction*)actionForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                       targetSprite:(CCSprite*)lobjSprite
                         actionType:(ActionType)lenumActionType
                  animationDuration:(float)lfloatAnimationDuration
{
    NSString* lstrClassName =  NSStringFromClass([lobjSprite class]);
    
    NSString *lstrAnimationTypeIdentifier = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lenumAnimationTypeIdentifier];
    
    NSString* lstrAnimationName = [lstrClassName stringByAppendingString:lstrAnimationTypeIdentifier];
    return [GameEntityAnimation actionForAnimationName:lstrAnimationName
                                            actionType:lenumActionType
                                     animationDuration:lfloatAnimationDuration];
    
}


+ (CCAction*)actionForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
                  animStartDuration:(float)lfloatStartDuration
                  animTotalDuration:(float)lfloatTotalDuration
                       targetSprite:(CCSprite*)lobjSprite
                         actionType:(ActionType)lenumActionType

{
    NSString* lstrClassName =  NSStringFromClass([lobjSprite class]);
    
    NSString *lstrAnimationTypeIdentifier = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lenumAnimationTypeIdentifier];
    
    NSString* lstrAnimationName = [lstrClassName stringByAppendingString:lstrAnimationTypeIdentifier];
    
    return [GameEntityAnimation actionForAnimationName:lstrAnimationName
                                     animStartDuration:lfloatStartDuration
                                     animTotalDuration:lfloatTotalDuration
                                            actionType:lenumActionType];
}

+ (CCAction*)actionForAnimationName:(NSString*)lstrAnimationName
                         actionType:(ActionType)lenumActionType
                  animationDuration:(float)lfloatAnimationDuration
{
    CCAction *lobjAction = nil;
    
    CCAnimation *lobjAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:lstrAnimationName];
    
    float lfAnimationFrameCount = [[lobjAnimation frames] count];
    [lobjAnimation setDelayPerUnit:(lfloatAnimationDuration/lfAnimationFrameCount)];
    
    if (lobjAnimation)
    {
        if (lenumActionType == RepeatingActionType)
        {
            lobjAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:lobjAnimation ]];
        }
        else
        {
            lobjAction = [CCActionAnimate actionWithAnimation:lobjAnimation];
        }
    }
    if (lobjAction == nil)
    {
        NSLog(@"lstrAnimationToPLay %@ is nil", lstrAnimationName);
    }
    return lobjAction;
}

+ (CCAction*)actionForAnimationName:(NSString*)lstrAnimationName
                         actionType:(ActionType)lenumActionType
{
    CCAction *lobjAction = nil;
    
    CCAnimation *lobjAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:lstrAnimationName];
    
    if (lobjAnimation)
    {
        if (lenumActionType == RepeatingActionType)
        {
            lobjAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:lobjAnimation ]];
        }
        else
        {
            lobjAction = [CCActionAnimate actionWithAnimation:lobjAnimation];
        }
    }
    if (lobjAction == nil)
    {
        NSLog(@"lstrAnimationToPLay %@ is nil", lstrAnimationName);
    }
    return lobjAction;
}


+ (CCAction*)actionForAnimationName:(NSString*)lstrAnimationName
                  animStartDuration:(float)lfloatStartDuration
                  animTotalDuration:(float)lfloatTotalDuration
                         actionType:(ActionType)lenumActionType
{
    CCAction *lobjAction = nil;
    
    CCAnimation *lobjAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:lstrAnimationName];
    
    CCAnimation *lobjAnimationCopy = nil;
    
    float lfloatDelayForPerUnit = 0.0;
    NSInteger lintAnimationCount = [lobjAnimation.frames count];
    
    if (lfloatStartDuration == 0.0)
    {
        lfloatDelayForPerUnit = lfloatTotalDuration/lintAnimationCount;
        
        lobjAnimationCopy = lobjAnimation;
    }
    else
    {
        lobjAnimationCopy = [lobjAnimation copy];
        
        float lfloatElapsedDuration = lfloatTotalDuration - lfloatStartDuration;
        
        lfloatDelayForPerUnit = lfloatElapsedDuration/lintAnimationCount;
        
        float lfloatPercentStartDuration = (lfloatStartDuration/lfloatTotalDuration) * 100;
        
        NSInteger lintAnimInitialFrameIndex = (lfloatPercentStartDuration * lintAnimationCount)/100;
        
        NSRange lstructRange = NSMakeRange(lintAnimInitialFrameIndex,lintAnimationCount - lintAnimInitialFrameIndex);
        
        NSIndexSet* lobjIndexSet = [NSIndexSet indexSetWithIndexesInRange:lstructRange];
        
        NSArray* larrayFrames =
        [lobjAnimationCopy.frames  objectsAtIndexes:lobjIndexSet];
        
        lobjAnimationCopy.frames = [NSMutableArray arrayWithArray:larrayFrames];
    }
    
    lobjAnimationCopy.delayPerUnit = lfloatDelayForPerUnit;
    
    if (lobjAnimationCopy)
    {
        if (lenumActionType == RepeatingActionType)
        {
            lobjAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:lobjAnimationCopy ]];
        }
        else
        {
            lobjAction = [CCActionAnimate actionWithAnimation:lobjAnimationCopy];
        }
    }
    if (lobjAction == nil)
    {
        NSLog(@"lstrAnimationToPLay %@ is nil", lstrAnimationName);
    }
    return lobjAction;
}

//---------------------------------------------------------------------------------
#pragma mark - Private Method
//---------------------------------------------------------------------------------

- (NSString*)strActionType
{
    NSString* lstrActionType;
    
    switch (self.enumActionType)
    {
        case NonRepeatingActionType:
        {
            lstrActionType = @"NonRepeatingActionType";
            break;
        }
        case RepeatingActionType:
        {
            lstrActionType = @"RepeatingActionType";
            break;
        }
        default:
        {
            break;
        }
            
    }
    return lstrActionType;
}

//---------------------------------------------------------------------------------
#pragma mark - Overridden Methods
//---------------------------------------------------------------------------------

- (void)setIntActionTag:(NSInteger)lintActionTag
{
    _intActionTag = lintActionTag;
    
    [self.objAction setTag:lintActionTag];
}

- (NSString*)description
{
    NSString* lstrAnimationType = [TypeIdentifierUtils stringForAnimationTypeIdentifier:self.enumAnimationTypeIdentifier];
    
    return [NSString stringWithFormat:@"<%@ = %p | tag = %zd, actionType = %@  animationType = %@>", [self class], self, self.intActionTag, [self strActionType] ,lstrAnimationType];
}

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------
