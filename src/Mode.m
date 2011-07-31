//
//  Canabalt.m
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

#import "Mode.h"

@implementation Mode

- (id) init
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger zoom = [prefs integerForKey:@"ZOOM"];
    if(zoom == 0) zoom=2;
    [prefs setInteger:zoom forKey:@"ZOOM"];
    [prefs setInteger:zoom forKey:@"ZOOM_FOR_CURRENT_GAME"];
    [prefs synchronize];

    NSLog(@"zoom = %d", zoom);
    
  BOOL tbZoom = NO;
  if (FlxG.iPad || FlxG.retinaDisplay)
    tbZoom = YES;
  if ((self = [super initWithOrientation:FlxGameOrientationLandscape
				   state:@"MenuState"
				    zoom:zoom
		    useTextureBufferZoom:tbZoom
			       modelZoom:1.0])) {
    if (FlxG.retinaDisplay)
      self.frameInterval = 1;
  }
  return self;
}

@end
