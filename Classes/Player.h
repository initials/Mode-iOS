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


@interface Player : FlxManagedSprite
{
    BOOL rapidFire;
    BOOL justLanded;
    
    int _jumpPower;
    FlxGroup * _bullets;
    uint  _aim;
    CGFloat _restart;
    FlxEmitter * _gibs;
    
}

- (id) initWithOrigin:(CGPoint)origin;
- (id) initWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs;

- (void) doJump;


@property     BOOL rapidFire;
@property     BOOL justLanded;

@end
