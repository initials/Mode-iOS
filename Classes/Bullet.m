#import "Bullet.h"

static NSString * ImgBullet = @"bullet.png";
static NSString * SndHit = @"jump.caf";
static NSString * SndShoot = @"shoot.caf";



@implementation Bullet

@synthesize speed;


+ (id) bullet
{
	return [[[self alloc] init] autorelease];
}



- (id) initWithOrigin:(CGPoint)Origin
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgBullet param2:YES param3:NO param4:8 param5:8];
        
        self.width = 6;
        self.height = 6;
        self.offset = CGPointMake(1, 1);
        
        [self addAnimationWithParam1:@"up" param2:[NSMutableArray intArrayWithSize:1 ints:0] param3:0 param4:NO];
        [self addAnimationWithParam1:@"down" param2:[NSMutableArray intArrayWithSize:1 ints:1] param3:0 param4:NO];        
        [self addAnimationWithParam1:@"left" param2:[NSMutableArray intArrayWithSize:1 ints:2] param3:0 param4:NO];        
        [self addAnimationWithParam1:@"right" param2:[NSMutableArray intArrayWithSize:1 ints:3] param3:0 param4:NO];       
        [self addAnimationWithParam1:@"explode" param2:[NSMutableArray intArrayWithSize:5 ints:4,5,6,7,8] param3:23 param4:NO];        
        
        speed = 360;
        
        
	}
	
	return self;	
}


- (void) dealloc
{
    
	[super dealloc];
}

- (void) shootAtLocation:(CGPoint)loc Aim:(uint)aim
{
    [FlxG play:SndShoot];
    self.x = loc.x-width/2,
    self.y = loc.y-height/2-8;
    solid = YES;
    
}

- (void) hitLeftWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
}
- (void) hitRightWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
    
}
- (void) hitBottomWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
    
}
- (void) hitTopWithParam1:(FlxObject *)Contact param2:(float)Velocity
{
    [self hitWall];
    
}

- (void) hitWall
{
    [self play:@"explode"];
    [FlxG play:SndHit];
    
    
}



- (void) update
{	
    if (_curFrame==4) {
        //NSLog(@"Bullet Dead");
        self.velocity = CGPointMake(0, 0);
        self.dead = YES;
        self.x = 900;
        self.y = 900;
        [self play:@"left"];
    }
    
	[super update];
	
}


@end
