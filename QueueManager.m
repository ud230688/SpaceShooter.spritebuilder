//
//  QueueManager.m
//  TripleJackPokerGame
//
//  Created by Udit on 12/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
//---------------------------------------------------------------------------------
#pragma mark - ProjectImports
//---------------------------------------------------------------------------------

#import "QueueManager.h"

//---------------------------------------------------------------------------------
#pragma mark - Private
//---------------------------------------------------------------------------------

@interface QueueManager()

@property (nonatomic, readwrite) dispatch_queue_t physicsWorldQueue;
@property (nonatomic, readwrite) dispatch_queue_t gameWorldQueue;

@end


//---------------------------------------------------------------------------------
#pragma mark - Implementation
//---------------------------------------------------------------------------------

@implementation QueueManager

//---------------------------------------------------------------------------------
#pragma mark - Properties
//---------------------------------------------------------------------------------

@synthesize physicsWorldQueue;
@synthesize gameWorldQueue;

//---------------------------------------------------------------------------------
#pragma mark - InstanceMethods
//---------------------------------------------------------------------------------

-(void)initialize
{
    if(self.physicsWorldQueue == nil)
    {
        self.physicsWorldQueue = dispatch_queue_create("physicsWorldQueue", NULL);
    }
    
    if(self.gameWorldQueue == nil)
    {
        self.gameWorldQueue = dispatch_queue_create("gameWorldQueue", NULL);
    }
    
}

-(void)deinitialize
{
    if (self.physicsWorldQueue)
    {
        self.physicsWorldQueue = nil;
    }
    
    if (self.gameWorldQueue)
    {
        self.gameWorldQueue = nil;
    }
}

//---------------------------------------------------------------------------------
#pragma mark - Singleton methods
//---------------------------------------------------------------------------------

+ (QueueManager*)sharedInstance
{
    static QueueManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[QueueManager alloc] init];
                      
                  });
    return sharedInstance;
}

//---------------------------------------------------------------------------------
@end
//---------------------------------------------------------------------------------
