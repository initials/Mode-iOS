//
//  FlxTouches.h
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

@class UITouch;

@interface FlxTouches : NSObject
{
  BOOL newData;
  NSSet * touches;
  int numberOfTouches;
  int multiTouchPhase;
  BOOL touchesBegan;
  BOOL touchesEnded;
  BOOL touching;
  BOOL nextTouchesBegan;
  BOOL nextTouchesEnded;
  CGPoint nextScreenTouchPoint;
  CGPoint nextLastScreenTouchPoint;
  CGPoint screenTouchPoint;
  CGPoint lastScreenTouchPoint;
  CGPoint nextScreenTouchBeganPoint;
  CGPoint screenTouchBeganPoint;

  BOOL swipedUp;
  BOOL swipedDown;
  BOOL swipedLeft;
  BOOL swipedRight;

    //UISwipeGestureRecognizer *swipeLeftRecognizer;

}

@property(nonatomic,readonly) NSSet * touches;
@property(nonatomic,readonly)   int numberOfTouches;
@property(nonatomic)   int multiTouchPhase;
@property(nonatomic,readonly) BOOL touching;
@property(nonatomic,readonly) BOOL touchesBegan;
@property(nonatomic,readonly) BOOL touchesEnded;
@property(nonatomic,readonly) CGPoint touchPoint;
//@property(nonatomic,readonly) NSArray * touchPoints;
@property(nonatomic,readonly) CGPoint lastTouchPoint;
@property(nonatomic,readonly) CGPoint screenTouchPoint;
@property(nonatomic,readonly) CGPoint lastScreenTouchPoint;
@property(nonatomic,readonly) CGPoint screenTouchBeganPoint;
@property(nonatomic,readonly) CGPoint touchBeganPoint;

//@property (nonatomic, retain) UISwipeGestureRecognizer *swipeLeftRecognizer;


@property(nonatomic,readonly)   BOOL swipedUp;
@property(nonatomic,readonly)   BOOL swipedDown;
@property(nonatomic,readonly)   BOOL swipedLeft;
@property(nonatomic,readonly)   BOOL swipedRight;



- (void) update;
@end
