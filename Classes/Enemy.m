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

#import "Enemy.h"
#import "Player.h"
#import "EnemyBullet.h"

@implementation Enemy

static NSString * ImgBot = @"bot.png";
//static NSString * ImgJet = @"jet.png";
static NSString * SndExplode = @"asplode.caf";
static NSString * SndHit = @"hit.caf";
//static NSString * SndJet = @"jet.caf";

static int bulletIndex;


//We use this number to figure out how fast the ship is flying
CGFloat _thrust;

//A special effect - little poofs shoot out the back of the ship
//protected var _jets:FlxEmitter;

//These are "timers" - numbers that count down until we want something interesting to happen.
CGFloat _timer;		//Helps us decide when to fly and when to stop flying.
CGFloat _shotClock;	//Helps us decide when to shoot.


+ (id) enemyWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs ThePlayer:(Player *)player
{
	return [[[self alloc] initWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs ThePlayer:(Player *)player] autorelease];
}

- (id) initWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs ThePlayer:(Player *)player {
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgBot param2:YES param3:NO param4:16 param5:16];
        
        _player = player;
        _bullets = bullets;
        _gibs = gibs;
        
        bulletIndex=0;
        
        angle = [self angleTowardPlayer];
        health = 2;	//Enemies take 2 shots to kill
        _timer = 0;
        _shotClock = 0;
        
        //We want the enemy's "hit box" or actual size to be
        //smaller than the enemy graphic itself, just by a few pixels.
        self.width = 12;
        self.height = 12;
        self.offset = CGPointMake(2, 2);
        
        // Here is the flash code for having a particle system inside a FlxSprite.
        // I can't get it to work on iOS. It's probably the last thing that doesn't work on iOS
        // Can anyone help?
        //        
        //        //Here we are setting up the jet particles
        //        // that shoot out the back of the ship.
        //        _jets = new FlxEmitter();
        //        _jets.setRotation();
        //        _jets.makeParticles(ImgJet,15,0,false,0);
        
        //These parameters help control the ship's
        //speed and direction during the update() loop.
        maxAngular = 120;
        angularDrag = 400;
        self.drag = CGPointMake(3.5, 0);
        _thrust = 0;
        
	}
	
	return self;	
    
}


- (void) resetSwarm:(int)type xPos:(int)xpos yPos:(int)ypos Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs ThePlayer:(Player *)player
{
    //_player = player;
    //_bullets = bullets;
    //_gibs = gibs;
    self.dead = NO;
    self.x = xpos - self.width/2;
    self.y = ypos - self.height/2;
    angle = 90 + [self angleTowardPlayer];
    health = 2;	//Enemies take 2 shots to kill
    _timer = 0;
    _shotClock = 0;
    [self flicker:-1];
    
}




- (id) initWithOrigin:(CGPoint)Origin
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgBot param2:YES param3:NO param4:16 param5:16];
        
	}
	
	return self;	
}


- (void) dealloc
{
	
	[super dealloc];
}

- (CGFloat) angleTowardPlayer
{
    CGPoint pointA = CGPointMake(self.x, self.y);
    CGPoint pointB = CGPointMake(_player.x, _player.y);
    return [FlxU getAngleBetweenPointsWithParam1:pointA param2:pointB];
    
    
}


- (void) hurt:(float)Damage
{
    health -= Damage;
    [self flicker:0.2];
    FlxG.score += 10;
    
    if (health <= 0 && self.dead == NO) {
        [FlxG play:SndExplode];
        [self flicker:0];
        //_jets.kill();
        _gibs.x = self.x;
        _gibs.y = self.y;
        [_gibs startWithParam1:YES param2:3 param3:0];
        FlxG.score += 200;
        
        dead = YES;
        visible = NO;
        x = -100;
        y = -100;
    }
    else {
        [FlxG play:SndHit];
        
    }
}
- (void) update
{
    //NSLog(@" DEAD? %d", self.dead);
    if (!self.dead) {
        //Then, rotate toward that angle.
        //We could rotate instantly toward the player by simply calling:
        //angle = angleTowardPlayer();
        //However, we want some less predictable, more wobbly behavior.
        
        float da = [self angleTowardPlayer];
        if(da < angle) {
            angularAcceleration = -angularDrag;
            //NSLog(@"less than angle, da %f", da);
        }
        else if(da > angle) {
            angularAcceleration = angularDrag;
            //NSLog(@"more than angle da, %f", da);
        }
        else {
            angularAcceleration = 0;
            //NSLog(@"other");
        }
        
        //Figure out if we want the jets on or not.
        _timer += FlxG.elapsed;
        if(_timer > 8)
            _timer = 0;
        jetsOn = _timer < 6;    
        
        _thrust = [FlxU computeVelocityWithParam1:_thrust param2:(jetsOn?90:0) param3:self.drag.x param4:60];
        
        self.velocity = [FlxU rotatePointWithParam1:0 param2:_thrust param3:0 param4:0 param5:angle];
        
    }
    
    //Shooting - three shots every few seconds
    if(abs(self.x -_player.x )  < 150 &&  abs(self.y -_player.y) < 150 && !_player.dead)
    {
        BOOL shoot = NO;
        CGFloat os = _shotClock;
        _shotClock += FlxG.elapsed;
        if((os < 4.0) && (_shotClock >= 4.0))
        {
            _shotClock = 0;
            shoot = true;
        }
        else if((os < 3.5) && (_shotClock >= 3.5))
            shoot = true;
        else if((os < 3.0) && (_shotClock >= 3.0))
            shoot = true;
        
        //If we rolled over one of those time thresholds,
        //shoot a bullet out along the angle we're currently facing.
        if(shoot)
        {
            //First, recycle a bullet from the bullet pile.
            //If there are none, recycle will automatically create one for us.
            EnemyBullet * eb1 = [_bullets.members objectAtIndex:bulletIndex];
            
            bulletIndex++;
            if (bulletIndex>=_bullets.members.length) {
                bulletIndex = 0;	
            }
            
            
            //Then, shoot it from our midpoint out along our angle.
            float angleTowardPlayer = [self angleTowardPlayer];
            
            CGPoint here = CGPointMake(self.x+self.width/2, self.y+self.height/2);
            [eb1 shootAtLocation:here Aim:angleTowardPlayer];
            
        }
    }
    
    [super update];
    
}



@end
