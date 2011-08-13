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


#import "Bullet.h"

static NSString * ImgBullet = @"bullet.png";
static NSString * SndHit = @"jump.caf";
static NSString * SndShoot = @"shoot.caf";



@implementation Bullet

@synthesize speed;


+ (id) bulletWithOrigin:(CGPoint)Origin
{
	return [[[self alloc] initWithOrigin:Origin] autorelease];
}



- (id) initWithOrigin:(CGPoint)Origin
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgBullet param2:YES param3:NO param4:8 param5:8];
        
        self.width = 6;
        self.height = 6;
        self.offset = CGPointMake(1, 1);
        
        [self addAnimationWithParam1:@"up" param2:[NSMutableArray intArrayWithSize:1 ints:0] param3:0 param4:NO];
        [self addAnimationWithParam1:@"down" param2:[NSMutableArray intArrayWithSize:1 ints:1] param3:0 param4:NO];        
        [self addAnimationWithParam1:@"left" param2:[NSMutableArray intArrayWithSize:1 ints:2] param3:0 param4:NO];        
        [self addAnimationWithParam1:@"right" param2:[NSMutableArray intArrayWithSize:1 ints:3] param3:0 param4:NO];       
        [self addAnimationWithParam1:@"explode" param2:[NSMutableArray intArrayWithSize:5 ints:4,5,6,7,8] param3:23 param4:NO];        
        
        speed = 360;
        
        
	}
	
	return self;	
}


- (void) dealloc
{
    
	[super dealloc];
}

- (void) shootAtLocation:(CGPoint)loc Aim:(uint)aim
{
    [FlxG play:SndShoot];
    self.x = loc.x-width/2,
    self.y = loc.y-height/2-8;
    solid = YES;
    
}

- (void) hitLeftWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
}
- (void) hitRightWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
    
}
- (void) hitBottomWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
    
}
- (void) hitTopWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
    
}

- (void) hitWall
{
    [self play:@"explode"];
    [FlxG play:SndHit];
    
    
}



- (void) update
{	
    if (_curFrame==4) {
        //NSLog(@"Bullet Dead");
        self.velocity = CGPointMake(0, 0);
        self.dead = YES;
        self.x = 900;
        self.y = 900;
        [self play:@"left"];
    }
    
	[super update];
	
}


@end
