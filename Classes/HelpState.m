// This is the license from the Flash version.
// 
// Copyright (c) 2009 Adam 'Atomic' Saltsman
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// NOTE FROM THE AUTHOR: As far as I know, you only have to include
// this license if you are redistributing source code that includes
// the Flixel library.  There is no need (or way, afaik) to include
// it in your compiled flash games and apps!
// 
// NOTE FROM THE iOS PORT CODER: I have only ported this game to iOS.
// I do not claim to own any copyright over this game. All ownership
// stays with the original author.

#import "ButtonAdjustState.h"

#import "MenuState.h"

#import "HelpState.h"

FlxSprite * bgCity;
FlxSprite * bgClouds;

FlxText * headingText;
FlxText * headingTextShadow;

static NSString * ImgButton = @"buttonupGreen.png";
static NSString * SndButtonPress = @"button.caf";
static NSString * ImgButtonPressed = @"buttonPressed.png";



@interface HelpState ()
@end


@implementation HelpState

- (id) init
{
	if ((self = [super init])) {
        self.bgColor = 0xff131c1b;
	}
	return self;
}

- (void) create
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger zoomSize = [prefs integerForKey:@"ZOOM"];
    NSInteger currentZoom = [prefs integerForKey:@"ZOOM_FOR_CURRENT_GAME"];
    
    headingTextShadow = [FlxText textWithWidth:FlxG.width
                                          text:@"Help/About"
                                          font:nil
                                          size:24.0];
	headingTextShadow.color = 0xff000000;
	headingTextShadow.alignment = @"center";
	headingTextShadow.x = 0;
	headingTextShadow.y = 7;
	[self add:headingTextShadow];
    
    
    headingText = [FlxText textWithWidth:FlxG.width
                                    text:@"Help/About"
                                    font:nil
                                    size:24.0];
	headingText.color = 0xffffffff;
	headingText.alignment = @"center";
	headingText.x = 0;
	headingText.y = 5;
	[self add:headingText];
    
    
    
    
    aboutText = [FlxText textWithWidth:FlxG.width
								  text:@"Mode is an open source platformer created by Adam Atomic to showcase the power of the Flixel engine.\n\nPorted by Initials using the Flixel-iOS framework.\nSource code can be found at https://github.com/initials/Mode-iOS\nOriginal Flash game can be found at http://www.flixel.org/mode/\n\nHow To Play\nUse the arrows to move, the buttons to jump and shoot.\nSwipe to shoot up or down. Use downward bullets to help you jump higher.\nDestroy all six spawners to win.\n\n"
								  font:nil
								  size:8];
    //Game needs to be restarted for zoom setting to take effect.
    
	aboutText.color = 0xffffffff;
	aboutText.alignment = @"center";
	aboutText.x = 0;
	aboutText.y = 40;
    //aboutText.velocity = CGPointMake(0, -35);
	[self add:aboutText];
    
    
