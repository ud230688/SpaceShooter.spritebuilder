//
//  ObjectiveCMacros.h
//  TripleJackPokerGame
//
//  Created by Udit on 2/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
#import "AppDelegate.h"

#ifndef TripleJackPokerGame_ObjectiveCMacros_h
#define TripleJackPokerGame_ObjectiveCMacros_h


#define ENABLE_LOGS  1

#if ENABLE_LOGS==1
#   define SLog(s, ...) NSLog( @"<%p %@:(%d)> %@", self, \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, \
[NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#   define SLog(s, ...)
#endif

#define THIS [AppDelegate classinstance]

#endif
