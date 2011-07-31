#import "EnemyBullet.h"

static NSString * ImgBullet = @"bot_bullet.png";
static NSString * SndHit = @"jump.caf";
static NSString * SndShoot = @"shoot.caf";



@implementation EnemyBullet

@synthesize speed;


+ (id) enemyBulletWithOrigin:(CGPoint)Origin
{
	return [[[self alloc] initWithOrigin:Origin] autorelease];
}



- (id) initWithOrigin:(CGPoint)Origin
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        [self loadGraphicWithParam1:ImgBullet param2:YES param3:NO param4:4 param5:4];
        
        self.width = 6;
        self.height = 6;
        self.offset = CGPointMake(1, 1);
        
        [self addAnimationWithParam1:@"idle" param2:[NSMutableArray intArrayWithSize:2 ints:0,1] param3:25 param4:NO];
        [self addAnimationWithParam1:@"explode" param2:[NSMutableArray intArrayWithSize:4 ints:2,3,4,5] param3:25 param4:NO];        
        speed = 120;
        [self play:@"idle"];
        
        
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
    self.x = loc.x+self.width/2,
    self.y = loc.y+self.height/2;
    self.dead = NO;
    //solid = true;
    
    self.velocity = [FlxU rotatePointWithParam1:0 param2:speed param3:0 param4:0 param5:aim];
    
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
    self.velocity = CGPointMake(0, 0);
    
} 




- (void) update
{	
    if (_curFrame==3) {
        //NSLog(@"Enemy Bullet Dead");
        self.velocity = CGPointMake(0, 0);
        self.dead = YES;
        self.x = 900;
        self.y = 900;
        [self play:@"idle"];
    }
    
	[super update];
	
}


@end
