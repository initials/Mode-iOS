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

static NSString * ImgButton = @"buttonupGreen.png";

static NSString * ImgGibs = @"spawner_gibs.png";
static NSString * SndHit = @"menu_hit.caf";
static NSString * SndHit2 = @"menu_hit_2.caf";

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
    
    if (FlxG.touches.touchesBegan) {
        [self onPlay];
        return;
    }
    
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
        
        FlxButton * flixelButton = [[[FlxButton alloc] initWithX:FlxG.width/2-40
                                                               y:FlxG.height/3+54
                                                        callback:[FlashFunction functionWithTarget:self
                                                                                            action:@selector(onFlixel)]] autorelease];
        [flixelButton loadGraphic:[FlxSprite spriteWithGraphic:ImgButton]];
        [flixelButton loadText:[FlxText textWithWidth:flixelButton.width
                                                 text:NSLocalizedString(@"flixel.org", @"flixel.org")
                                                 font:nil
                                                 size:8.0]];
        
        [self add:flixelButton];
        FlxButton * dannyButton = [[[FlxButton alloc] initWithX:flixelButton.x
                                                              y:flixelButton.y + 22
                                                       callback:[FlashFunction functionWithTarget:self
                                                                                           action:@selector(onDanny)]] autorelease];
        [dannyButton loadGraphic:[FlxSprite spriteWithGraphic:ImgButton]];
        [dannyButton loadText:[FlxText textWithWidth:dannyButton.width
                                                text:NSLocalizedString(@"music: dannyB", @"music: dannyB")
                                                font:nil
                                                size:8]];
        [self add:dannyButton];       
        
        //        text = [FlxText textWithWidth:80
        //                                 text:@"X+C TO PLAY"
        //                                 font:nil
        //                                 size:32.0];
        //        text.x = FlxG.width/2-40;
        //        text.y = FlxG.height/3+139; 
        //        text.color = 0x729954;
        //        text.alignment = @"center";
        //        [self add:text];
        
        
        playBtn = [[[FlxButton alloc] initWithX:flixelButton.x
                                              y:flixelButton.y + 82
                                       callback:[FlashFunction functionWithTarget:self
                                                                           action:@selector(onPlay)]] autorelease];
        [playBtn loadGraphic:[FlxSprite spriteWithGraphic:ImgButton]];
        
        [playBtn loadText:[FlxText textWithWidth:playBtn.width
                                            text:NSLocalizedString(@"Play", @"Play")
                                            font:nil
                                            size:8]];
        [self add:playBtn];
        
        
    }
    
    
    
    
	
}

- (void) onDanny
{
    [FlxU openURL:@"http://dbsoundworks.com"];
    
}

- (void) onFlixel
{
    [FlxU openURL:@"http://flixel.org"];
    
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

