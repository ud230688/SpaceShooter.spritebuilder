  //
//  GameEntitySprite.m
//  TripleJackPokerGame
//
//  Created by Udit on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

//---------------------------------------------------------------------------------
#pragma mark - project import
//---------------------------------------------------------------------------------

#import "GameEntitySprite.h"
#import "VisualWorld.h"
#import "QueueManager.h"
#import "GameEntityAnimation.h"
#import "FileUtils.h"
#import "TypeIdentifierUtils.h"
#import "CCAnimationCache.h"

//---------------------------------------------------------------------------------
#pragma mark - PrivateInterface
//---------------------------------------------------------------------------------

@interface GameEntitySprite()

//---------------------------------------------------------------------------------
#pragma mark - Properties
//---------------------------------------------------------------------------------

@property (nonatomic, assign)   NSUInteger             intId;
@property (nonatomic, weak  )   VisualWorld*    objVisualWorld;
@property (nonatomic, strong)   NSMutableArray* arrayAnimations;

//---------------------------------------------------------------------------------
#pragma mark - InstanceMethods
//---------------------------------------------------------------------------------

- (void)initializeWithVisualWorld:(VisualWorld*)lobjVisualWorld
                           withId:(NSUInteger)lintId
                         position:(CGPoint)lstructPoint;

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
#pragma mark - Implementation
//---------------------------------------------------------------------------------

@implementation GameEntitySprite

//---------------------------------------------------------------------------------
#pragma mark - Initialization
//---------------------------------------------------------------------------------

- (void)initializeWithVisualWorld:(VisualWorld*)lobjVisualWorld
                           withId:(NSUInteger)lintId
                         position:(CGPoint)lstructPoint
{
    
    self.intId = lintId;
    self.position = lstructPoint;
    self.objVisualWorld = lobjVisualWorld;
    
    self.arrayAnimations = [NSMutableArray array];
    
    [self.objVisualWorld addGameEntitySprite:self];
    
        //its subsprite no need it to add to the visualworld dictionary
    
    
    [self loadAnimations];
}

- (id)initWithVisualWorld:(VisualWorld*)lobjVisualWorld
                   withId:(NSUInteger)lintId
                framename:(NSString*)lstrFramename
                 position:(CGPoint)lstructPoint
{
    
    CCSpriteFrame* lobjSpriteFrame = [[CCSpriteFrameCache
                                       sharedSpriteFrameCache]
                                      spriteFrameByName:lstrFramename];
    
    if (!lobjSpriteFrame)
    {
        
      //  [Flurry logEvent:[NSString stringWithFormat:@"IMAGE NOT FOUND:%@",lstrFramename]];
        
        self = [super initWithImageNamed:@"crash.png"];
        
        if (self)
        {
            self.position = lstructPoint;
        }
        
    }
    else
    {
        self = [super initWithSpriteFrame:lobjSpriteFrame];
        
        if (self)
        {
            [self initializeWithVisualWorld:lobjVisualWorld
                                     withId:lintId
                                   position:lstructPoint];
        }
    }
    
    return self;
}

- (id)initWithVisualWorld:(VisualWorld*)lobjVisualWorld
                   withId:(NSUInteger)lintId
                framename:(NSString*)lstrFramename
                 position:(CGPoint)lstructPoint
                  heading:(CGPoint)lstructHeading
{
//    if([lstrFramename containsString:@"-hd"] == NO)
//    {
//       lstrFramename = [self.objVisualWorld addhdSuffixForImageName:lstrFramename];
//    }

    CCSpriteFrame* lobjSpriteFrame = [[CCSpriteFrameCache
                                       sharedSpriteFrameCache]
                                      spriteFrameByName:lstrFramename];
    if (!lobjSpriteFrame)
    {
     //   [Flurry logEvent:[NSString stringWithFormat:@"IMAGE NOT FOUND:%@",lstrFramename]];
        
        self = [super initWithImageNamed:@"crash.png"];

        if (self)
        {
            
            self.position = lstructPoint;
            
            self.structHeading = lstructHeading;
            
            [self rotateSpriteInDirectionOfHeading:self.structHeading];
        }
        
    }
    else
    {
        self = [super initWithSpriteFrame:lobjSpriteFrame];
        
        if (self)
        {
            [self initializeWithVisualWorld:lobjVisualWorld withId:lintId position:lstructPoint];
            self.structHeading = lstructHeading;
            [self rotateSpriteInDirectionOfHeading:self.structHeading];
        }
    }
    
    return self;
}

