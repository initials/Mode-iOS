
//
@interface MenuState : FlxState
{
    
    FlxEmitter * gibs;
    FlxButton * playButton;
    FlxButton * helpBtn;

    FlxText * title1;
    FlxText * title2;
    BOOL fading;
	CGFloat timer;
    FlxButton * playBtn;
    FlxButton * highScoreBtn;
    
    NSInteger zoom;

}

-(void) onPlay;

@end

