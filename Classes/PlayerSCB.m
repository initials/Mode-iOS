#import "PlayerSCB.h"

static NSString * ImgPlayer = @"spaceman.png";

@implementation PlayerSCB

CGFloat spinTimer;


@synthesize timer;
@synthesize gunType;
@synthesize rapidFire;
@synthesize jumpLimit;
@synthesize jump;
@synthesize ableToStartJump;



+ (id) playerSCB
{
	return [[[self alloc] init] autorelease];
}

- (id) initWithOrigin:(CGPoint)Origin
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgPlayer param2:YES param3:NO param4:8 param5:8];
		
		//gravity
		self.acceleration = CGPointMake(0, 900);
		
		self.drag = CGPointMake(1900, 1900);
        gunType = @"pistol";
        rapidFire = NO;
        
        maxVelocity.x = 300;
        maxVelocity.y = 330;
        
        spinTimer = 0;
        
	}
	
	return self;	
}


- (void) dealloc
{
	
	[super dealloc];
}

- (void) doJump 
{
    
    //NSLog(@"jump, limit: %f jump %f", jumpLimit, jump);
    //jumping
	jumpLimit = 0.105;
	//if (jumpLimit > 0.35) jumpLimit = 0.35;
	
    if (jump >= 0  ) {
		if (jump == 0) {
			
		}
		jump += FlxG.elapsed;
		if (jump > jumpLimit) {
			//NSLog(@"force ending a jump");
			jump = -1;
		}
		
	} else
		jump = -1;
    
    
    if ( ( jump!=0) && (velocity.y > 0) ) {
        //justLanded = TRUE;
        //lastGoodAngle = angle;
    }
    
	
	if (jump > 0) {
		//onFloor = NO;
        velocity.y = -maxVelocity.y;
        
        //		if (jump < 0.08)
        //			velocity.y = -maxVelocity.y*0.65;
        //		else
        //			velocity.y = -maxVelocity.y;
		
	}
    ableToStartJump = NO;
    
}

- (void) hitBottomWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    ableToStartJump = YES;
    jump = 0;
    [super hitBottomWithParam1:Contact param2:Velocity];
}


- (void) update
{   
    if (self.onFloor) { 
        jump = 0 ; 
        //self.angularVelocity = 0;
        self.angle = 0;
        spinTimer = 0;
        ableToStartJump = YES;
    }
    else {
        ableToStartJump = NO;
        spinTimer += 0.01;
        if (spinTimer > 0.05) {
            self.angle += 90;
            spinTimer = 0;
        }
        else {
            
        }
    }
    
    if (self.y > FlxG.height) {
        self.dead = YES;
    }
	
	[super update];
	
}


@end