- (id)initWithVisualWorld:(VisualWorld*)lobjVisualWorld
                   withId:(NSUInteger)lintId
                 position:(CGPoint)lstructPoint
{
    self = [super init];
    
    if (self)
    {
        [self initializeWithVisualWorld:lobjVisualWorld withId:lintId position:lstructPoint ];
    }
    
    return self;
}

//---------------------------------------------------------------------------------
#pragma mark - Instance Methods
//---------------------------------------------------------------------------------

- (void)fadeOutWithDuration:(float)lfloatDuration
{
    CCActionFadeOut* lobjFadeOut = [CCActionFadeTo actionWithDuration:lfloatDuration
                                                  opacity:0.0];
    
    [self runAction:lobjFadeOut];
}

- (void)playBlinkingAnimation
{
    
    CCActionFadeTo* lobjFadeOutSprite = [CCActionFadeTo actionWithDuration:0.2 opacity:100];
    CCActionDelay* lobjDelay = [CCActionDelay actionWithDuration:0.2];
    CCActionFadeTo* lobjFadeInSprite = [CCActionFadeTo actionWithDuration:0.2 opacity:255];
    CCAction *lobjAction = [CCActionRepeatForever actionWithAction:[CCActionSequence actions:
                                                              lobjFadeOutSprite,
                                                              lobjDelay,
                                                              lobjFadeInSprite,
                                                              nil]];
    
    
    lobjAction.tag = TAG_BLINKING_ACTION;
    
    [self runAction:lobjAction];
}

- (void)playBlinkingAnimationForPowerIcon
{
    CCActionFadeTo* lobjFadeOutSprite = [CCActionFadeTo actionWithDuration:1.0f opacity:120];
    CCActionDelay* lobjDelay = [CCActionDelay actionWithDuration:0.3];
    CCActionFadeTo* lobjFadeInSprite = [CCActionFadeTo actionWithDuration:1.0f opacity:255];
    CCAction *lobjAction = [CCActionRepeatForever actionWithAction:[CCActionSequence actions:
                                                              lobjFadeOutSprite,
                                                              lobjDelay,
                                                              lobjFadeInSprite,
                                                              nil]];
    lobjAction.tag = TAG_BLINKING_ACTION;
    
    [self runAction:lobjAction];
}


- (void)stopBlinkingAnimation
{
    [self stopActionByTag:TAG_BLINKING_ACTION];
    
    [self setOpacity:255];
}

- (void)playOnFloorMoveVerticalAndRotateAnimationWithShift:(float)lfloatMoveShift
{
    float lfloatOneRotationTime = 8.0;
    
    CCActionInterval* lobjRotateAction =
    [CCActionRotateBy actionWithDuration:lfloatOneRotationTime
                             angle:360];
    {
        CCAction* lobjRotateRepeatForeverAction =
        [CCActionRepeatForever actionWithAction:lobjRotateAction];
        
        lobjRotateRepeatForeverAction.tag = TAG_ON_FLOOR_ROTATE_ACTION;
        
        [self runAction:lobjRotateRepeatForeverAction];
    }
    
    CCActionSequence* lobjMoveSequence =
    [CCActionSequence actions:[CCActionMoveBy actionWithDuration:1.0
                                            position:CGPointMake(0,lfloatMoveShift)],
     [CCActionMoveBy actionWithDuration:1.0
                         position:CGPointMake(0,-lfloatMoveShift)],
     nil];
    {
        CCAction* lobjMoveRepeatForeverAction =
        [CCActionRepeatForever actionWithAction:lobjMoveSequence];
        
        lobjMoveRepeatForeverAction.tag = TAG_ON_FLOOR_MOVE_VERTICAL_UP_DOWN_ACTION;
        
        [self runAction:lobjMoveRepeatForeverAction];
    }
}

