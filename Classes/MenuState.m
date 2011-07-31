//
//  MenuState.m
//  Canabalt
//
//  Copyright Semi Secret Software 2009-2010. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE..
//

#import "MenuState.h"

#import "PlayState.h"

#import "HelpState.h"

//#import "HighScoreState.h"

//#import "AchievementState.h"

static NSString * ImgButton = @"buttonupGreen.png";
static NSString * ImgButtonPressed = @"buttonPressed.png";

static NSString * ImgGibs = @"spawner_gibs.png";
static NSString * SndHit = @"menu_hit.caf";
static NSString * SndHit2 = @"menu_hit_2.caf";

static NSString * SndButtonPress = @"button.caf";

static FlxEmitter * emitter = nil;



@interface MenuState ()
@end


@implementation MenuState

- (id) init
{
	if ((self = [super init])) {
		self.bgColor = 0xff131c1b;
	}
	return self;
}

- (void) create
{
    //Tracks number of times the game has been played.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSInteger
    NSInteger numberOfPlays = [prefs integerForKey:@"NUMBER_OF_PLAYS"];
    zoom = [prefs integerForKey:@"ZOOM_FOR_CURRENT_GAME"];
    numberOfPlays ++;
    [prefs setInteger:numberOfPlays forKey:@"NUMBER_OF_PLAYS"];
    
	[prefs synchronize];
    
    //All the bits that blow up when the text smooshes together
    gibs = [[FlxEmitter alloc] init];
    gibs.delay = 0.02/3;
    gibs.width = 100;
    gibs.height=30;
    gibs.minParticleSpeed = CGPointMake(-100,
                                        -200);
    gibs.maxParticleSpeed = CGPointMake(100,
                                        -20);
    gibs.minRotation = -720;
    gibs.maxRotation = 720;
    gibs.gravity = 100;
    gibs.particleDrag = CGPointMake(0, 0);
    gibs.x = FlxG.width/2-50;
    gibs.y = FlxG.height/2-10;
    emitter = [gibs retain];
    [self add:emitter];
    [gibs createSprites:ImgGibs quantity:100 bakedRotations:NO
               multiple:YES collide:0.0 modelScale:1.0];
    
    title1 = [FlxText textWithWidth:64
                               text:@"mo"
                               font:nil
                               size:32.0];
    title1.color = 0x3a5c39;
    title1.alignment = @"center";
    title1.x = FlxG.width + 16;
    title1.y = FlxG.height/3-40;
    title1.velocity = CGPointMake(-FlxG.width, 0);
    title1.antialiasing = YES;
    
    [self add:title1];
    //the letters "de"
    
    title2 = [FlxText textWithWidth:title1.width
                               text:@"de"
                               font:nil
                               size:32.0];
    title2.color = title1.color;
    title2.alignment = @"center";
    title2.x = -60;
    title2.y = title1.y;
    title2.velocity = CGPointMake(FlxG.width, 0);
    title2.antialiasing = YES;
    [self add:title2];
    
    fading = false;
    timer = 0;
    
    
}

- (void) dealloc
{
	[super dealloc];
}


