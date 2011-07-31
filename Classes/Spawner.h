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

@interface Spawner : FlxManagedSprite
{
    FlxGroup * _bots;
    FlxGroup * _botBullets;
    FlxEmitter * _botGibs;
    FlxEmitter * _gibs;
    Player * _player;
    FlxGroup * _notches;
    int _index;
    CGFloat _timer;
    BOOL _open;
    
}
+ (id) spawnerWithOrigin:(CGPoint)origin Gibs:(FlxEmitter *)gibs Bots:(FlxGroup *)bots BotBullets:(FlxGroup*)botBullets BotGibs:(FlxEmitter *)botGibs ThePlayer:(Player *)player Notches:(FlxGroup *)notches Index:(int)index;

- (id) initWithOrigin:(CGPoint)origin;
- (id) initWithOrigin:(CGPoint)Origin Gibs:(FlxEmitter *)gibs Bots:(FlxGroup *)bots BotBullets:(FlxGroup*)botBullets BotGibs:(FlxEmitter *)botGibs ThePlayer:(Player *)player Notches:(FlxGroup *)notches Index:(int)index;
- (void) makeBot;


@end