- (void)playOnFloorMoveVerticalUpAndDownAnimation
{
    CCActionSequence* lobjSequence =
    [CCActionSequence actions:[CCActionMoveBy actionWithDuration:1.0
                                            position:CGPointMake(0,3)],
     [CCActionMoveBy actionWithDuration:1.0
                         position:CGPointMake(0,-3)],
     nil];
    
    CCAction* lobjOnFloorAction =
    [CCActionRepeatForever actionWithAction:lobjSequence];
    
    lobjOnFloorAction.tag = TAG_ON_FLOOR_MOVE_VERTICAL_UP_DOWN_ACTION;
    
    [self runAction:lobjOnFloorAction];
}

- (void)stopOnFloorMoveVerticalUpAndDownAnimation
{
    [self stopActionByTag:TAG_ON_FLOOR_MOVE_VERTICAL_UP_DOWN_ACTION];
}

- (void)playDenyingAnimationForDuration:(float)lfloatDuration
                            repeatCount:(int)lintRepeatCount
{
    CCActionSequence* lobjSequence = [CCActionSequence actions:
                                [CCActionMoveTo actionWithDuration:lfloatDuration/4
                                                    position:CGPointMake(self.position.x - 2,
                                                                         self.position.y)],
                                [CCActionMoveTo actionWithDuration:lfloatDuration/2
                                                    position:CGPointMake(self.position.x + 2,
                                                                         self.position.y)],
                                [CCActionMoveTo actionWithDuration:lfloatDuration/2
                                                    position:CGPointMake(self.position.x,
                                                                         self.position.y)],
                                nil];
    
    CCAction* lobjDenyingAction = [CCActionRepeat actionWithAction:lobjSequence
                                                       times:lintRepeatCount];
    
    lobjDenyingAction.tag = TAG_DENYING_ACTION;
    
    [self runAction:lobjDenyingAction];
}

- (void)stopAnimationForIdentifier:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
{
    if(self.arrayAnimations)
    {
        NSArray *larrayAnimations  = [NSArray arrayWithArray:self.arrayAnimations];
        
        NSInteger lintActionTag;
        
        for (GameEntityAnimation* lobjGameEntityAnimation in larrayAnimations)
        {
            if (lobjGameEntityAnimation.enumAnimationTypeIdentifier == lenumAnimationTypeIdentifier)
            {
                lintActionTag = lobjGameEntityAnimation.intActionTag;
                
                [self stopActionByTag:lintActionTag];
                break;
            }
        }
    }
}

- (BOOL)isAnimationCompleted
{
    BOOL bAnimationCompleted = NO;
    
    GameEntityAnimation *lobjGameEntityFrameAnimation = nil;
    
    for (GameEntityAnimation* lobjGameEntityAnimation in self.arrayAnimations)
    {
        if (lobjGameEntityAnimation.intActionTag == TAG_FRAMES_ANIMATION)
        {
            lobjGameEntityFrameAnimation = lobjGameEntityAnimation;
        }
    }
    
    if (lobjGameEntityFrameAnimation)
    {
        CCAnimation* lobjCCAnimation = lobjGameEntityFrameAnimation.objAnimation;
        NSInteger lintTotalFrames = [[lobjCCAnimation frames] count];
        NSInteger lintCurrentFrameRunning = [self frameOfAnimation:lobjCCAnimation];
        
        if(lintCurrentFrameRunning == (lintTotalFrames - 1))
        {
            bAnimationCompleted = YES;
        }
    }
    return bAnimationCompleted;
}

- (void)scaleSpriteToSize:(float)lfloatScaleSize
                 duration:(float)lfloatDuration
{
    [self runAction:[CCActionScaleTo actionWithDuration:lfloatDuration scale:lfloatScaleSize]];
}

