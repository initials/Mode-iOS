#import "Notch.h"

static NSString * ImgNotch = @"notch.png";

@implementation Notch



+ (id) notchWithOrigin:(CGPoint)Origin
{
	return [[[self alloc] initWithOrigin:Origin] autorelease];
}

- (id) initWithOrigin:(CGPoint)Origin
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
		
		[self loadGraphicWithParam1:ImgNotch param2:YES param3:NO param4:8 param5:8];
		[self addAnimationWithParam1:@"on" param2:[NSMutableArray intArrayWithSize:1 ints:0] param3:0];
		[self addAnimationWithParam1:@"off" param2:[NSMutableArray intArrayWithSize:1 ints:1] param3:0];
        [self play:@"on"];
        self.x = Origin.x;
        self.y = Origin.y;
	}
	
	return self;	
}


- (void) dealloc
{
	
	[super dealloc];
}


- (void) update
{   
	
	[super update];
	
}


@end
