//
//  TypeDefs.h
//  TripleJackPokerGame
//
//  Created by Udit on 12/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#ifndef TripleJackPokerGame_TypeDefs_h
#define TripleJackPokerGame_TypeDefs_h


//------------------------------------------------------
#pragma mark - Hash define
//------------------------------------------------------

#define TAG_BASE                                        200
#define TAG_BLINKING_ACTION                             TAG_BASE
#define TAG_ON_FLOOR_ROTATE_ACTION                      TAG_BASE + 1
#define TAG_ON_FLOOR_MOVE_VERTICAL_UP_DOWN_ACTION       TAG_BASE + 2
#define TAG_DENYING_ACTION                              TAG_BASE + 3
#define TAG_FRAMES_ANIMATION                            TAG_BASE + 4
#define TAG_SECONDARY_ANIMATION                         TAG_BASE + 5

//------------------------------------------------------
#pragma mark - Z-ORDER
//------------------------------------------------------

#define Z_ORDER_BASE              0
#define Z_ORDER_BACKGROUND        Z_ORDER_BASE
#define Z_ORDER_BG_TABLE          Z_ORDER_BASE + 1
#define Z_ORDER_DOCK_CARDS        Z_ORDER_BASE + 2
#define Z_ORDER_TABLE_CARDS       Z_ORDER_DOCK_CARDS
#define Z_ORDER_BET_INTERFACE_UI  Z_ORDER_DOCK_CARDS - 1
#define Z_ORDER_PLAYERS           Z_ORDER_DOCK_CARDS + 2
#define Z_ORDER_TIME_BAR          Z_ORDER_DOCK_CARDS + 3
#define Z_ORDER_DEALER_BUTTON     Z_ORDER_DOCK_CARDS + 4

#define Z_ORDER_BOMB             Z_ORDER_DOCK_CARDS + 100

#define POT_BASE_POSITION_RATIO          CGPointMake(0.50f, 0.750f)

//------------------------------------------------------
#pragma mark - Bet Interface Button Tag
//------------------------------------------------------

#define  FOLD      @"FOLD"
#define  CALL      @"CALL"
#define  RAISE     @"RAISE"
#define  CHECK     @"CHECK"
#define  BET       @"BET"


#define CALL_ALL_IN   @"Call_All_IN"
#define RAISE_ALL_IN  @"RAISE_All_IN"

typedef enum
{
    none_bet_type = 0,
    Check,
    Call,
    Fold,
    Bet,
    Raise
}BetType;


typedef enum
{
  fold_call_raise,
    
    
}BetInterfaceButtonSet;


typedef enum
{
    none_give_jack = 0,
    first_check,
    confirm_check,
}jack_give_status;

typedef enum
{
    BetAction = 0,
    CallAction,
    CheckAction,
    FoldAction,
    RaiseAction,
    AllInAction,
}BetActionType;



//------------------------------------------------------
#pragma mark - enum connection status
//------------------------------------------------------



typedef enum playerStateTypes
{
    Connected,
    Disconnected,
    ConnectionError,
    ConnectionRequested
    
} ConnectionStatus;