- (void)setActionSpeed:(float)lfloatActionSpeed
       forAnimationETI:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
{
    for(GameEntityAnimation* lobjRunningAnimation in self.arrayAnimations)
    {
        if (lobjRunningAnimation.enumAnimationTypeIdentifier == lenumAnimationTypeIdentifier)
        {
            [lobjRunningAnimation setActionSpeed:lfloatActionSpeed];
            
            break;
        }
    }
}

//---------------------------------------------------------------------------------
#pragma mark - Methods To Be Overridden
//---------------------------------------------------------------------------------

//- (void)loadAnimations
//{
//    // To be overridden
//}

- (void)loadAnimations
{
    //[self loadAnimationsFromPlist:@"laughAnim.plist"];
}


- (void)rotateSpriteInDirectionOfHeading:(CGPoint)lstructHeading
{
    float lfloatRotationAngleRadians = ( (float) atan2(lstructHeading.y ,
                                                       lstructHeading.x));
    float lfloatRotationAngleDegrees = CC_RADIANS_TO_DEGREES(lfloatRotationAngleRadians);
    
    float lfloatRotationCocosAngle = ((-1) * lfloatRotationAngleDegrees);
    
    self.structHeading = lstructHeading;
    
    self.rotation = lfloatRotationCocosAngle;
}

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
{
    // To be overridden
    
    GameEntityAnimation* lobjGameEntityAnimation = nil;
    
    lobjGameEntityAnimation = [GameEntityAnimation actionWithAnimationType:lenumAnimationTypeIdentifier
                                                                 actionTag:TAG_FRAMES_ANIMATION
                                                                actionType:lenumActionType
                                                              targetSprite:self
                                                                  delegate:self];
    
    [self runAnimation:lobjGameEntityAnimation];
    
}


- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
             duration:(float)lfloatDuration
{
    //To be overidden
}

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
             position:(CGPoint)lstructTargetPoint
             duration:(float)lfloatDuration
{
    //To be overidden
}

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
        startDuration:(float)lfloatStartDuration
        totalDuration:(float)lfloatTotalDuration
{
    //To be overidden
}

- (void)playAnimation:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
           actionType:(ActionType)lenumActionType
                scale:(float)lfloatScaleFactor
             position:(CGPoint)lstructTargetPoint
           jumpHeight:(float)lfloatJumpHeight
             duration:(float)lfloatDuration
{
    GameEntityAnimation* lobjGameEntityAnimation = nil;
    
    switch (lenumAnimationTypeIdentifier)
    {
        case PotDockingAnimationTypeIdentifier:
        case DockCardJumpToCenterForDiscardAnimation:
        {
            
            
            CCActionInterval* lobjAction = [CCActionSpawn actions:
                                            [CCActionJumpTo actionWithDuration:lfloatDuration
                                                                position:lstructTargetPoint
                                                                  height:lfloatJumpHeight
                                                                   jumps:1],
                                            [CCActionScaleTo actionWithDuration:lfloatDuration
                                                                    scale:lfloatScaleFactor],
                                            nil];
            CCAction* lobjEaseAction =
            [CCActionEaseInOut actionWithAction:lobjAction
                                     rate:10.0f];
            
            lobjGameEntityAnimation =
            [GameEntityAnimation actionWithAction:lobjEaseAction
                                        actionTag:TAG_SECONDARY_ANIMATION
                                       actionType:lenumActionType
                                    animationType:lenumAnimationTypeIdentifier
                                         delegate:self];
            
            break;
        }
        default:
        {
            CCActionInterval* lobjAction = [CCActionSpawn actions:
                                            [CCActionJumpTo actionWithDuration:lfloatDuration
                                                                position:lstructTargetPoint
                                                                  height:lfloatJumpHeight
                                                                   jumps:1],
                                            [CCActionFadeOut actionWithDuration:lfloatDuration],
                                            [CCActionScaleTo actionWithDuration:lfloatDuration
                                                                    scale:lfloatScaleFactor],
                                            nil];
            CCAction* lobjEaseAction =
            [CCActionEaseInOut actionWithAction:lobjAction
                                     rate:0.8];
            
            lobjGameEntityAnimation =
            [GameEntityAnimation actionWithAction:lobjEaseAction
                                        actionTag:TAG_SECONDARY_ANIMATION
                                       actionType:lenumActionType
                                    animationType:lenumAnimationTypeIdentifier
                                         delegate:self];
            break;
        }
    }
    
    if (lobjGameEntityAnimation)
    {
        [self runAnimation:lobjGameEntityAnimation];
    }
    else
    {
        NSLog(@"ERROR : Animation is nil");
    }
}

