//
//  QueueManager.h
//  TripleJackPokerGame
//
//  Created by Udit on 12/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
//---------------------------------------------------------------------------------
#pragma mark - SDKImports
//---------------------------------------------------------------------------------

#import <Foundation/Foundation.h>

//---------------------------------------------------------------------------------
#pragma mark - QueueMacros
//---------------------------------------------------------------------------------

#define QUEUE_MANAGER_ENABLE_QUEUES

#ifdef QUEUE_MANAGER_ENABLE_QUEUES

#define GAME_QUEUE_SYNC(__X__)\
dispatch_sync([QueueManager sharedInstance].gameWorldQueue, ^{@autoreleasepool{__X__}});

#define GAME_QUEUE_ASYNC(__X__)\
dispatch_async([QueueManager sharedInstance].gameWorldQueue, ^{@autoreleasepool{__X__}});

#define PHYSICS_QUEUE_SYNC(__X__)\
dispatch_sync([QueueManager sharedInstance].physicsWorldQueue, ^{@autoreleasepool{__X__}});

#define PHYSICS_QUEUE_ASYNC(__X__)\
dispatch_async([QueueManager sharedInstance].physicsWorldQueue, ^{@autoreleasepool{__X__}});

#define VISUAL_QUEUE_SYNC(__X__)\
dispatch_sync(dispatch_get_main_queue(), ^{@autoreleasepool{__X__}});

#define VISUAL_QUEUE_ASYNC(__X__)\
dispatch_async(dispatch_get_main_queue(), ^{@autoreleasepool{__X__}});



#define CONCURRENT_BACK_PRI_QUEUE_ASYNC(__X__)\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{@autoreleasepool{__X__}});

#else

#define GAME_QUEUE_SYNC(__X__)                  @autoreleasepool{__X__}
#define GAME_QUEUE_ASYNC(__X__)                 @autoreleasepool{__X__}
#define PHYSICS_QUEUE_SYNC(__X__)               @autoreleasepool{__X__}
#define PHYSICS_QUEUE_ASYNC(__X__)              @autoreleasepool{__X__}
#define VISUAL_QUEUE_SYNC(__X__)                @autoreleasepool{__X__}
#define VISUAL_QUEUE_ASYNC(__X__)               @autoreleasepool{__X__}
#define CONCURRENT_BACK_PRI_QUEUE_ASYNC(__X__)  @autoreleasepool{__X__}

#endif

//---------------------------------------------------------------------------------
#pragma mark - Interface
//---------------------------------------------------------------------------------

@interface QueueManager : NSObject

//---------------------------------------------------------------------------------
#pragma mark - Properties
//---------------------------------------------------------------------------------

@property (nonatomic, readonly) dispatch_queue_t physicsWorldQueue;
@property (nonatomic, readonly) dispatch_queue_t gameWorldQueue;
@property (nonatomic, readonly) dispatch_queue_t coreDataQueue;
@property (nonatomic, readonly) dispatch_queue_t facebookQueue;

//---------------------------------------------------------------------------------
#pragma mark - SharedInstance
//---------------------------------------------------------------------------------

+ (QueueManager*)sharedInstance;

//---------------------------------------------------------------------------------
#pragma mark - IntializeDeinitialize
//---------------------------------------------------------------------------------

-(void)initialize;
-(void)deinitialize;


//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------