//    zoomText = [FlxText textWithWidth:FlxG.width
//								  text:@"Zoom=1"
//								  font:nil
//								  size:8];
//	zoomText.color = 0xffffffff;
//	zoomText.alignment = @"right";
//	zoomText.x = 0;
//	zoomText.y = FlxG.height-20;
//	[self add:zoomText];   
//    
//    if (zoomSize==1) {
//        zoomText.text = @"Zoom=1";
//    }
//    else if (zoomSize==2) {
//        zoomText.text = @"Zoom=2";
//
//    }    
    
    
//    if (currentZoom==1) {
//        zoomText.y = FlxG.height-20;
//    }
//    else if (currentZoom==2) {
//        zoomText.y = FlxG.height/2+35;
//        aboutText.velocity=CGPointMake(0, -15);
//
//    }
    
    
    back = [[[FlxButton alloc] initWithX:20
                                       y:FlxG.height-20
                                callback:[FlashFunction functionWithTarget:self
                                                                    action:@selector(onBack)]] autorelease];
    [back loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
    [back loadTextWithParam1:[FlxText textWithWidth:back.width
                                                      text:NSLocalizedString(@"back", @"back")
                                                      font:nil
                                                      size:8.0] param2:[FlxText textWithWidth:back.width
                                                                                         text:NSLocalizedString(@"BACK", @"BACK")
                                                                                         font:nil
                                                                                         size:8.0]  ];
    
    [self add:back];
    
    
    adjustButtonsBtn = [[[FlxButton alloc] initWithX:FlxG.width-20-back.width
                                       y:FlxG.height-20
                                callback:[FlashFunction functionWithTarget:self
                                                                    action:@selector(onButtonAdjust)]] autorelease];
    [adjustButtonsBtn loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
    [adjustButtonsBtn loadTextWithParam1:[FlxText textWithWidth:back.width
                                               text:NSLocalizedString(@"buttons", @"buttons")
                                               font:nil
                                               size:8.0] param2:[FlxText textWithWidth:back.width
                                                                                  text:NSLocalizedString(@"VCP", @"VCP")
                                                                                  font:nil
                                                                                  size:8.0]  ];
    
    [self add:adjustButtonsBtn];
    
    
    
    
//    FlxButton * zoom = [[[FlxButton alloc] initWithX:FlxG.width/1.5
//                                       y:FlxG.height-20
//                                callback:[FlashFunction functionWithTarget:self
//                                                                    action:@selector(onZoom)]] autorelease];
//    [zoom loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
//    [zoom loadTextWithParam1:[FlxText textWithWidth:back.width
//                                               text:NSLocalizedString(@"zoom", @"zoom")
//                                               font:nil
//                                               size:8.0] param2:[FlxText textWithWidth:back.width
//                                                                                  text:NSLocalizedString(@"zoom", @"zoom")
//                                                                                  font:nil
//                                                                                  size:8.0]  ];
//    
//    [self add:zoom];
    
    gamePadText = [FlxText textWithWidth:FlxG.width-40
                                    text:@"No gamepad detected."
                                    font:nil
                                    size:8.0];
    
	gamePadText.color = 0xffffffff; //0xff312f2f
	gamePadText.alignment = @"center";
	gamePadText.x = 20;
	gamePadText.y = FlxG.height - 60;
	[self add:gamePadText];
    
    
	
}

- (void) dealloc
{
	[super dealloc];
}


- (void) update
{
    
    if (FlxG.touches.iCadeLeftBegan  || FlxG.touches.swipedDown ) {
        
        if (FlxG.gamePad==0) {
            FlxG.gamePad=1;
        }
        else if (FlxG.gamePad==1) {
            FlxG.gamePad=2;
        }
        else if (FlxG.gamePad==2) {
            FlxG.gamePad=3;
        }
        else if (FlxG.gamePad==3) {
            FlxG.gamePad=0;
        }
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setInteger:FlxG.gamePad forKey:@"GAME_PAD"];
        [prefs synchronize];
        
    }
    
    if (FlxG.touches.iCadeRightBegan || FlxG.touches.swipedUp) {
        
        if (FlxG.gamePad==0) {
            FlxG.gamePad=3;
        }
        else if (FlxG.gamePad==1) {
            FlxG.gamePad=0;
        }
        else if (FlxG.gamePad==2) {
            FlxG.gamePad=1;
        }
        else if (FlxG.gamePad==3) {
            FlxG.gamePad=2;
        }
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setInteger:FlxG.gamePad forKey:@"GAME_PAD"];
        [prefs synchronize];
        
    }    
    
    
    
    if (FlxG.gamePad==0) {
        gamePadText.text=@"Touch screen [No external gamepad]";
        
    }
    else if (FlxG.gamePad==1) {
        gamePadText.text=@"Gamepad button layout: iCade";
        
    }
    else if (FlxG.gamePad==2) {
        gamePadText.text=@"Gamepad button layout: iControlPad v2.0";
    }    
    else if (FlxG.gamePad==3) {
        gamePadText.text=@"Gamepad button layout: iControlPad v2.1a";
    }      
    
    
    
    
	[super update];
    
    if (FlxG.touches.iCadeABegan) {
        [self onBack];
        return;
    }
	
}

- (void) onBack
{
    [FlxG play:SndButtonPress];
	FlxG.state = [[[MenuState alloc] init] autorelease];
    return;
}

- (void) onButtonAdjust
{
    [FlxG play:SndButtonPress];
	FlxG.state = [[[ButtonAdjustState alloc] init] autorelease];
    return;
}

- (void) onZoom
{
    [FlxG play:SndButtonPress];
    
    //Can't zoom in game?
//    FlxGame * game = [FlxG game];
//    game.zoom
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger zoom = [prefs integerForKey:@"ZOOM"];

    if (zoom==1) {
        zoom=2;
        zoomText.text = @"Zoom=2";
    } else if (zoom==2) {
        zoom=1;
        zoomText.text = @"Zoom=1";
    }
    
    [prefs setInteger:zoom forKey:@"ZOOM"];
    
	[prefs synchronize];
    
    
    return;
}


@end

