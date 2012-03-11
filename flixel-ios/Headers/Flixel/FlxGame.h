//
//  FlxGame.h
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

#import <OpenGLES/ES1/gl.h>

//add the iCade Header

#import "iCadeReaderView.h"

@class FlxGroup;
@class FlxState;

@class EAGLContext;
@class UIWindow;

typedef enum {
    FlxGameOrientationPortrait,
    FlxGameOrientationLandscape,
} FlxGameOrientation;

@interface FlxGame : NSObject <iCadeEventDelegate>  //Sprite
{
    
    //create an iCadeReaderView
    
    iCadeReaderView *control ;
    
    NSString * _iState;
    BOOL _created;
    FlxState * _state;
    
    float _zoom;
    float modelZoom;
    BOOL textureBufferZoom;
    
    int _gameXOffset;
    int _gameYOffset;
    NSString * _frame;
    float _elapsed;
    unsigned int _total;
    BOOL _paused;
    
    BOOL autorotate;
    FlxGameOrientation gameOrientation;
    UIDeviceOrientation currentOrientation;
    float autorotateAngle;
    float autorotateAngleGoal;
    
    UIDeviceOrientation orientation;
    
    //
    UIWindow * window;
    EAGLContext * context;
    GLuint renderBuffer;
    GLuint frameBuffer;
    GLint backingWidth;
    GLint backingHeight;
    UIImageView * defaultView;
    
    GLshort blackVertices[10*2];
    GLubyte blackColors[10*4];
    
    //
    BOOL recursing;
    BOOL displayLinkSupported;
    
    BOOL iPad;
    
    id newState;
    id displayLink;
    
    NSInteger frameInterval;
    
    BOOL swipedUp;
    BOOL swipedDown;
    BOOL swipedLeft;
    BOOL swipedRight;
	UISwipeGestureRecognizer *swipeLeftRecognizer;
	//UISwipeGestureRecognizer *swipeRightRecognizer;
	UISwipeGestureRecognizer *swipeUpRecognizer;
	UISwipeGestureRecognizer *swipeDownRecognizer;
    
    BOOL  iCadeJoystickNone       ;
    BOOL iCadeJoystickUp         ;
    BOOL iCadeJoystickRight      ;
    BOOL iCadeJoystickDown       ;
    BOOL iCadeJoystickLeft      ;
    
    
    BOOL iCadeButtonA            ;
    BOOL iCadeButtonB            ;
    BOOL iCadeButtonC           ;
    BOOL iCadeButtonD           ;
    BOOL iCadeButtonE           ;
    BOOL iCadeButtonF           ;
    BOOL iCadeButtonG           ;
    BOOL iCadeButtonH     ;
    
    
}

@property(nonatomic,readonly) float zoom;
@property(nonatomic) BOOL textureBufferZoom;
@property(nonatomic,readonly) float modelZoom;
@property(nonatomic,assign) BOOL autorotate;
@property(nonatomic,readonly) FlxGameOrientation gameOrientation;
@property(nonatomic,readonly) UIDeviceOrientation currentOrientation;
@property(nonatomic,assign) BOOL paused;
@property(nonatomic,assign) NSInteger frameInterval;
@property(nonatomic,readonly) UIWindow * window;
@property(nonatomic,readonly)   BOOL swipedUp;
@property(nonatomic,readonly)   BOOL swipedDown;
@property(nonatomic,readonly)   BOOL swipedLeft;
@property(nonatomic,readonly)   BOOL swipedRight;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeLeftRecognizer;
//@property (nonatomic, retain) UISwipeGestureRecognizer *swipeRightRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeUpRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeDownRecognizer;


//iCade
@property(nonatomic,readonly)   BOOL iCadeJoystickNone;

@property(nonatomic,readonly)   BOOL iCadeJoystickUp;
@property(nonatomic,readonly)   BOOL iCadeJoystickRight;
@property(nonatomic,readonly)   BOOL iCadeJoystickDown;
@property(nonatomic,readonly)   BOOL iCadeJoystickLeft;

@property(nonatomic,readonly)   BOOL iCadeButtonA;
@property(nonatomic,readonly)   BOOL iCadeButtonB;
@property(nonatomic,readonly)   BOOL iCadeButtonC;
@property(nonatomic,readonly)   BOOL iCadeButtonD;

@property(nonatomic,readonly)   BOOL iCadeButtonE;
@property(nonatomic,readonly)   BOOL iCadeButtonF;
@property(nonatomic,readonly)   BOOL iCadeButtonG;
@property(nonatomic,readonly)   BOOL iCadeButtonH;



- (id) initWithOrientation:(FlxGameOrientation)gameOrientation state:(NSString *)InitialState;
- (id) initWithOrientation:(FlxGameOrientation)gameOrientation state:(NSString *)InitialState zoom:(float)Zoom;
- (id) initWithOrientation:(FlxGameOrientation)gameOrientation state:(NSString *)InitialState zoom:(float)Zoom useTextureBufferZoom:(BOOL)textureBufferZoom;
- (id) initWithOrientation:(FlxGameOrientation)gameOrientation state:(NSString *)InitialState zoom:(float)Zoom useTextureBufferZoom:(BOOL)textureBufferZoom modelZoom:(float)modelZoom;
- (void) start;
- (void) showSoundTray;
- (void) showSoundTray:(BOOL)Silent;
- (void) switchState:(FlxState *)State;
+ (void) setSlowdown:(unsigned int)slowdown;
+ (unsigned int) slowdown;

- (void) resetProjection;
- (void) didEnterBackground;
- (void) willEnterForeground;

//- (void)setState:(BOOL)state forButton:(iCadeState)button;
- (void)buttonDown:(iCadeState)button ;
- (void)buttonUp:(iCadeState)button ;


@end