- (void) update
{
    
//    if (FlxG.touches.touchesBegan) {
//        [self onPlay];
//        return;
//    }
    
	[super update];
    
    if(title2.x > title1.x + title1.width - 4)
    {
        //Once mo and de cross each other, fix their positions
        title2.x = title1.x + title1.width - 4;
        title1.velocity = CGPointMake(0, 0);
        title2.velocity = CGPointMake(0, 0);
        
        //Then, play a cool sound, change their color, and blow up pieces everywhere
        [[FlxG quake] startWithIntensity:0.005 duration:1];
        [[FlxG flash] startWithParam1:0xffffffff param2:0.5];
        [FlxG play:SndHit];
        title1.color = 0xd8eba2;
        title2.color = 0xd8eba2;
        [gibs startWithParam1:YES param2:5 param3:0];
        title1.angle = [FlxU random]*30-15;
        title2.angle = [FlxU random]*30-15;
        
        //Then we're going to add the text and buttons and things that appear
        //If we were hip we'd use our own button animations, but we'll just recolor
        //the stock ones for now instead.
        
        FlxText * text = [FlxText textWithWidth:FlxG.width
                                           text:@"by Adam Atomic"
                                           font:nil
                                           size:16.0];
        text.color = 0x3a5c39;
        text.alignment = @"center";
        text.x = 0;
        text.y = FlxG.height/3;        
        [self add:text];
        
        CGFloat flixelButtonX;
        CGFloat flixelButtonY;
        CGFloat dannyX, dannyY, helpX, helpY, playX, playY;

        
        if (zoom==1) {
            flixelButtonX=FlxG.width/2-40;
            flixelButtonY=FlxG.height/3+54;
            dannyX=flixelButtonX;
            dannyY=flixelButtonY+22;
            helpX=flixelButtonX;
            helpY=flixelButtonY+44;
            playX=flixelButtonX;
            playY=flixelButtonY+100;
        }
        else if (zoom==2) {
            flixelButtonX=FlxG.width-100;
            flixelButtonY=FlxG.height/3+24;
            dannyX=20;
            dannyY=flixelButtonY;
            helpX=FlxG.width/2-40;
            helpY=flixelButtonY+22;
            playX=FlxG.width/2-40;
            playY=flixelButtonY+44;
        }
        
        FlxButton * flixelButton = [[[FlxButton alloc] initWithX:flixelButtonX
                                                               y:flixelButtonY
                                                        callback:[FlashFunction functionWithTarget:self
                                                                                            action:@selector(onFlixel)]] autorelease];
        [flixelButton loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
        [flixelButton loadTextWithParam1:[FlxText textWithWidth:flixelButton.width
                                                 text:NSLocalizedString(@"flixel.org", @"flixel.org")
                                                 font:nil
                                                           size:8.0] param2:[FlxText textWithWidth:flixelButton.width
                                                                                              text:NSLocalizedString(@"FLIXEL.ORG", @"FLIXEL.ORG")
                                                                                              font:nil
                                                                                              size:8.0]  ];
        
        [self add:flixelButton];
        FlxButton * dannyButton = [[[FlxButton alloc] initWithX:dannyX
                                                              y:dannyY
                                                       callback:[FlashFunction functionWithTarget:self
                                                                                           action:@selector(onDanny)]] autorelease];
        [dannyButton loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
        [dannyButton loadTextWithParam1:[FlxText textWithWidth:flixelButton.width
                                                           text:NSLocalizedString(@"Music: DannyB", @"Music: DannyB")
                                                           font:nil
                                                           size:8.0] param2:[FlxText textWithWidth:flixelButton.width
                                                                                              text:NSLocalizedString(@"MUSIC: DANNYB", @"MUSIC: DANNYB")
                                                                                              font:nil
                                                                                              size:8.0]  ];
        [self add:dannyButton];       
        
        helpBtn = [[[FlxButton alloc] initWithX:helpX
                                              y:helpY
                                                       callback:[FlashFunction functionWithTarget:self
                                                                                           action:@selector(onHelp)]] autorelease];
        [helpBtn loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed] ];
        [helpBtn loadTextWithParam1:[FlxText textWithWidth:flixelButton.width
                                                          text:NSLocalizedString(@"help/about", @"help/about")
                                                          font:nil
                                                          size:8.0] param2:[FlxText textWithWidth:flixelButton.width
                                                                                             text:NSLocalizedString(@"HELP/ABOUT", @"HELP/ABOUT")
                                                                                             font:nil
                                                                                             size:8.0]  ];
        [self add:helpBtn];
        
//        highScoreBtn = [[[FlxButton alloc] initWithX:flixelButton.x
//                                              y:flixelButton.y + 66
//                                       callback:[FlashFunction functionWithTarget:self
//                                                                           action:@selector(onHighScore)]] autorelease];
//        [highScoreBtn loadGraphic:[FlxSprite spriteWithGraphic:ImgButton]];
//        [highScoreBtn loadText:[FlxText textWithWidth:dannyButton.width
//                                            text:NSLocalizedString(@"Achievements", @"Achievements")
//                                            font:nil
//                                            size:8]];
//        [self add:highScoreBtn];
        
        
        
        playBtn = [[[FlxButton alloc] initWithX:playX
                                              y:playY
                                       callback:[FlashFunction functionWithTarget:self
                                                                           action:@selector(onPlay)]] autorelease];
        [playBtn loadGraphicWithParam1:[FlxSprite spriteWithGraphic:ImgButton] param2:[FlxSprite spriteWithGraphic:ImgButtonPressed]];
        
        [playBtn loadTextWithParam1:[FlxText textWithWidth:playBtn.width
                                            text:NSLocalizedString(@"Play", @"Play")
                                            font:nil
                                                      size:8] param2:[FlxText textWithWidth:playBtn.width
                                                                                       text:NSLocalizedString(@"PLAY", @"PLAY")
                                                                                       font:nil
                                                                                       size:8]];
        [self add:playBtn];
        
        
        
        
    }
    
    
    
    
	
}

- (void) onDanny
{
    [FlxG play:SndButtonPress];
    [FlxU openURL:@"http://dbsoundworks.com"];
    
}

- (void) onFlixel
{
    [FlxG play:SndButtonPress];
    [FlxU openURL:@"http://flixel.org"];
    
}

- (void) onHelp
{
    [FlxG play:SndButtonPress];
    helpBtn.visible = NO;
	FlxG.state = [[[HelpState alloc] init] autorelease];
    return;
    
}

- (void) onHighScore
{
    highScoreBtn.visible = NO;
	//FlxG.state = [[[AchievementState alloc] init] autorelease];
    return;
    
}

- (void) onPlay
{
    playBtn.visible = NO;
    [FlxG play:SndHit2];
    FlxG.level = 1;
	FlxG.state = [[[PlayState alloc] init] autorelease];
    return;
    
}



@end

