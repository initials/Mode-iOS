#import "Mode.h"

@implementation Mode

- (id) init
{
	float gameZoom = 1.0 * ([FlxG iPad] ? 2 : 1) * ([FlxG retinaDisplay] ? 2 : 1);
	if ((self = [super initWithOrientation:FlxGameOrientationLandscape
									 state:@"MenuState"
									  zoom:gameZoom]))
	{
		if (FlxG.retinaDisplay)
			self.frameInterval = 1;
	}
	return self;
}

@end