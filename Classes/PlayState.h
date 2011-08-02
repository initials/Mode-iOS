//
//  MenuState.h
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
// THE SOFTWARE.
//

//#import <GameKit/GameKit.h>
//#import "GameCenterManager.h"


@class Player;
@class Spawner;
@class Enemy;
@class Bullet;
@class EnemyBullet;
@class Notch;
//@class GameCenterManager;

//@interface PlayState : FlxState <UIActionSheetDelegate, GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate>
@interface PlayState : FlxState

{
    //GameCenterManager * gameCenterManager;
    
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

//@property (nonatomic, retain) GameCenterManager *gameCenterManager;


- (id) init;
- (void) generateLevel:(int)size;
- (void) buildRoom:(uint)RX withRY:(uint)RY withSpawners:(BOOL)spawners;
- (void) onVictory ;


@end

