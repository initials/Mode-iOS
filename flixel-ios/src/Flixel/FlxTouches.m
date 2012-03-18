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
@synthesize swipedDown, swipedUp, swipedLeft, swipedRight;
@synthesize vcpButton1, vcpButton2, vcpLeftArrow, vcpRightArrow, newTouch;

@synthesize debugButton1, debugButton2, debugButton3, debugButton4, debugButton5;
@synthesize humanControlled;



@synthesize iCadeUp, iCadeRight, iCadeDown, iCadeLeft;
@synthesize iCadeStart, iCadeLeftBumper, iCadeSelect, iCadeRightBumper;
@synthesize iCadeY, iCadeB, iCadeA, iCadeX;
@synthesize iCadeUpBegan, iCadeRightBegan, iCadeDownBegan, iCadeLeftBegan;
@synthesize iCadeStartBegan, iCadeLeftBumperBegan, iCadeSelectBegan, iCadeRightBumperBegan;
@synthesize iCadeYBegan, iCadeBBegan, iCadeABegan, iCadeXBegan;

int previousNumberOfTouches;


- (void)dealloc {
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
    
    //    vcpLeftArrowTouchesBegan = NO;
    //    vcpRightArrowTouchesBegan=NO;
    //    vcpButton1TouchesBegan = NO;
    //    vcpButton2TouchesBegan = NO;  
    
    swipedDown=NO;
    swipedLeft=NO;
    swipedUp=NO;
    swipedRight=NO;
    
    vcpLeftArrow = NO;
    vcpRightArrow = NO;
    vcpButton1 = NO;
    vcpButton2 = NO;
    
    debugButton1 = debugButton2 = debugButton3 = debugButton4 = debugButton5 = NO;
    
    if (numberOfTouches > previousNumberOfTouches) {
        newTouch = YES;
    }
    else {
        newTouch = NO;
    }
    
    
    
    if ( humanControlled && (numberOfTouches == 1 || numberOfTouches == 2 ) ) {
        //if (numberOfTouches >=1 ) {
        for(UITouch *singleTouch in touches) {
            
            //NSLog(@"%@", singleTouch);
            
            CGPoint p = [singleTouch locationInView:(singleTouch.view)];
            
            UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
            
            
            if (orientation == UIDeviceOrientationLandscapeLeft) {
                //NSLog(@"LEFT %@ at p %@", singleTouch, NSStringFromCGPoint(p));
                //NSLog(@"L screen touch point %f %f ", screenTouchPoint.x, screenTouchPoint.y);

            }
            else if (orientation == UIDeviceOrientationLandscapeRight) {
                //NSLog(@"RIGHT %@ at p %@", singleTouch, NSStringFromCGPoint(p));
                //NSLog(@"R screen touch point %f %f ", screenTouchPoint.x, screenTouchPoint.y);

            }
            
            
            
            if (FlxG.iPad) {
                if (p.y > 850 && p.x > 600) {
                    vcpLeftArrow = YES;
                } 
                
                else if (p.y > 650 && p.y < 849 && p.x > 600) {
                    vcpRightArrow = YES;
                } 
                
                else if (p.y < 200 && p.y > 1   && p.x > 600) { //&& player.onFloor
                    vcpButton2 = YES;
                } 
                
                else if (p.y > 201 && p.y < 350  && p.x > 600 ) { 
                    vcpButton1=YES;                    
                }
                
                
            }
            
            else {
                
                //NSLog(@"%@", NSStringFromCGPoint(p));
                if (p.y > 370 && p.x > 220) {
                    vcpLeftArrow = YES;
                } 
                
                else if (p.y > 260 && p.y < 369 && p.x > 220) {
                    vcpRightArrow = YES;

                } 
                
                else if (p.y < 80 && p.y > 1   && p.x > 220) { //&& player.onFloor
                    vcpButton2 = YES;
                
                } 
                
                else if (p.y > 81 && p.y < 160  && p.x > 220 ) { 
                    vcpButton1=YES;                    
                    
                }
            }
        }
    }
    
    previousNumberOfTouches = numberOfTouches;
    FlxGame * game = [FlxG game];
    iCadeUpBegan=NO;
    iCadeRightBegan=NO;
    iCadeDownBegan=NO;
    iCadeLeftBegan=NO; 
    
    iCadeStartBegan=NO;
    iCadeLeftBumperBegan=NO;
    iCadeSelectBegan=NO;
    iCadeRightBumperBegan=NO;
    iCadeYBegan=NO;
    iCadeBBegan=NO;
    iCadeABegan=NO;
    iCadeXBegan=NO;  
    
    
    //joystick up
    
    if (game.iCadeJoystickUp  ) {
        
        if (iCadeUp==NO) {
            iCadeUpBegan=YES;
        }
        else {
            iCadeUpBegan=NO;
        }
        
        iCadeUp=YES;
    }
    else {
        iCadeUp=NO;
    }
    
    //joystick Right
    
    if (game.iCadeJoystickRight  ) {
        
        if (iCadeRight==NO) {
            iCadeRightBegan=YES;
        }
        else {
            iCadeRightBegan=NO;
        }
        
        iCadeRight=YES;
    }
    else {
        iCadeRight=NO;
    }
    
    //joystick Down
    
    if (game.iCadeJoystickDown  ) {
        
        if (iCadeDown==NO) {
            iCadeDownBegan=YES;
        }
        else {
            iCadeDownBegan=NO;
        }
        
        iCadeDown=YES;
    }
    else {
        iCadeDown=NO;
    }
    
    //joystick Left
    
    if (game.iCadeJoystickLeft  ) {
        
        if (iCadeLeft==NO) {
            iCadeLeftBegan=YES;
        }
        else {
            iCadeLeftBegan=NO;
        }
        
        iCadeLeft=YES;
    }
    else {
        iCadeLeft=NO;
    }
    
    //gamepad 2 = icp v2.0
    // start with this one so default can be 1 or any other
    
    //NSLog(@"%d", FlxG.touches.iCadeSelect);
    
    if (FlxG.gamePad==2) {
        
        //Button A
        
        if (game.iCadeButtonC  ) {
            
            if (iCadeSelect==NO) {
                iCadeSelectBegan=YES;
            }
            else {
                iCadeSelectBegan=NO;
            }
            
            iCadeSelect=YES;
        }
        else {
            iCadeSelect=NO;
        }
        
        //Button B
        
        if (game.iCadeButtonF) {
            
            if (iCadeLeftBumper==NO) {
                iCadeLeftBumperBegan=YES;
            }
            else {
                iCadeLeftBumperBegan=NO;
            }
            
            iCadeLeftBumper=YES;
        }
        else {
            iCadeLeftBumper=NO;
        }    
        
        //Button C
        
        if (game.iCadeButtonA  ) {
            
            if (iCadeStart==NO) {
                iCadeStartBegan=YES;
            }
            else {
                iCadeStartBegan=NO;
            }
            
            iCadeStart=YES;
        }
        else {
            iCadeStart=NO;
        }
        
        //Button D
        
        if (game.iCadeButtonE  ) {
            
            if (iCadeRightBumper==NO) {
                iCadeRightBumperBegan=YES;
            }
            else {
                iCadeRightBumperBegan=NO;
            }
            
            iCadeRightBumper=YES;
        }
        else {
            iCadeRightBumper=NO;
        }
        
        //Button E
        
        if (game.iCadeButtonG  ) {
            
            if (iCadeY==NO) {
                iCadeYBegan=YES;
            }
            else {
                iCadeYBegan=NO;
            }
            
            iCadeY=YES;
        }
        else {
            iCadeY=NO;
        }
        
        //Button F
        
        if (game.iCadeButtonH  ) {
            
            if (iCadeB==NO) {
                iCadeBBegan=YES;
            }
            else {
                iCadeBBegan=NO;
            }
            
            iCadeB=YES;
        }
        else {
            iCadeB=NO;
        }    
        
        //Button G
        
        if (game.iCadeButtonD  ) {
            
            if (iCadeX==NO) {
                iCadeXBegan=YES;
            }
            else {
                iCadeXBegan=NO;
            }
            
            iCadeX=YES;
        }
        else {
            iCadeX=NO;
        }
        
        //Button H
        
        if (game.iCadeButtonB  ) {
            
            if (iCadeA==NO) {
                iCadeABegan=YES;
            }
            else {
                iCadeABegan=NO;
            }
            
            iCadeA=YES;
        }
        else {
            iCadeA=NO;
        }
    }
    
    //3 = icp v2.1a
    
    else if (FlxG.gamePad==3) {
        
        //Button A
        
        if (game.iCadeButtonA  ) {
            
            if (iCadeSelect==NO) {
                iCadeSelectBegan=YES;
            }
            else {
                iCadeSelectBegan=NO;
            }
            
            iCadeSelect=YES;
        }
        else {
            iCadeSelect=NO;
        }
        
        //Button B
        
        if (game.iCadeButtonB) {
            
            if (iCadeLeftBumper==NO) {
                iCadeLeftBumperBegan=YES;
            }
            else {
                iCadeLeftBumperBegan=NO;
            }
            
            iCadeLeftBumper=YES;
        }
        else {
            iCadeLeftBumper=NO;
        }    
        
        //Button C
        
        if (game.iCadeButtonC  ) {
            
            if (iCadeStart==NO) {
                iCadeStartBegan=YES;
            }
            else {
                iCadeStartBegan=NO;
            }
            
            iCadeStart=YES;
        }
        else {
            iCadeStart=NO;
        }
        
        //Button D
        
        if (game.iCadeButtonD  ) {
            
            if (iCadeRightBumper==NO) {
                iCadeRightBumperBegan=YES;
            }
            else {
                iCadeRightBumperBegan=NO;
            }
            
            iCadeRightBumper=YES;
        }
        else {
            iCadeRightBumper=NO;
        }
        
        //Button E
        
        if (game.iCadeButtonF  ) {
            
            if (iCadeY==NO) {
                iCadeYBegan=YES;
            }
            else {
                iCadeYBegan=NO;
            }
            
            iCadeY=YES;
        }
        else {
            iCadeY=NO;
        }
        
        //Button F
        
        if (game.iCadeButtonH  ) {
            
            if (iCadeB==NO) {
                iCadeBBegan=YES;
            }
            else {
                iCadeBBegan=NO;
            }
            
            iCadeB=YES;
        }
        else {
            iCadeB=NO;
        }    
        
        //Button G
        
        if (game.iCadeButtonE  ) {
            
            if (iCadeX==NO) {
                iCadeXBegan=YES;
            }
            else {
                iCadeXBegan=NO;
            }
            
            iCadeX=YES;
        }
        else {
            iCadeX=NO;
        }
        
        //Button H
        
        if (game.iCadeButtonG  ) {
            
            if (iCadeA==NO) {
                iCadeABegan=YES;
            }
            else {
                iCadeABegan=NO;
            }
            
            iCadeA=YES;
        }
        else {
            iCadeA=NO;
        }
    }
    
    else {
        
        //Button A
        
        if (game.iCadeButtonA  ) {
            
            if (iCadeSelect==NO) {
                iCadeSelectBegan=YES;
            }
            else {
                iCadeSelectBegan=NO;
            }
            
            iCadeSelect=YES;
        }
        else {
            iCadeSelect=NO;
        }
        
        //Button B
        
        if (game.iCadeButtonB) {
            
            if (iCadeLeftBumper==NO) {
                iCadeLeftBumperBegan=YES;
            }
            else {
                iCadeLeftBumperBegan=NO;
            }
            
            iCadeLeftBumper=YES;
        }
        else {
            iCadeLeftBumper=NO;
        }    
        
        //Button C
        
        if (game.iCadeButtonC  ) {
            
            if (iCadeStart==NO) {
                iCadeStartBegan=YES;
            }
            else {
                iCadeStartBegan=NO;
            }
            
            iCadeStart=YES;
        }
        else {
            iCadeStart=NO;
        }
        
        //Button D
        
        if (game.iCadeButtonD  ) {
            
            if (iCadeRightBumper==NO) {
                iCadeRightBumperBegan=YES;
            }
            else {
                iCadeRightBumperBegan=NO;
            }
            
            iCadeRightBumper=YES;
        }
        else {
            iCadeRightBumper=NO;
        }
        
        //Button E
        
        if (game.iCadeButtonE  ) {
            
            if (iCadeY==NO) {
                iCadeYBegan=YES;
            }
            else {
                iCadeYBegan=NO;
            }
            
            iCadeY=YES;
        }
        else {
            iCadeY=NO;
        }
        
        //Button F
        
        if (game.iCadeButtonF  ) {
            
            if (iCadeB==NO) {
                iCadeBBegan=YES;
            }
            else {
                iCadeBBegan=NO;
            }
            
            iCadeB=YES;
        }
        else {
            iCadeB=NO;
        }    
        
        //Button G
        
        if (game.iCadeButtonG  ) {
            
            if (iCadeX==NO) {
                iCadeXBegan=YES;
            }
            else {
                iCadeXBegan=NO;
            }
            
            iCadeX=YES;
        }
        else {
            iCadeX=NO;
        }
        
        //Button H
        
        if (game.iCadeButtonH  ) {
            
            if (iCadeA==NO) {
                iCadeABegan=YES;
            }
            else {
                iCadeABegan=NO;
            }
            
            iCadeA=YES;
        }
        else {
            iCadeA=NO;
        }
    }
    
    
    if (newData) {
        
        if (game.swipedRight && humanControlled ) {
            swipedRight=YES;
        }
        if (game.swipedLeft && humanControlled ) {
            swipedLeft=YES;
        }
        if (game.swipedDown && humanControlled ) {
            swipedDown=YES;
        }
        if (game.swipedUp && humanControlled ) {
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
