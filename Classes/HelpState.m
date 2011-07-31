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

#import "HelpState.h"

int c; 

FlxSprite * bgCity;
FlxSprite * bgClouds;

FlxText * headingText;
FlxText * headingTextShadow;

static NSString * ImgButton = @"buttonupGreen.png";



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
    
    headingTextShadow = [FlxText textWithWidth:FlxG.width
                                          text:@"About"
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
								  text:@"Mode is an open source platformer created by Adam Atomic to showcase the power of the Flixel engine.\n\nPorted by Initials using the Flixel-iOS framework.\nSource code can be found at https://github.com/initials/Mode-iOS\nOriginal Flash game can be found at http://www.flixel.org/mode/\n\nHow To Play\nUse the arrows to move, the buttons to jump and shoot.\nSwipe to shoot up or down. Use downward bullets to help you jump higher.\nDestroy all six spawners to win."
								  font:nil
								  size:8];
	aboutText.color = 0xffffffff;
	aboutText.alignment = @"center";
	aboutText.x = 0;
	aboutText.y = 40;
    //aboutText.velocity = CGPointMake(0, -35);
	[self add:aboutText];
    
    back = [[[FlxButton alloc] initWithX:20
                                       y:FlxG.height-20
                                callback:[FlashFunction functionWithTarget:self
                                                                    action:@selector(onBack)]] autorelease];
    [back loadGraphic:[FlxSprite spriteWithGraphic:ImgButton]];
    [back loadText:[FlxText textWithWidth:back.width
                                     text:NSLocalizedString(@"Back", @"Back")
                                     font:nil
                                     size:8.0]];
    
    [self add:back];
    
	
}

- (void) dealloc
{
	[super dealloc];
}


- (void) update
{
    
	[super update];
	
}

- (void) onBack
{
	FlxG.state = [[[MenuState alloc] init] autorelease];
    return;
}


@end

