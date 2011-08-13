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


@interface PlayerSCB : FlxManagedSprite
{
	CGFloat timer;
    NSString * gunType;
    BOOL rapidFire;
    CGFloat jump;
    CGFloat jumpLimit;
    BOOL ableToStartJump;
}

- (id) initWithOrigin:(CGPoint)origin;
- (void) doJump;

@property CGFloat timer;
@property NSString * gunType;
@property BOOL rapidFire;

@property CGFloat jump;
@property CGFloat jumpLimit;
@property BOOL ableToStartJump;


@end
