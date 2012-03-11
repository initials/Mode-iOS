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
    
    //    BOOL vcpLeftArrowTouchesBegan;
    //    BOOL vcpLeftArrowTouchesEnded;
    //    BOOL vcpLeftArrowNextTouchesBegan;
    //    BOOL vcpLeftArrowNextTouchesEnded;
    //    
    //    BOOL vcpRightArrowTouchesBegan;
    //    BOOL vcpRightArrowTouchesEnded;
    //    BOOL vcpRightArrowNextTouchesBegan;
    //    BOOL vcpRightArrowNextTouchesEnded;    
    //    
    //    BOOL vcpButton1TouchesBegan;
    //    BOOL vcpButton1TouchesEnded;
    //    BOOL vcpButton1NextTouchesBegan;
    //    BOOL vcpButton1NextTouchesEnded;
    //    
    //    BOOL vcpButton2TouchesBegan;
    //    BOOL vcpButton2TouchesEnded;
    //    BOOL vcpButton2NextTouchesBegan;
    //    BOOL vcpButton2NextTouchesEnded;
    //    
    
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
    
    BOOL vcpLeftArrow;
    BOOL vcpRightArrow;
    BOOL vcpButton1;
    BOOL vcpButton2;
    
    BOOL newTouch;
    
    //debug buttons
    BOOL debugButton1;
    BOOL debugButton2;
    BOOL debugButton3;
    BOOL debugButton4;
    BOOL debugButton5;
    
    BOOL humanControlled;
    
    
    BOOL iCadeUp;
    BOOL iCadeRight;
    BOOL iCadeLeft;
    BOOL iCadeDown;  
    BOOL iCadeStart;
    BOOL iCadeLeftBumper;
    BOOL iCadeSelect;
    BOOL iCadeRightBumper;    
    BOOL iCadeY;
    BOOL iCadeB;
    BOOL iCadeA;
    BOOL iCadeX;
    
    BOOL iCadeUpBegan;
    BOOL iCadeRightBegan;
    BOOL iCadeLeftBegan;
    BOOL iCadeDownBegan;  
    BOOL iCadeStartBegan;
    BOOL iCadeLeftBumperBegan;
    BOOL iCadeSelectBegan;
    BOOL iCadeRightBumperBegan;    
    BOOL iCadeYBegan;
    BOOL iCadeBBegan;
    BOOL iCadeABegan;
    BOOL iCadeXBegan;
    
    
    
    
    //UISwipeGestureRecognizer *swipeLeftRecognizer;
    
}

@property(nonatomic,readonly) NSSet * touches;
@property(nonatomic,readonly)   int numberOfTouches;
@property(nonatomic)   int multiTouchPhase;
@property(nonatomic,readonly) BOOL touching;
@property(nonatomic,readonly) BOOL touchesBegan;
@property(nonatomic,readonly) BOOL touchesEnded;

//@property(nonatomic,readonly) BOOL vcpLeftArrowTouchesBegan;
//@property(nonatomic,readonly) BOOL vcpLeftArrowTouchesEnded;
//@property(nonatomic,readonly) BOOL vcpLeftArrowNextTouchesBegan;
//@property(nonatomic,readonly) BOOL vcpLeftArrowNextTouchesEnded;
//
//@property(nonatomic,readonly) BOOL vcpRightArrowTouchesBegan;
//@property(nonatomic,readonly) BOOL vcpRightArrowTouchesEnded;
//@property(nonatomic,readonly) BOOL vcpRightArrowNextTouchesBegan;
//@property(nonatomic,readonly) BOOL vcpRightArrowNextTouchesEnded;    
//
//@property(nonatomic,readonly) BOOL vcpButton1TouchesBegan;
//@property(nonatomic,readonly) BOOL vcpButton1TouchesEnded;
//@property(nonatomic,readonly) BOOL vcpButton1NextTouchesBegan;
//@property(nonatomic,readonly) BOOL vcpButton1NextTouchesEnded;
//
//@property(nonatomic,readonly) BOOL vcpButton2TouchesBegan;
//@property(nonatomic,readonly) BOOL vcpButton2TouchesEnded;
//@property(nonatomic,readonly) BOOL vcpButton2NextTouchesBegan;
//@property(nonatomic,readonly) BOOL vcpButton2NextTouchesEnded;
//



@property(nonatomic,readonly) CGPoint touchPoint;
//@property(nonatomic,readonly) NSArray * touchPoints;
@property(nonatomic,readonly) CGPoint lastTouchPoint;
@property(nonatomic,readonly) CGPoint screenTouchPoint;
@property(nonatomic,readonly) CGPoint lastScreenTouchPoint;
@property(nonatomic,readonly) CGPoint screenTouchBeganPoint;
@property(nonatomic,readonly) CGPoint touchBeganPoint;

//@property (nonatomic, retain) UISwipeGestureRecognizer *swipeLeftRecognizer;


@property(nonatomic)   BOOL swipedUp;
@property(nonatomic)   BOOL swipedDown;
@property(nonatomic)   BOOL swipedLeft;
@property(nonatomic)   BOOL swipedRight;

@property(nonatomic)   BOOL vcpButton1;
@property(nonatomic)   BOOL vcpButton2;
@property(nonatomic)   BOOL vcpLeftArrow;
@property(nonatomic)   BOOL vcpRightArrow;

@property(nonatomic, readonly) BOOL debugButton1;
@property(nonatomic, readonly) BOOL debugButton2;
@property(nonatomic, readonly) BOOL debugButton3;
@property(nonatomic, readonly) BOOL debugButton4;
@property(nonatomic, readonly) BOOL debugButton5;

@property(nonatomic) BOOL humanControlled;



@property(nonatomic)   BOOL newTouch;



@property(nonatomic,readonly) BOOL iCadeUp;
@property(nonatomic,readonly) BOOL iCadeRight;
@property(nonatomic,readonly) BOOL iCadeLeft;
@property(nonatomic,readonly) BOOL iCadeDown;  
@property(nonatomic,readonly) BOOL iCadeStart;
@property(nonatomic,readonly) BOOL iCadeLeftBumper;
@property(nonatomic,readonly) BOOL iCadeSelect;
@property(nonatomic,readonly) BOOL iCadeRightBumper;
@property(nonatomic,readonly) BOOL iCadeY;
@property(nonatomic,readonly) BOOL iCadeB;
@property(nonatomic,readonly) BOOL iCadeA;
@property(nonatomic,readonly) BOOL iCadeX;


@property(nonatomic,readonly) BOOL iCadeUpBegan;
@property(nonatomic,readonly) BOOL iCadeRightBegan;
@property(nonatomic,readonly) BOOL iCadeLeftBegan;
@property(nonatomic,readonly) BOOL iCadeDownBegan;  
@property(nonatomic,readonly) BOOL iCadeStartBegan;
@property(nonatomic,readonly) BOOL iCadeLeftBumperBegan;
@property(nonatomic,readonly) BOOL iCadeSelectBegan;
@property(nonatomic,readonly) BOOL iCadeRightBumperBegan;
@property(nonatomic,readonly) BOOL iCadeYBegan;
@property(nonatomic,readonly) BOOL iCadeBBegan;
@property(nonatomic,readonly) BOOL iCadeABegan;
@property(nonatomic,readonly) BOOL iCadeXBegan;





- (void) update;
@end