- (void)runAnimation:(GameEntityAnimation*)lobjGameEntityAnimation
{
//    NSString* lstrAnimationToPlay = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lobjGameEntityAnimation.enumAnimationTypeIdentifier];
    
    if (lobjGameEntityAnimation)
    {
        [self stopActionByTag:lobjGameEntityAnimation.intActionTag];
        
//        GESLOG(NSLog(@" Play Animation: %@ For:%@", lstrAnimationToPlay, NSStringFromClass([self class])););
        
        [self.arrayAnimations addObject:lobjGameEntityAnimation];
        
        [lobjGameEntityAnimation runAnimationOnTarget:self];
    }
    else
    {
        //GESLOG(NSLog(@"action for AnimationTypeIdentifier %@ is NIL", lstrAnimationToPlay););
    }
}

- (void)animationEndCallBackForAnimationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier
{
//    switch (lenumAnimationTypeIdentifier)
//    {
//        case GameEntityDestroyAnimationTypeIdentifier:
//        {
//            [self.objVisualWorld removeSpriteForId:self.intId];
//            
//            break;
//        }
//        case ExitWorldAnimationTypeIdentifier:
//        {
//            NSLog(@"Seeker Exit");
//            break;
//        }
//        default:
//        {
//            break;
//        }
//    }
}

//---------------------------------------------------------------------------------
#pragma mark - Overridden Methods
//---------------------------------------------------------------------------------

- (void)stopAllActions
{
    [super stopAllActions];
    
    for (GameEntityAnimation* lobjGameEntityAnimation in self.arrayAnimations)
    {
        if(lobjGameEntityAnimation.enumActionType == NonRepeatingActionType)
        {
            [lobjGameEntityAnimation interruptNonRepeatingActionCallBack];
        }
    }
    [self.arrayAnimations removeAllObjects];
}

- (void)stopActionByTag:(NSInteger)tag
{
    //    CCAction *lobjActionStopped = [self getActionByTag:tag];
    
    // NSLog(@"Stopped");
    
    if(self.arrayAnimations)
    {
        NSArray *larrayAnimations  = [NSArray arrayWithArray:self.arrayAnimations];
        
        for (GameEntityAnimation* lobjGameEntityAnimation in larrayAnimations)
        {
            if (lobjGameEntityAnimation.intActionTag == tag)
            {
                //            if ([NSStringFromClass([self class]) isEqualToString:@"DragonEvaderCharacterSprite"])
                //            {
                //                NSLog(@"Action:::::%@" , lobjGameEntityAnimation);
                //            }
                
                if(lobjGameEntityAnimation.enumActionType == NonRepeatingActionType)
                {
                    [lobjGameEntityAnimation interruptNonRepeatingActionCallBack];
                }
                [self.arrayAnimations removeObject:lobjGameEntityAnimation];
            }
        }
    }
    
    [super stopActionByTag:tag];
}

- (void)stopAction:(CCAction *)action
{
    if(self.arrayAnimations)
    {
        NSArray *larrayAnimations  = [NSArray arrayWithArray:self.arrayAnimations];
        
        for (GameEntityAnimation* lobjGameEntityAnimation in larrayAnimations)
        {
            if (lobjGameEntityAnimation.objAction == action)
            {
                if(lobjGameEntityAnimation.enumActionType == NonRepeatingActionType)
                {
                    [lobjGameEntityAnimation interruptNonRepeatingActionCallBack];
                }
                [self.arrayAnimations removeObject:lobjGameEntityAnimation];
            }
        }
    }
    
    [super stopAction:action];
}

