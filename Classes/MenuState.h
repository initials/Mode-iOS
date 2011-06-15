
//
@interface MenuState : FlxState
{
    
    FlxEmitter * gibs;
    FlxButton * playButton;
    FlxText * title1;
    FlxText * title2;
    BOOL fading;
	CGFloat timer;
    FlxButton * playBtn;
    
}

-(void) onPlay;

@end

