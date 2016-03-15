//
//  GameConstants.h
//  TripleJackPokerGame
//
//  Created by Udit on 12/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#ifndef TripleJackPokerGame_GameConstants_h
#define TripleJackPokerGame_GameConstants_h


//------------------------------------------------------
#pragma mark - iOS Version constants
//------------------------------------------------------

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



//------------------------------------------------------
#pragma mark - Enums
//------------------------------------------------------

//------------------------------------------------------
#pragma mark - GameType enum
//------------------------------------------------------




typedef enum
{
    chips = 0,
    jacks = 1
    
    
} CurrencyType;

//-----------------------------------------------------
#pragma mark - Resources
//-----------------------------------------------------

#define BACKGROUND_IMAGE                     @"BG.png"



//------------------------------------------------------
#pragma mark - Friends type Constant strings
//------------------------------------------------------

#define ADMINS_STRING               @"admins"
#define FRIENDS_STRING              @"friends"
#define HELPERS_STRING              @"helpers"
#define FRIEND_RECIEVED_STRING      @"requests_received"
#define FRIEND_SENT_STRING          @"requests_sent"

//------------------------------------------------------
#endif
//------------------------------------------------------