- (void)removeFromParentAndCleanup:(BOOL)cleanup
{
    [super removeFromParentAndCleanup:cleanup];
    
    [self stopAllActions];
}

//---------------------------------------------------------------------------------
#pragma mark - Update
//---------------------------------------------------------------------------------

- (void)updateHeading:(CGPoint)lstructHeading
{
    self.structHeading = lstructHeading;
    
    [self rotateSpriteInDirectionOfHeading:lstructHeading];
}

- (void)updatePosition:(CGPoint)lstructPosition
{
//    lstructPosition.x += self.objVisualWorld.structSizeBufferDueToTMX.x;
//    lstructPosition.y += self.objVisualWorld.structSizeBufferDueToTMX.y;
    
    self.position = lstructPosition;
}

//---------------------------------------------------------------------------------
#pragma mark - GameEntityAnimationDelegate Method
//---------------------------------------------------------------------------------

- (void)animationEndCallBackForAction:(GameEntityAnimation*)lobjGameActionEnded
{
    AnimationTypeIdentifier lenumAnimationTypeIdentifer = lobjGameActionEnded.enumAnimationTypeIdentifier;
    
    [self animationEndCallBackForAnimationType:lenumAnimationTypeIdentifer];
    
//    NSString* lstrAnimationToPlay = [TypeIdentifierUtils stringForAnimationTypeIdentifier:lenumAnimationTypeIdentifer];
    
//    GESLOG(NSLog(@"AnimationCallback: %@ forSprite:%@",lstrAnimationToPlay, NSStringFromClass([self class])););
    
    if(lobjGameActionEnded.enumActionType == NonRepeatingActionType)
    {
        [lobjGameActionEnded interruptNonRepeatingActionCallBack];
    }
    
    [self.arrayAnimations removeObject:lobjGameActionEnded];
    [self.objVisualWorld animationCallbackForId:self.intId
                                  animationType:lenumAnimationTypeIdentifer];
}

//---------------------------------------------------------------------------------
#pragma mark - AnimationLoadingMethods
//---------------------------------------------------------------------------------

- (void)loadAnimationsFromPlist:(NSString*)lstrAnimationPlistName
{
    NSDictionary *lDictAnimationPlist =
    [NSDictionary dictionaryWithContentsOfFile:[FileUtils pathForFileName:lstrAnimationPlistName]];
    
    if (lDictAnimationPlist == nil)
    {
        NSLog(@"Error Reading plist: %@", lstrAnimationPlistName);
    }
    else
    {
        NSArray* larrayAnimationNames = [lDictAnimationPlist allKeys];
        
        for( NSString *lstrAnimationName in larrayAnimationNames)
        {
           
            if ([[CCAnimationCache sharedAnimationCache] animationByName:lstrAnimationName] != nil)
            {
               // GESLOG(NSLog(@"Animation already added ::%@", lstrAnimationName););
            }
            else
            {
                NSDictionary* lDictAnimation = [lDictAnimationPlist objectForKey:lstrAnimationName];
                NSString *lstrAnimationFramePrefix = [lDictAnimation objectForKey:@"filenamePrefix"];
                NSString *lstrAnimationFrames = [lDictAnimation objectForKey:@"animationFrames"];
                NSArray *larrayAnimationFrameNumbers = [lstrAnimationFrames componentsSeparatedByString:@","];
                NSNumber *delay = [lDictAnimation objectForKey:@"delay"];
                
                CCAnimation* lAnimation = nil;
                
                if (larrayAnimationFrameNumbers == nil )
                {
                    NSLog(@"AnimationCache: Animation '%@' found in dictionary without any frames - cannot add to animation cache.", lstrAnimationName);
                    continue;
                }
                
                NSMutableArray *larrayFrames = [NSMutableArray arrayWithCapacity:[larrayAnimationFrameNumbers count]];
                
                for(NSString *lstrFrameNumber in larrayAnimationFrameNumbers)
                {
                    NSString *lstrFrameName = [NSString stringWithFormat:@"%@%@.png",lstrAnimationFramePrefix,lstrFrameNumber];
                    
                    lstrFrameName = [self.objVisualWorld frameNameFromName:lstrFrameName];
                    
                    CCSpriteFrame *lSpriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:lstrFrameName];
                    
                    if ( lSpriteFrame != nil )
                    {
                        [larrayFrames addObject:lSpriteFrame];
                    }
                    else
                    {
                        NSLog(@"SpriteFrame:%@ is nil",lstrFrameName);
                    }
                }
                
                if ( [larrayFrames count] == 0 )
                {
                    NSLog(@"AnimationCache: None of the frames for animation '%@' were found in the CCSpriteFrameCache.", lstrAnimationName);
                    continue;
                }
                else if ( [larrayFrames count] != [larrayAnimationFrameNumbers count] )
                {
                    NSLog(@"AnimationCache:Some or all of the frames for the animation '%@' may be missing.", lstrAnimationName);
                }
                
                if ( delay != nil )
                {
                    
                    lAnimation = [CCAnimation  animationWithSpriteFrames:larrayFrames delay:[delay floatValue]];
                } else
                {
                    lAnimation = [CCAnimation animationWithSpriteFrames:larrayFrames];
                }
                
                
                [[CCAnimationCache sharedAnimationCache] addAnimation:lAnimation name:lstrAnimationName];
            }
        }
    }
}

