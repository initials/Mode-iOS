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

#import "HelpState.h"

static NSString * ImgButtonArrow = @"buttonArrow.png";
static NSString * ImgButtonA = @"buttonA.png";
static NSString * ImgButtonB = @"buttonB.png";
static NSString * ImgButtonOutline = @"buttonArea.png";

static Boolean buttonLeftMoving = NO;
static Boolean buttonRightMoving = NO;
static Boolean button1Moving = NO;
static Boolean button2Moving = NO;

static NSString * ImgButton = @"buttonupGreen.png";
static NSString * SndButtonPress = @"button.caf";
static NSString * ImgButtonPressed = @"buttonPressed.png";



@interface ButtonAdjustState ()
@end


@implementation ButtonAdjustState

//@synthesize gameCenterManager;

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
    NSInteger LAX = [prefs integerForKey:@"LEFT_ARROW_POSITION_X"];
    NSInteger LAY = [prefs integerForKey:@"LEFT_ARROW_POSITION_Y"];
    NSInteger RAX = [prefs integerForKey:@"RIGHT_ARROW_POSITION_X"];
    NSInteger RAY = [prefs integerForKey:@"RIGHT_ARROW_POSITION_Y"];
    
    NSInteger B1X = [prefs integerForKey:@"BUTTON_1_POSITION_X"];
    NSInteger B1Y = [prefs integerForKey:@"BUTTON_1_POSITION_Y"];
    NSInteger B2X = [prefs integerForKey:@"BUTTON_2_POSITION_X"];
    NSInteger B2Y = [prefs integerForKey:@"BUTTON_2_POSITION_Y"];
    
    //add buttons for the virtual control pad
    
    buttonLeft  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonArrow];
    buttonLeft.x = LAX;
    buttonLeft.y = LAY;
	[self add:buttonLeft];

    buttonRight  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonArrow];
    buttonRight.x = RAX;
    buttonRight.y = RAY;
    buttonRight.angle = 180;
	[self add:buttonRight];
    
    button1  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonA];
    button1.x = B1X;
    button1.y = B1Y;
	[self add:button1];
    
    button2  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonB];
    button2.x = B2X;
    button2.y = B2Y;
	[self add:button2]; 
    
    buttonLeftOutline  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonOutline];
    buttonLeftOutline.x = LAX;
    buttonLeftOutline.y = LAY;
    buttonLeftOutline.scrollFactor = CGPointMake(0, 0);
	[self add:buttonLeftOutline];
    
    buttonRightOutline  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonOutline];
    buttonRightOutline.x = RAX;
    buttonRightOutline.y = RAY;
    buttonRightOutline.angle = 180;
    buttonRightOutline.scrollFactor = CGPointMake(0, 0);
	[self add:buttonRightOutline];
    
    button1Outline  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonOutline];
    button1Outline.x = B1X;
    button1Outline.y = B1Y;
    button1Outline.scrollFactor = CGPointMake(0, 0);
	[self add:button1Outline];
    
    button2Outline  = [FlxSprite spriteWithX:80 y:80 graphic:ImgButtonOutline];
    button2Outline.x = B2X;
    button2Outline.y = B2Y;
    button2Outline.scrollFactor = CGPointMake(0, 0);
	[self add:button2Outline]; 
    
    buttonRightText = [FlxText textWithWidth:120
                                        text:@""
                                        font:nil
                                        size:8.0];
    buttonRightText.color = 0x3a5c39;
    buttonRightText.alignment = @"left";
    buttonRightText.x = RAX;
    buttonRightText.y = RAY;    
    [self add:buttonRightText];
    
    buttonLeftText = [FlxText textWithWidth:120
                                       text:@""
                                       font:nil
                                       size:8.0];
    buttonLeftText.color = 0x3a5c39;
    buttonLeftText.alignment = @"left";
    buttonLeftText.x = LAX;
    buttonLeftText.y = LAY;    
    [self add:buttonLeftText];
    
    button1Text = [FlxText textWithWidth:120
                                        text:@""
                                        font:nil
                                        size:8.0];
    button1Text.color = 0x3a5c39;
    button1Text.alignment = @"left";
    button1Text.x = B1X;
    button1Text.y = B1Y;    
    [self add:button1Text];
    
    button2Text = [FlxText textWithWidth:120
                                    text:@""
                                    font:nil
                                    size:8.0];
    button2Text.color = 0x3a5c39;
    button2Text.alignment = @"left";
    button2Text.x = B2X;
    button2Text.y = B2Y;    
    [self add:button2Text];   
    
    
    cancelBtn = [[[FlxButton alloc] initWithX:20
                                       y:10
                                callback:[FlashFunction functionWithTarget:self
                                                                    action:@selector(cancel)]] autorelease];
    [cancelBtn loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
    [cancelBtn loadTextWithParam1:[FlxText textWithWidth:cancelBtn.width
                                               text:NSLocalizedString(@"cancel", @"cancel")
                                               font:nil
                                               size:8.0] param2:[FlxText textWithWidth:cancelBtn.width
                                                                                  text:NSLocalizedString(@"CANCEL", @"CANCEL")
                                                                                  font:nil
                                                                                  size:8.0]  ];
    
    [self add:cancelBtn];
    
    
    okBtn = [[[FlxButton alloc] initWithX:FlxG.width-20-cancelBtn.width
                                                   y:10
                                            callback:[FlashFunction functionWithTarget:self
                                                                                action:@selector(ok)]] autorelease];
    [okBtn loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
    [okBtn loadTextWithParam1:[FlxText textWithWidth:cancelBtn.width
                                                           text:NSLocalizedString(@"ok", @"ok")
                                                           font:nil
                                                           size:8.0] param2:[FlxText textWithWidth:cancelBtn.width
                                                                                              text:NSLocalizedString(@"OK", @"OK")
                                                                                              font:nil
                                                                                              size:8.0]  ];
    
    [self add:okBtn];
    
    resetBtn = [[[FlxButton alloc] initWithX:FlxG.width/2-cancelBtn.width/2
                                        y:10
                                 callback:[FlashFunction functionWithTarget:self
                                                                     action:@selector(onReset)]] autorelease];
    [resetBtn loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
    [resetBtn loadTextWithParam1:[FlxText textWithWidth:cancelBtn.width
                                                text:NSLocalizedString(@"reset", @"reset")
                                                font:nil
                                                size:8.0] param2:[FlxText textWithWidth:cancelBtn.width
                                                                                   text:NSLocalizedString(@"RESET", @"RESET")
                                                                                   font:nil
                                                                                   size:8.0]  ];
    
    [self add:resetBtn];
    
    
    //disable swipes so finger tracking works.
    
    FlxGame * game = [FlxG game];
    [game enableSwipeRecognizer:NO];
    
    
    
}

- (void) dealloc
{
	[super dealloc];
}


- (void) update
{
    
    if (FlxG.touches.touchesEnded) {
        buttonLeftMoving=NO;
        buttonRightMoving=NO;
        button1Moving=NO;
        button2Moving=NO;
    }
    
    if (FlxG.touches.touchesBegan && [buttonLeft overlapsPointWithParam1:FlxG.touches.touchPoint.x param2:FlxG.touches.touchPoint.y]) {
        buttonLeftMoving=YES;
        buttonRightMoving=NO;
        button1Moving=NO;
        button2Moving=NO;
        

    }
    
    else if (FlxG.touches.touchesBegan && [buttonRight overlapsPointWithParam1:FlxG.touches.touchPoint.x param2:FlxG.touches.touchPoint.y]) {
        buttonRightMoving=YES;
        
        buttonLeftMoving=NO;
        button1Moving=NO;
        button2Moving=NO;

        
    }
    
    else if (FlxG.touches.touchesBegan && [button1 overlapsPointWithParam1:FlxG.touches.touchPoint.x param2:FlxG.touches.touchPoint.y]) {
        button1Moving=YES;
        
        buttonLeftMoving=NO;
        buttonRightMoving=NO;
        button2Moving=NO;

        
    }
    
    else if (FlxG.touches.touchesBegan && [button2 overlapsPointWithParam1:FlxG.touches.touchPoint.x param2:FlxG.touches.touchPoint.y]) {
        button2Moving=YES;
        
        buttonLeftMoving=NO;
        buttonRightMoving=NO;
        button1Moving=NO;
        
        
    }
    
    
    
    if (buttonLeftMoving) {
        buttonLeft.x=FlxG.touches.touchPoint.x-buttonLeft.width/2;
        buttonLeft.y=FlxG.touches.touchPoint.y-buttonLeft.height/2;
        if (buttonLeft.x<0) {
            buttonLeft.x=0;
        }
        if (buttonLeft.y<0) {
            buttonLeft.y=0;
        }
        if (buttonLeft.x>FlxG.width-buttonLeft.width) {
            buttonLeft.x=FlxG.width-buttonLeft.width;
        }
        if (buttonLeft.y>FlxG.height-buttonLeft.height) {
            buttonLeft.y=FlxG.height-buttonLeft.height;
        }
        
        
    }
    else if (buttonRightMoving) {
        buttonRight.x=FlxG.touches.touchPoint.x-buttonRight.width/2;
        buttonRight.y=FlxG.touches.touchPoint.y-buttonRight.height/2;
        if (buttonRight.x<0) {
            buttonRight.x=0;
        }
        if (buttonRight.y<0) {
            buttonRight.y=0;
        }
        if (buttonRight.x>FlxG.width-buttonRight.width) {
            buttonRight.x=FlxG.width-buttonRight.width;
        }
        if (buttonRight.y>FlxG.height-buttonRight.height) {
            buttonRight.y=FlxG.height-buttonRight.height;
        }
    }    
    else if (button1Moving) {
        button1.x=FlxG.touches.touchPoint.x-button1.width/2;
        button1.y=FlxG.touches.touchPoint.y-button1.height/2;
        if (button1.x<0) {
            button1.x=0;
        }
        if (button1.y<0) {
            button1.y=0;
        }
        if (button1.x>FlxG.width-button1.width) {
            button1.x=FlxG.width-button1.width;
        }
        if (button1.y>FlxG.height-button1.height) {
            button1.y=FlxG.height-button1.height;
        }
    }    
    else if (button2Moving) {
        button2.x=FlxG.touches.touchPoint.x-button2.width/2;
        button2.y=FlxG.touches.touchPoint.y-button2.height/2;
        if (button2.x<0) {
            button2.x=0;
        }
        if (button2.y<0) {
            button2.y=0;
        }
        if (button2.x>FlxG.width-button2.width) {
            button2.x=FlxG.width-button2.width;
        }
        if (button2.y>FlxG.height-button2.height) {
            button2.y=FlxG.height-button2.height;
        }
    }
    

    

        
    
    
    
    
    buttonLeftText.x=buttonLeft.x-5;
    buttonLeftText.y=buttonLeft.y-20;
    NSString *intString = [NSString stringWithFormat:@"Pos=%.02f,%.02f", buttonLeft.x, buttonLeft.y];
    buttonLeftText.text = intString ;
    
    
    buttonRightText.x=buttonRight.x-5;
    buttonRightText.y=buttonRight.y-20;
    NSString *intString2 = [NSString stringWithFormat:@"Pos=%.02f,%.02f", buttonRight.x, buttonRight.y];
    buttonRightText.text = intString2 ;

    button1Text.x=button1.x-5;
    button1Text.y=button1.y-20;
    NSString *intString3 = [NSString stringWithFormat:@"Pos=%.02f,%.02f", button1.x, button1.y];
    button1Text.text = intString3 ;
    
    button2Text.x=button2.x-5;
    button2Text.y=button2.y-20;
    NSString *intString4 = [NSString stringWithFormat:@"Pos=%.02f,%.02f", button2.x, button2.y];
    button2Text.text = intString4 ;  
    
    
    buttonLeftOutline.x=buttonLeft.x;
    buttonLeftOutline.y=buttonLeft.y;
    buttonRightOutline.x=buttonRight.x;
    buttonRightOutline.y=buttonRight.y;    
    button1Outline.x=button1.x;
    button1Outline.y=button1.y;
    button2Outline.x=button2.x;
    button2Outline.y=button2.y;    
    
//      Buttons Overlaps???
    
//    if (    [buttonLeft overlaps:buttonRight] ||
//        [buttonLeft overlaps:button1] ||
//        [buttonLeft overlaps:button2] ||
//        [button1 overlaps:buttonRight] ||
//        [button2 overlaps:buttonRight] ||
//        [button1 overlaps:button2] ) {
//        NSLog(@"lapels");
//    }
    
    
	[super update];
    
    
    
    
	
}

- (void) setGlobalButtons
{

    
    FlxG.leftArrowPosition = CGPointMake(buttonLeft.x,buttonLeft.y);
    FlxG.rightArrowPosition = CGPointMake(buttonRight.x, buttonRight.y);
    
    FlxG.button1Position = CGPointMake(button1.x, button2.y);
    FlxG.button2Position = CGPointMake(button2.x, button2.y);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:buttonLeft.x forKey:@"LEFT_ARROW_POSITION_X"];
    [prefs setInteger:buttonLeft.y forKey:@"LEFT_ARROW_POSITION_Y"];
    
    [prefs setInteger:buttonRight.x forKey:@"RIGHT_ARROW_POSITION_X"];
    [prefs setInteger:buttonRight.y forKey:@"RIGHT_ARROW_POSITION_Y"];
    
    [prefs setInteger:button1.x forKey:@"BUTTON_1_POSITION_X"];
    [prefs setInteger:button1.y forKey:@"BUTTON_1_POSITION_Y"];
    
    [prefs setInteger:button2.x forKey:@"BUTTON_2_POSITION_X"];
    [prefs setInteger:button2.y forKey:@"BUTTON_2_POSITION_Y"];    

	[prefs synchronize];
    
    
    
}

- (void) ok {
    [self setGlobalButtons];
    
    [FlxG play:SndButtonPress];
	FlxG.state = [[[HelpState alloc] init] autorelease];
    return;
}

- (void) cancel {
    [FlxG play:SndButtonPress];
	FlxG.state = [[[HelpState alloc] init] autorelease];
    return;
}

- (void) onReset {
    [FlxG play:SndButtonPress];
    
    buttonLeft.y=buttonRight.y=button1.y=button2.y=240;
    
    buttonLeft.x=0;
    buttonRight.x=80;
    button1.x=FlxG.width-160;
    button2.x=FlxG.width-80;
    
    
    
    
    [self setGlobalButtons];
    
}



@end

