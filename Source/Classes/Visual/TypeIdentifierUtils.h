//
//  TypeIdentifierUtils.h
//  TripleJackPokerGame
//
//  Created by Udit on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefs.h"

@interface TypeIdentifierUtils : NSObject

//------------------------------------------------------------------
#pragma mark - ClassMethods
//------------------------------------------------------------------


+ (NSInteger)evaderScoreWeightForName:(NSString*)lstrEvaderName;
+ (NSString*)strLevelTimeForSeconds:(float)lfloatSeconds;

+ (NSString*)stringForAnimationTypeIdentifier:(AnimationTypeIdentifier)lstrEvaderName;



@end
