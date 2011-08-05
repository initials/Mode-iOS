//  Copyright Initials 2011. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// www.initialscommand.com

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
