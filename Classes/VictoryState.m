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

#import "VictoryState.h"

#import "PlayState.h"

static NSString * ImgGibs = @"spawner_gibs.png";
static NSString * SndMenu = @"menu_hit_2.caf";

static FlxEmitter * emitter = nil;



@interface VictoryState ()
@end


@implementation VictoryState

- (id) init
{
	if ((self = [super init])) {
		self.bgColor = 0xff131c1b;
	}
	return self;
}

- (void) create
{
    _timer = 0;
    _fading = false;
    
    //Gibs emitted upon death
    gibs = [[FlxEmitter alloc] init];
    gibs.delay = 0.02/3;
    gibs.width = FlxG.width;
    gibs.height=0;
    gibs.minParticleSpeed = CGPointMake(-10,
                                        0);
    gibs.maxParticleSpeed = CGPointMake(10,
                                        100);
    gibs.minRotation = -360;
    gibs.maxRotation = 360;
    gibs.gravity = 150;
    gibs.particleDrag = CGPointMake(0, 0);
    gibs.x = 0;
    gibs.y = 0;
    emitter = [gibs retain];
    [self add:emitter];
    [gibs createSprites:ImgGibs quantity:230 bakedRotations:NO
               multiple:YES collide:0.0 modelScale:1.0];
    [gibs startWithParam1:YES param2:3 param3:0];
    
    text = [FlxText textWithWidth:FlxG.width
                             text:[[NSString stringWithFormat:@"VICTORY\nSCORE: %d", FlxG.score ] retain]
                             font:nil
                             size:16.0];
    text.color = 0xd8eba2;
    text.alignment = @"center";
    text.x = 0;
    text.y = FlxG.height/2-35;
    
    [self add:text];
    
    
}

- (void) dealloc
{
	[super dealloc];
}


- (void) update
{
    
    
    
	[super update];
    
    
    _timer += FlxG.elapsed;
    if((_timer > 2) && ((_timer > 10) || FlxG.touches.touchesEnded ))
    {
        _fading = true;
        [FlxG play:SndMenu];
        //FlxG.fade(0xff131c1b,2,onPlay);
        FlxG.level = 1;
        FlxG.state = [[[PlayState alloc] init] autorelease];
        return;
    }
    
    
    
	
}



@end

