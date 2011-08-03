#import "Player.h"

static NSString * ImgPlayer = @"spaceman.png";

static NSString * SndJump = @"jump.caf";
static NSString * SndLand = @"land.caf";
static NSString * SndExplode = @"asplode.caf";
static NSString * SndExplode2 = @"menu_hit_2.caf";
static NSString * SndHurt = @"hurt.caf";
//static NSString * SndJam = @"jam.caf";

@implementation Player

@synthesize rapidFire;
@synthesize justLanded;





+ (id) playerWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs
{
	return [[[self alloc] initWithOrigin:Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs] autorelease];

}

- (id) initWithOrigin:(CGPoint)Origin Bullets:(FlxGroup *)bullets Gibs:(FlxEmitter *)gibs{
    if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgPlayer param2:YES param3:NO param4:8 param5:8];
        _restart = 0;
        
        //bounding box tweaks
        self.width = 6;
        self.height = 7;
        self.offset = CGPointMake(1, 1);
        
        //basic player physics
        uint  runSpeed = 40;
        self.drag = CGPointMake(runSpeed*8, 0);
        self.acceleration = CGPointMake(0, 420);
        
        _jumpPower = 250; // SET TO 200
        self.maxVelocity = CGPointMake(runSpeed, _jumpPower);
        
        //animations
        [self addAnimationWithParam1:@"idle" param2:[NSMutableArray intArrayWithSize:1 ints:0] param3:0 param4:NO];
        [self addAnimationWithParam1:@"run" param2:[NSMutableArray intArrayWithSize:4 ints:1,2,3,0] param3:12 param4:NO];        
        [self addAnimationWithParam1:@"jump" param2:[NSMutableArray intArrayWithSize:1 ints:4] param3:0 param4:NO];
        [self addAnimationWithParam1:@"idle_up" param2:[NSMutableArray intArrayWithSize:1 ints:5] param3:0 param4:NO];
        [self addAnimationWithParam1:@"run_up" param2:[NSMutableArray intArrayWithSize:4 ints:6,7,8,5] param3:12 param4:NO];
        [self addAnimationWithParam1:@"jump_up" param2:[NSMutableArray intArrayWithSize:1 ints:9] param3:0 param4:NO];
        [self addAnimationWithParam1:@"jump_down" param2:[NSMutableArray intArrayWithSize:1 ints:10] param3:0 param4:NO];
        
        //bullet stuff
        _bullets = bullets;
        _gibs = gibs;
        
        
	}
	
	return self;
}

- (id) initWithOrigin:(CGPoint)Origin
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgPlayer param2:YES param3:NO param4:8 param5:8];
        
        
        
	}
	
	return self;	
}


- (void) dealloc
{
	//[_bullets release];
    //[_gibs release];
	[super dealloc];
}

- (void) doJump 
{
    
    self.velocity= CGPointMake(self.velocity.x, -_jumpPower);
    [FlxG play:SndJump];
    
}


- (void) hurt:(float)Damage
{
    self.health -= Damage;
    [self flicker:1.3];
    if(FlxG.score > 1000) FlxG.score -= 1000;
    if(velocity.x > 0)
        velocity.x = -maxVelocity.x;
    else
        velocity.x = maxVelocity.x;
    
    
    if (health <= 0 && self.dead == NO) {
        
        [self flicker:0];
        //_jets.kill();
        _gibs.x = self.x;
        _gibs.y = self.y;
        [_gibs startWithParam1:YES param2:3 param3:0];
        
        
        dead = YES;
        visible = NO;
        
        [FlxG play:SndExplode];
        [FlxG play:SndExplode2];
        
        [[FlxG quake] startWithIntensity:0.005 duration:1];
        [[FlxG flash] startWithParam1:0xffffffff param2:0.5];
        
    }
    else {
        [FlxG play:SndHurt];
        
    }
}

- (void) hitBottomWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    
    [super hitBottomWithParam1:Contact param2:Velocity];
    
    //stops player from twitching.
    self.y = roundf(self.y);
    
    
}






- (void) update
{   
    //game restart timer
    if(self.dead)
    {
        _restart += FlxG.elapsed;
        if(_restart > 2) {
            //FlxG.resetState();
        }
        return;
    }
    
    //make a little noise if you just touched the floor
    if (onFloor && justLanded ) {
        [FlxG play:SndLand];
        justLanded=NO;
    }
    
    //    if(justLanded && (velocity.y > 50))
    //        [FlxG play:SndLand];
    
    
    //ANIMATION
    if(self.velocity.y != 0)
    {
        if(_aim == UP) [self play:@"jump_up"];
        else if(_aim == DOWN) [self play:@"jump_down"];
        else [self play:@"jump"];
    }
    else if(velocity.x == 0)
    {
        if(_aim == UP) [self play:@"idle_up"];
        else [self play:@"idle"];
    }
    else
    {
        if(_aim == UP) [self play:@"run_up"];
        else {
            [self playWithParam1:@"run" param2:YES ];
            //NSLog(@"playing run");
        }
    }
    
	
	[super update];
	
}


@end
