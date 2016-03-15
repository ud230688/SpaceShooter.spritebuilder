//
//  TypeIdentifierUtils.m
//  TripleJackPokerGame
//
//  Created by Udit on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TypeIdentifierUtils.h"
#import "TypeDefs.h"

@implementation TypeIdentifierUtils

+ (NSString*)stringForAnimationTypeIdentifier:(AnimationTypeIdentifier)lstrEvaderName
{
    NSString* lstrToReturn = @"";
    switch (lstrEvaderName)
    {
        case CurrentChanceIndicatorPlayAnimation:
        {
            lstrToReturn = @"CurrentChanceIndicatorPlayAnimation";
            break;
        }
        case Bomb_PlayAnimationTypeIdentifier:
        {
            lstrToReturn = @"Bomb_PlayAnimationTypeIdentifier";
            break;
        }
        case Bomb_JumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Bomb_JumpAnimationTypeIdentifier";
            break;
        }
        case Pie_PlayAnimationTypeIdentifier:
        {
            lstrToReturn = @"Pie_PlayAnimationTypeIdentifier";
            break;
        }
        case Pie_JumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Pie_JumpAnimationTypeIdentifier";
            break;
            
        }
        case WaterBalloon_PlayAnimationTypeIdentifier:
        {
            lstrToReturn = @"WaterBalloon_PlayAnimationTypeIdentifier";
            break;
        }
        case WaterBalloon_JumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"WaterBalloon_JumpAnimationTypeIdentifier";
            break;
        }
        case AnvilAnimationTypeIdentifier:
        {
            lstrToReturn = @"AnvilAnimationTypeIdentifier";
            break;
        }
        case Tomato_PlayAnimationTypeIdentifier:
        {
            lstrToReturn = @"Tomato_PlayAnimationTypeIdentifier";
            break;
        }
        case Tomato_JumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Tomato_JumpAnimationTypeIdentifier";
            break;
        }
        case Bomb05_PlayAnimationTypeIdentifier:
        {
            lstrToReturn = @"Bomb05_PlayAnimationTypeIdentifier";
            break;
        }
        case BeerAnimationTypeIdentifier:
        {
            lstrToReturn = @"BeerAnimationTypeIdentifier";
            break;
        }
        case TrashCanAnimationTypeIdentifier:
        {
            lstrToReturn = @"TrashCanAnimationTypeIdentifier";
            break;
        }
        case SnowBallAnimationTypeIdentifier:
        {
            lstrToReturn = @"SnowBallAnimationTypeIdentifier";
            break;
        }
        case PottedPlantAnimationTypeIdentifier:
        {
            lstrToReturn = @"PottedPlantAnimationTypeIdentifier";
            break;
        }
        case BurgerAnimationTypeIdentifier:
        {
            lstrToReturn = @"BurgerAnimationTypeIdentifier";
            break;
        }
        case BuyFlowersAnimationTypeIdentifier:
        {
            lstrToReturn = @"BuyFlowersAnimationTypeIdentifier";
            break;
        }
        case ChocolateCakeAnimationTypeIdentifier:
        {
            lstrToReturn = @"ChocolateCakeAnimationTypeIdentifier";
            break;
        }
        case EffectAnimationTypeIdentifier:
        {
            lstrToReturn = @"EffectAnimationTypeIdentifier";
            break;
        }
        case FedoraAnimationTypeIdentifier:
        {
            lstrToReturn = @"FedoraAnimationTypeIdentifier";
            break;
        }
        case FishAnimationTypeIdentifier:
        {
            lstrToReturn = @"FishAnimationTypeIdentifier";
            break;
        }
        case GiveChocolateCakeAnimationTypeIdentifier:
        {
            lstrToReturn = @"GiveChocolateCakeAnimationTypeIdentifier";
            break;
        }
        case GrenadeAnimationTypeIdentifier:
        {
            lstrToReturn = @"GrenadeAnimationTypeIdentifier";
            break;
        }
        case HeartAnimationTypeIdentifier:
        {
            lstrToReturn = @"HeartAnimationTypeIdentifier";
            break;
        }
        case MissileAnimationTypeIdentifier:
        {
            lstrToReturn = @"MissileAnimationTypeIdentifier";
            break;
        }
        case PaperAirplaneAnimationTypeIdentifier:
        {
            lstrToReturn = @"PaperAirplaneAnimationTypeIdentifier";
            break;
        }
        case PieAnimationTypeIdentifier:
        {
            lstrToReturn = @"PieAnimationTypeIdentifier";
            break;
        }
        case PiggyAnimationTypeIdentifier:
        {
            lstrToReturn = @"PiggyAnimationTypeIdentifier";
            break;
        }
        case PokerRuleBookAnimationTypeIdentifier:
        {
            lstrToReturn = @"PokerRuleBookAnimationTypeIdentifier";
            break;
        }
        case RocketShipAnimationTypeIdentifier:
        {
            lstrToReturn = @"RocketShipAnimationTypeIdentifier";
            break;
        }
        case SnowConeAnimationTypeIdentifier:
        {
            lstrToReturn = @"SnowConeAnimationTypeIdentifier";
            break;
        }
        case SpadeAnimationTypeIdentifier:
        {
            lstrToReturn = @"SpadeAnimationTypeIdentifier";
            break;
        }
        case StormCloudAnimationTypeIdentifier:
        {
            lstrToReturn = @"StormCloudAnimationTypeIdentifier";
            break;
        }
            
        case EggAnimationTypeIdentifier:
        {
            lstrToReturn = @"EggAnimationTypeIdentifier";
            break;
        }
            
        case SheepAnimationTypeIdentifier:
        {
            lstrToReturn = @"SheepAnimationTypeIdentifier";
            break;
        }
        case Toxic_SlimeAnimationTypeIdentifier:
        {
            lstrToReturn = @"Toxic_SlimeAnimationTypeIdentifier";
            break;
        }
        case Admin_fistAnimationTypeIdentifier:
        {
            lstrToReturn = @"Admin_fistAnimationTypeIdentifier";
            break;
        }
        case Birthday_cakeAnimationTypeIdentifier:
        {
            lstrToReturn = @"Birthday_cakeAnimationTypeIdentifier";
            break;
        }
        case Bowling_BallAnimationTypeIdentifier:
        {
            lstrToReturn = @"Bowling_BallAnimationTypeIdentifier";
            break;
        }
        case SharkAnimationTypeIdentifier:
        {
            lstrToReturn = @"SharkAnimationTypeIdentifier";
            break;
        }
            
        case Eye_BallAnimationTypeIdentifier:
        {
            lstrToReturn = @"Eye_BallAnimationTypeIdentifier";
            break;
        }
        case First_of_PowerAnimationTypeIdentifier:
        {
            lstrToReturn = @"First_of_PowerAnimationTypeIdentifier";
            break;
        }
        case Slime_BallAnimationTypeIdentifier:
        {
            lstrToReturn = @"Slime_BallAnimationTypeIdentifier";
            break;
        }
        case Buy_FlowersAnimationTypeIdentifier:
        {
            lstrToReturn = @"Buy_FlowersAnimationTypeIdentifier";
            break;
        }
        case Buy_Glass_of_WineAnimationTypeIdentifier:
        {
            lstrToReturn = @"Buy_Glass_of_WineAnimationTypeIdentifier";
            break;
        }
        case Buy_a_DrinkAnimationTypeIdentifier:
        {
            lstrToReturn = @"Buy_a_DrinkAnimationTypeIdentifier";
            break;
        }
        case Give_TrophyAnimationTypeIdentifier:
        {
            lstrToReturn = @"Give_TrophyAnimationTypeIdentifier";
            break;
        }
        case Give_a_PresentAnimationTypeIdentifier:
        {
            lstrToReturn = @"Give_a_PresentAnimationTypeIdentifier";
            break;
        }
        case Merd_GlassesAnimationTypeIdentifier:
        {
            lstrToReturn = @"Merd_GlassesAnimationTypeIdentifier";
            break;
        }
        case Duct_TapeAnimationTypeIdentifier:
        {
            lstrToReturn = @"Duct_TapeAnimationTypeIdentifier";
            break;
        }
        case Girl_AnimationAnimationTypeIdentifier:
        {
            lstrToReturn = @"Girl_AnimationAnimationTypeIdentifier";
            break;
        }
        case EffectAnimationAnimationTypeIdentifier:
        {
            lstrToReturn = @"EffectAnimationAnimationTypeIdentifier";
            break;
        }
        case Fancy_Hat_and_MoustacheAnimationTypeIdentifier:
        {
            lstrToReturn = @"Fancy_Hat_and_MoustacheAnimationTypeIdentifier";
            break;
        }
        case Give_Birthday_CakeAnimationTypeIdentifier:
        {
            lstrToReturn = @"Give_Birthday_CakeAnimationTypeIdentifier";
            break;
        }
            
        case Groucho_faceAnimationTypeIdentifier:
        {
            lstrToReturn = @"Groucho_faceAnimationTypeIdentifier";
            break;
        }
        case King_SomeoneAnimationTypeIdentifier:
        {
            lstrToReturn = @"King_SomeoneAnimationTypeIdentifier";
            break;
        }
        case Top_HatAnimationTypeIdentifier:
        {
            lstrToReturn = @"Top_HatAnimationTypeIdentifier";
            break;
        }
        case shieldAnimationTypeIdentifier:
        {
            lstrToReturn = @"shieldAnimationTypeIdentifier";
            break;
        }
            
        case AnvilJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"AnvilJumpAnimationTypeIdentifier";
            break;
        }
        case SnowBallJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"SnowBallJumpAnimationTypeIdentifier";
            break;
        }
        case BeerJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"BeerJumpAnimationTypeIdentifier";
            break;
        }
        case TrashCanJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"TrashCanJumpAnimationTypeIdentifier";
            break;
        }
        case PottedPlantJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"PottedPlantJumpAnimationTypeIdentifier";
            break;
        }
        case EggJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"EggJumpAnimationTypeIdentifier";
            break;
        }
        case Slime_BallJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Slime_BallJumpAnimationTypeIdentifier";
            break;
        }
        case MissileJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"MissileJumpAnimationTypeIdentifier";
            break;
        }
        case PaperAirplaneJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"PaperAirplaneJumpAnimationTypeIdentifier";
            break;
        }
        case FishJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"FishJumpAnimationTypeIdentifier";
            break;
        }
        case SheepJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"SheepJumpAnimationTypeIdentifier";
            break;
        }
        case GrenadeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"GrenadeJumpAnimationTypeIdentifier";
            break;
        }
        case Duct_TapeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Duct_TapeJumpAnimationTypeIdentifier";
            break;
        }
        case Bowling_BallJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Bowling_BallJumpAnimationTypeIdentifier";
            break;
        }
        case ChocolateCakeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"ChocolateCakeJumpAnimationTypeIdentifier";
            break;
        }
        case Birthday_cakeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Birthday_cakeJumpAnimationTypeIdentifier";
            break;
        }
        case Admin_fistJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Admin_fistJumpAnimationTypeIdentifier";
            break;
        }
        case PokerRuleBookJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"PokerRuleBookJumpAnimationTypeIdentifier";
            break;
        }
        case StormCloudJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"StormCloudJumpAnimationTypeIdentifier";
            break;
        }
        case RocketShipJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"RocketShipJumpAnimationTypeIdentifier";
            break;
        }
        case PiggyJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"PiggyJumpAnimationTypeIdentifier";
            break;
        }
        case SnowConeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"SnowConeJumpAnimationTypeIdentifier";
            break;
        }
        case SharkJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"SharkJumpAnimationTypeIdentifier";
            break;
        }
        case BurgerJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"BurgerJumpAnimationTypeIdentifier";
            break;
        }
        case Eye_BallJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Eye_BallJumpAnimationTypeIdentifier";
            break;
        }
        case First_of_PowerJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"First_of_PowerJumpAnimationTypeIdentifier";
            break;
        }
        case SpadeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"SpadeJumpAnimationTypeIdentifier";
            break;
        }
        case Buy_Glass_of_WineJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Buy_Glass_of_WineJumpAnimationTypeIdentifier";
            break;
        }
        case Buy_a_DrinkJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Buy_a_DrinkJumpAnimationTypeIdentifier";
            break;
        }
        case Buy_FlowersJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Buy_FlowersJumpAnimationTypeIdentifier";
            break;
        }
        case Merd_GlassesJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Merd_GlassesJumpAnimationTypeIdentifier";
            break;
        }
        case Give_a_PresentJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Give_a_PresentJumpAnimationTypeIdentifier";
            break;
        }
        case Give_TrophyJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Give_TrophyJumpAnimationTypeIdentifier";
            break;
        }
        case GiveChocolateCakeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"GiveChocolateCakeJumpAnimationTypeIdentifier";
            break;
        }
        case Give_Birthday_CakeJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Give_Birthday_CakeJumpAnimationTypeIdentifier";
            break;
        }
        case HeartJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"HeartJumpAnimationTypeIdentifier";
            break;
        }
        case Top_HatJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Top_HatJumpAnimationTypeIdentifier";
            break;
        }
        case FedoraJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"FedoraJumpAnimationTypeIdentifier";
            break;
        }
        case Groucho_faceJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Groucho_faceJumpAnimationTypeIdentifier";
            break;
        }
        case Fancy_Hat_and_MoustacheJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"Fancy_Hat_and_MoustacheJumpAnimationTypeIdentifier";
            break;
        }
        case King_SomeoneJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"King_SomeoneJumpAnimationTypeIdentifier";
            break;
        }
        case shieldJumpAnimationTypeIdentifier:
        {
            lstrToReturn = @"shieldJumpAnimationTypeIdentifier";
            break;
        }
            
        default:
            break;
    }
    return lstrToReturn;
}

@end