typedef enum
{
    NoneAnimationTypeIdentifier,
    //Seeker
    MoleLaughAnimationTypeIdentifier,
    CollectableDockingAnimationTypeIdentifier,
    PotDockingAnimationTypeIdentifier,
    Bomb_PlayAnimationTypeIdentifier,
    Bomb_JumpAnimationTypeIdentifier,
    Pie_PlayAnimationTypeIdentifier,
    Pie_JumpAnimationTypeIdentifier,
    Tomato_PlayAnimationTypeIdentifier,
    Tomato_JumpAnimationTypeIdentifier,
    WaterBalloon_PlayAnimationTypeIdentifier,
    WaterBalloon_JumpAnimationTypeIdentifier,
    Bomb05_PlayAnimationTypeIdentifier,
    BombJumpAnimationTypeIdentifier,
    PaperAirplaneBombJumpAnimationTypeIdentifier,
    DockCardJumpToCenterForDiscardAnimation,
    DockCardJumpToDockAfterDiscardAnimation,
    CurrentChanceMoveAnimationTypeIdentifier,
    CurrentChanceIndicatorPlayAnimation,
    BombDelayAnimationTypeIdentifier,
    
    AnvilAnimationTypeIdentifier,
    BeerAnimationTypeIdentifier,
    TrashCanAnimationTypeIdentifier,
    SnowBallAnimationTypeIdentifier,
    PottedPlantAnimationTypeIdentifier,
    BurgerAnimationTypeIdentifier,
    BuyFlowersAnimationTypeIdentifier,
    ChocolateCakeAnimationTypeIdentifier,
    EffectAnimationTypeIdentifier,
    FedoraAnimationTypeIdentifier,
    FishAnimationTypeIdentifier,
    GiveChocolateCakeAnimationTypeIdentifier,
    GrenadeAnimationTypeIdentifier,
    HeartAnimationTypeIdentifier,
    MissileAnimationTypeIdentifier,
    PaperAirplaneAnimationTypeIdentifier,
    PieAnimationTypeIdentifier,
    PiggyAnimationTypeIdentifier,
    PokerRuleBookAnimationTypeIdentifier,
    RocketShipAnimationTypeIdentifier,
    SnowConeAnimationTypeIdentifier,
    SpadeAnimationTypeIdentifier,
    StormCloudAnimationTypeIdentifier,
    
    EggAnimationTypeIdentifier,
    
    SheepAnimationTypeIdentifier,
    Toxic_SlimeAnimationTypeIdentifier,
    Admin_fistAnimationTypeIdentifier,
    Birthday_cakeAnimationTypeIdentifier,
    Bowling_BallAnimationTypeIdentifier,
    
   
    
   
    SharkAnimationTypeIdentifier,
    
    Eye_BallAnimationTypeIdentifier,
    First_of_PowerAnimationTypeIdentifier,
    Slime_BallAnimationTypeIdentifier,
    Buy_FlowersAnimationTypeIdentifier,
    Buy_Glass_of_WineAnimationTypeIdentifier,
    Buy_a_DrinkAnimationTypeIdentifier,
    Give_TrophyAnimationTypeIdentifier,
    Give_a_PresentAnimationTypeIdentifier,
    Merd_GlassesAnimationTypeIdentifier,
    Duct_TapeAnimationTypeIdentifier,
    Girl_AnimationAnimationTypeIdentifier,
    EffectAnimationAnimationTypeIdentifier,
    Fancy_Hat_and_MoustacheAnimationTypeIdentifier,
    Give_Birthday_CakeAnimationTypeIdentifier,
    
    Groucho_faceAnimationTypeIdentifier,
    King_SomeoneAnimationTypeIdentifier,
    Top_HatAnimationTypeIdentifier,
    shieldAnimationTypeIdentifier, 
    
    AnvilJumpAnimationTypeIdentifier,
    SnowBallJumpAnimationTypeIdentifier,
    BeerJumpAnimationTypeIdentifier,
    TrashCanJumpAnimationTypeIdentifier,
    PottedPlantJumpAnimationTypeIdentifier,
    EggJumpAnimationTypeIdentifier,
    Slime_BallJumpAnimationTypeIdentifier,
    MissileJumpAnimationTypeIdentifier,
    PaperAirplaneJumpAnimationTypeIdentifier,
    FishJumpAnimationTypeIdentifier,
    SheepJumpAnimationTypeIdentifier,
    GrenadeJumpAnimationTypeIdentifier,
    Duct_TapeJumpAnimationTypeIdentifier,
    Bowling_BallJumpAnimationTypeIdentifier,
    ChocolateCakeJumpAnimationTypeIdentifier,
    Birthday_cakeJumpAnimationTypeIdentifier,
    Admin_fistJumpAnimationTypeIdentifier,
    PokerRuleBookJumpAnimationTypeIdentifier,
    StormCloudJumpAnimationTypeIdentifier,
    RocketShipJumpAnimationTypeIdentifier,
    PiggyJumpAnimationTypeIdentifier,
    SnowConeJumpAnimationTypeIdentifier,
    SharkJumpAnimationTypeIdentifier,
    BurgerJumpAnimationTypeIdentifier,
    Eye_BallJumpAnimationTypeIdentifier,
    First_of_PowerJumpAnimationTypeIdentifier,
    SpadeJumpAnimationTypeIdentifier,
    Buy_Glass_of_WineJumpAnimationTypeIdentifier,
    Buy_a_DrinkJumpAnimationTypeIdentifier,
    Buy_FlowersJumpAnimationTypeIdentifier,
    Merd_GlassesJumpAnimationTypeIdentifier,
    Give_a_PresentJumpAnimationTypeIdentifier,
    Give_TrophyJumpAnimationTypeIdentifier,
    GiveChocolateCakeJumpAnimationTypeIdentifier,
    Give_Birthday_CakeJumpAnimationTypeIdentifier,
    HeartJumpAnimationTypeIdentifier,
    Top_HatJumpAnimationTypeIdentifier,
    FedoraJumpAnimationTypeIdentifier,
    Groucho_faceJumpAnimationTypeIdentifier,
    Fancy_Hat_and_MoustacheJumpAnimationTypeIdentifier,
    King_SomeoneJumpAnimationTypeIdentifier,
    shieldJumpAnimationTypeIdentifier,
    
    TableCardDockAnimationTypeIdentifier
    
    
}AnimationTypeIdentifier;
  
