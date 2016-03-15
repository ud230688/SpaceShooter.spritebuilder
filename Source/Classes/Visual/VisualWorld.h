//
//  VisualWorld.h
//  SpaceShooter
//
//  Created by Udit AJMERA on 09/03/16.
//  Copyright © 2016 Apportable. All rights reserved.
//
//------------------------------------------------------
#pragma mark - project imports
//------------------------------------------------------

#import "CCDirectoriOS.h"
#import "TypeIdentifierUtils.h"

//-----------------------------------------------------
#pragma mark - Protocol
//-----------------------------------------------------

@protocol VWDelegate <CCDirectorDelegate>

//-----------------------------------------------------
@end
//-----------------------------------------------------

//-----------------------------------------------------
#pragma mark - Forward class declaration
//-----------------------------------------------------

@class GameEntitySprite;

//-----------------------------------------------------
#pragma mark - Interface
//-----------------------------------------------------

@interface VisualWorld : CCDirectorDisplayLink

@property (nonatomic, weak,   readwrite) id<CCDirectorDelegate> delegate;


- (id)initGameWithViewFrame:(CGRect)lrectViewFrame;
- (void)removeSpriteForId:(NSInteger)lintCharacterId;
- (void)addGameEntitySprite:(GameEntitySprite*)lobjGameEntitySprite;

- (void)animationCallbackForId:(NSInteger)lintId
                 animationType:(AnimationTypeIdentifier)lenumAnimationTypeIdentifier;

- (NSString*)frameNameFromName:(NSString*)lstrName;

//------------------------------------------------------
@end
//------------------------------------------------------
