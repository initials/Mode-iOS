//#import <GameKit/GameKit.h>
//#import "GameCenterManager.h"
//@class GameCenterManager;

//
@interface VictoryState : FlxState

{
    //GameCenterManager * gameCenterManager;
    
    CGFloat _timer;
    BOOL _fading;
    FlxEmitter * gibs;
    FlxText * text;
    
}

//@property (nonatomic, retain) GameCenterManager *gameCenterManager;

@end