typedef enum
{
    NoneActionType = 0,
    RepeatingActionType = 1,
    NonRepeatingActionType = 2
    
}ActionType;


typedef enum
{
    NoneEntityTypeIdentifier = 0,
    SeatEntityTypeIdentifier = 1,
    SeatButtonEntityTypeIdentifier = 2,
    PokerPlayerEntityTypeIdentifier = 3,
    HandsEntityTypeIdentifier = 4,
    HoleCardDockEntityTypeIdentifier = 5,
    BetInterfaceEntityTypeIdentifier = 6,
    TableCardGameEntityTypeIdentifier = 7,
    PP_BetTimerEntityTypeIdentifier = 8,
    PotEntityTypeIdentifier = 9,
    WinVisualEntityTypeIdentifier = 10,
    PlayerPotEntityTypeIdentifier = 11,
    DealerEntityTypeIdentifier = 12,
    LastActionEntityTypeIdentifier = 13,
    BombEntityTypeIdentifier = 14,
    ChanceDeciderGameEntityTypeIdentifier = 15,
    DealerButtonEntityTypeIdentifier = 16

    
}EntityTypeIdentifier;

typedef enum
{
    WaitingTurnState = 0,
    BetTurnState = 1,
    ShowdownTurnState = 2
}TurnState;


typedef enum
{
    Texas_Hold = 0,
    omaha = 1,
    crazy_pineapple = 2,
    mixed_games = 3,
    
} PokerVariantType;



/*
 
 
 https://github.com/zenblender/triplejack/blob/12ec147853f63f94f3886e68a9884c77853c91aa/packets_response.xml#L1479-L1524
 
 The win: packet is sent once at the end of a hand and provides the data
 needed to render the animations and update the players, chips, cards,
 points, etc.
 
 The most important thing to understand is that in poker, you can have
 multiple pots per hand.  Typically this is called the "main pot" and the
 "side pots".  If n players go all in, and the players all have different
 chip stacks, there will be n-1 pots total.  It will help for you to
 understand how side pots work in poker.
 
 The win: packet contains an array of showdown data structures for each pot's
 showdown, since each side pot can have a different winner, a different
 winning hand, a different pot size, etc.  When you receive the win: packet,
 you should cache all of these showdown structures in the client.  You should
 process the first one immediately, and if others remain, save those
 structures / packet "parts".  Then, when you receive a next_win_anim:
 packet, process the saved showdown of the provided index immediately.  This
 means that the server is controlling the timing of the display of each
 showdown, so you don't have to worry about creating your own timers and
 waiting.
 
 For example, if there are 2 pots in a hand, you will receive a win: packet
 with 2 showdowns structures.  Process the first one and save the remaining
 one (which has an index of 1).  Later, you will receive a "next_win_anim:1"
 packet, telling you to process/animate that showdown now.
 
 The showdowns themselves contain a lot of nested data.
 
 This is where the showdown processing starts:
 
 https://github.com/zenblender/triplejack/blob/12ec147853f63f94f3886e68a9884c77853c91aa/flash/PokerRoom.as#L746-L850
 
 Inside that, it will highlight the winning cards in each winning hand:
 
 https://github.com/zenblender/triplejack/blob/12ec147853f63f94f3886e68a9884c77853c91aa/flash/PokerRoom.as#L735-L745
 
 https://github.com/zenblender/triplejack/blob/12ec147853f63f94f3886e68a9884c77853c91aa/flash/PokerTable.as#L530-L574
 
 It will also update the players who are in the showdown (whether they win
 the hand or not):
 
 https://github.com/zenblender/triplejack/blob/12ec147853f63f94f3886e68a9884c77853c91aa/flash/PokerRoom.as#L655-L721
 
 
 */


//------------------------------------------------------
#endif
//------------------------------------------------------