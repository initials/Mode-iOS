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
@class Spawner;
@class Enemy;
@class Bullet;
@class EnemyBullet;
@class Notch;

@interface PlayState : FlxState

{    
    FlxText * helloText;
	FlxGroup * _blocks;
    FlxGroup * _decorations;
    
    FlxTileblock * b;
    Player * player;
    
    Bullet * bullet;
    EnemyBullet * eb;
    
    Enemy * enemy;
    
    Spawner * sp;
    
    Notch * notch;
    
    FlxGroup * _enemies ;
    FlxGroup * _spawners ;
    FlxGroup * _hud ;
    FlxGroup * _enemyBullets ;
    FlxGroup * _bullets;
    FlxGroup * _hazards;
    FlxGroup * _objects;
    FlxGroup * _gunjam;   
    FlxGroup * _notches;
    
    //virtual control pad
    FlxSprite * buttonLeft;
    FlxSprite * buttonRight;
    FlxSprite * buttonA;
    FlxSprite * buttonB;
    FlxSprite * buttonC;
    FlxSprite * buttonD;
    
    FlxEmitter * _littleGibs;
    FlxEmitter * _bigGibs;
    
    FlxSprite * temp ;
    FlxText * temptext;
    
    
}

- (id) init;
- (void) generateLevel:(int)size;
- (void) buildRoom:(uint)RX withRY:(uint)RY withSpawners:(BOOL)spawners;
- (void) onVictory ;


@end

