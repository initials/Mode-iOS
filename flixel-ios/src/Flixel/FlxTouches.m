//
//  FlxTouches.m
//  flixel-ios
//
//  Copyright Semi Secret Software 2009-2010. All rights reserved.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  

#import <Flixel/Flixel.h>

@interface FlxTouches ()
- (CGPoint) internalScreenTouchPoint;
@end

@implementation FlxTouches

@synthesize touchesBegan, touchesEnded, touching;
@synthesize screenTouchPoint, lastScreenTouchPoint;
@synthesize screenTouchBeganPoint;
@synthesize touches, numberOfTouches, multiTouchPhase;
//@synthesize swipeLeftRecognizer;
@synthesize swipedDown, swipedUp, swipedLeft, swipedRight;
@synthesize vcpButton1, vcpButton2, vcpLeftArrow, vcpRightArrow, newTouch;

int previousNumberOfTouches;


- (void)dealloc {
    //[swipeLeftRecognizer release];
    [super dealloc];
}

//- (id) init {
//    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    self.swipeLeftRecognizer = (UISwipeGestureRecognizer *)recognizer;
//    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    self.swipeLeftRecognizer = (UISwipeGestureRecognizer *)recognizer;
//    [recognizer release];
//    return YES;
//}


- (void) processTouches:(NSSet *)newTouches
{
 
  BOOL getScreenTouchBeganPoint = NO;
  if ((touches == nil || [touches count] == 0) &&
      (newTouches != nil && [newTouches count] > 0)) {
    nextTouchesBegan = YES;
    getScreenTouchBeganPoint = YES;
  }
  if ((newTouches == nil || [newTouches count] == 0) &&
      (touches != nil && [touches count] > 0))
    nextTouchesEnded = YES;
  [touches release];
  touches = [newTouches retain];
    //NSLog(@" TOUCHES SET : %@ ", touches);
  nextLastScreenTouchPoint = nextScreenTouchPoint;
  nextScreenTouchPoint = self.internalScreenTouchPoint;
  if (getScreenTouchBeganPoint)
    nextScreenTouchBeganPoint = nextScreenTouchPoint;
  newData = YES;

}

- (void) update
{
    //multiTouchPhase = -1;
    numberOfTouches = [touches count];
  //reset these right away
  touchesBegan = NO;
  touchesEnded = NO;
    
    swipedDown=NO;
    swipedLeft=NO;
    swipedUp=NO;
    swipedRight=NO;
    
    vcpLeftArrow = NO;
    vcpRightArrow = NO;
    vcpButton1 = NO;
    vcpButton2 = NO;

    if (numberOfTouches > previousNumberOfTouches) {
        newTouch = YES;
    }
    else {
        newTouch = NO;
    }
    
    if (numberOfTouches == 1 || numberOfTouches == 2) {
        for(UITouch *singleTouch in touches) {
            
            //NSLog(@"%@", singleTouch);
            CGPoint p = [singleTouch locationInView:(singleTouch.view)];
            //NSLog(@"%@", NSStringFromCGPoint(p));
            if (p.y > 400) {
                vcpLeftArrow = YES;
                
            } else if (p.y > 320 && p.y < 399) {
                vcpRightArrow = YES;
                
            } else if (p.y < 80 && p.y > 1  ) { //&& player.onFloor
                vcpButton2 = YES;
                
                
                
            }
            if (p.y > 81 && p.y < 160  ) { 
                vcpButton1=YES;
                
            }
        }
    }
    
    previousNumberOfTouches = numberOfTouches;
    
    
  if (newData) {
      

      
      FlxGame * game = [FlxG game];
      if (game.swipedRight) {
          swipedRight=YES;
      }
      if (game.swipedLeft) {
          swipedLeft=YES;
      }
      if (game.swipedDown) {
          swipedDown=YES;
      }
      if (game.swipedUp) {
          swipedUp=YES;
      }
      

      
  

      
    touchesBegan = nextTouchesBegan;
    touchesEnded = nextTouchesEnded;
    nextTouchesBegan = NO;
    nextTouchesEnded = NO;
    touching = [touches count] > 0;
    lastScreenTouchPoint = nextLastScreenTouchPoint;
    screenTouchPoint = nextScreenTouchPoint;
    screenTouchBeganPoint = nextScreenTouchBeganPoint;
  }
  newData = NO;
}


- (CGPoint) touchPoint
{
  CGPoint p = screenTouchPoint;
  p.x -= FlxG.scroll.x;
  p.y -= FlxG.scroll.y;
  return p;
}

- (CGPoint) lastTouchPoint
{
  CGPoint p = lastScreenTouchPoint;
  p.x -= FlxG.scroll.x;
  p.y -= FlxG.scroll.y;
  return p;
}

- (CGPoint) touchBeganPoint
{
  CGPoint p = screenTouchBeganPoint;
  p.x -= FlxG.scroll.x;
  p.y -= FlxG.scroll.y;
  return p;
}

- (CGPoint) internalScreenTouchPoint
{
  CGPoint p = CGPointZero;
  UITouch * t = nil;
  if ([touches count] > 0) {
    t = [touches anyObject];
    p = [t locationInView:t.view];
  }
  if (t == nil && [touches count] > 0) {
    NSLog(@"what's going on?!?");
  }
  if (t == nil) {
    return p;
  }
  //todo: potentially a different point depending upon screen orientation
  //also need to scale by zoom
  FlxGame * game = [FlxG game];
    
  float z = game.zoom;
  if (FlxG.retinaDisplay)
    z = z/2;
  UIDeviceOrientation o = game.currentOrientation;
  switch (o) {
  case UIDeviceOrientationPortrait:
    p.x = p.x/z;
    p.y = p.y/z;
    break;
  case UIDeviceOrientationPortraitUpsideDown:
    p.x = (t.view.bounds.size.width-p.x)/z;
    p.y = (t.view.bounds.size.height-p.y)/z;
    break;
  case UIDeviceOrientationLandscapeLeft:
    {
      CGFloat x = p.x;
      p.x = p.y/z;
      p.y = (t.view.bounds.size.width-x)/z;
      break;
    }
  case UIDeviceOrientationLandscapeRight:
    {
      CGFloat x = p.x;
      p.x = (t.view.bounds.size.height-p.y)/z;
      p.y = x/z;
      break;
    }
  }
  if (FlxG.game.textureBufferZoom) {
    p.x /= 2;
    p.y /= 2;
  }
  return p;
}

@end