//---------------------------------------------------------------------------------
#pragma mark - Private Methods
//---------------------------------------------------------------------------------

- (NSInteger)frameOfAnimation1:(CCAnimation*)animation
{
    
    CCTexture *tex = [self spriteFrame].texture;
    CGRect rect = [self spriteFrame].rect;
    
    NSInteger imageIndex = 0;
    for (NSInteger i=0; i<[animation.frames count]; i++)
    {
        CCSpriteFrame *frame = [[animation frames] objectAtIndex:i];
        CCTexture *tex2 = frame.texture;
        CGRect rect2 = frame.rect;
        
        if ([tex isEqual:tex2] && CGRectEqualToRect(rect, rect2))
        {
            imageIndex = i;
            break;
        }
    }
    
    return imageIndex;
}
/*
 
 NSArray *frames = [animation_ frames];
 NSUInteger numberOfFrames = [frames count];
 CCSpriteFrame *frameToDisplay = nil;
 
 for( NSUInteger i=nextFrame_; i < numberOfFrames; i++ ) {
 NSNumber *splitTime = [splitTimes_ objectAtIndex:i];
 
 if( [splitTime floatValue] <= t ) {
 CCAnimationFrame *frame = [frames objectAtIndex:i];
 frameToDisplay = [frame spriteFrame];
 [(CCSprite*)target_ setDisplayFrame: frameToDisplay];
 
 NSDictionary *dict = [frame userInfo];
 if( dict )
 [[NSNotificationCenter defaultCenter] postNotificationName:CCAnimationFrameDisplayedNotification object:target_ userInfo:dict];
 
 nextFrame_ = i+1;
 
 break;
 }
 }
 
 */

-(NSInteger)frameOfAnimation:(CCAnimation*)animation
{
    CCSpriteFrame *lDisplayframe = [self spriteFrame];
    
    CCTexture *tex = lDisplayframe.texture;
    CGRect rect = [self spriteFrame].rect;
    
    NSArray *frames = [animation frames];
    NSUInteger numberOfFrames = [frames count];
    
    NSInteger imageIndex = 0;
    for( NSUInteger i=0; i < numberOfFrames; i++ )
    {
        CCAnimationFrame *frame = [frames objectAtIndex:i];
        CCSpriteFrame * lframeDisplaying = [frame spriteFrame];
        CCTexture *tex2 = lframeDisplaying.texture;
        CGRect rect2 = lframeDisplaying.rect;
        
        if ([tex isEqual:tex2] && CGRectEqualToRect(rect, rect2))
        {
            imageIndex = i;
            break;
        }
        
    }
    
    return imageIndex;
}

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------


