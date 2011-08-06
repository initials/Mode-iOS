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

@class Player;
@class EnemyBullet;
@interface Enemy : FlxManagedSprite
{
    Player * _player;		//The player object
    //References to other game objects:
    FlxGroup * _bullets;	//A group of enemy bullet objects (Enemies shoot these out)
    FlxEmitter * _gibs;		//A group of bits and pieces that explode when the Enemy dies.
    //A special effect - little jets shoot out the back of the ship
    //FlxEmitter * _jetsEmitter;

    BOOL jetsOn;
    EnemyBullet * eb;
    
}

+ (id) enemyWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs ThePlayer:(Player *)player;

- (id) initWithOrigin:(CGPoint)origin;
- (id) initWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs ThePlayer:(Player *)player;
- (void) resetSwarm:(int)type xPos:(int)xpos yPos:(int)ypos Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs ThePlayer:(Player *)player; 

- (CGFloat) angleTowardPlayer;


@end
