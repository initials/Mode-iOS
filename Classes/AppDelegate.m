// This is the license from the Flash version.
// 
// Copyright (c) 2009 Adam 'Atomic' Saltsman
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// NOTE FROM THE AUTHOR: As far as I know, you only have to include
// this license if you are redistributing source code that includes
// the Flixel library.  There is no need (or way, afaik) to include
// it in your compiled flash games and apps!
// 
// NOTE FROM THE iOS PORT CODER: I have only ported this game to iOS.
// I do not claim to own any copyright over this game. All ownership
// stays with the original author.

#import "AppDelegate.h"
#import "Mode.h"
#import <SemiSecret/SemiSecretTexture.h>

void preloadTextureAtlases()
{
    NSDictionary * infoDictionary = nil;
    if (FlxG.iPad)
        infoDictionary = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"iPadTextureAtlas.atlas"]];
    else
        infoDictionary = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"textureAtlas.atlas"]];
    
    //can only contain NSData, NSDate, NSNumber, NSString, NSArray, and NSDictionary
    
    NSDictionary * images = [infoDictionary objectForKey:@"images"];
    
    for (NSString * image in images) {
        NSDictionary * imageInfo = [images objectForKey:image];
        CGRect placement;
        placement.origin.x = [[imageInfo objectForKey:@"placement.origin.x"] floatValue];
        placement.origin.y = [[imageInfo objectForKey:@"placement.origin.y"] floatValue];
        placement.size.width = [[imageInfo objectForKey:@"placement.size.width"] floatValue];
        placement.size.height = [[imageInfo objectForKey:@"placement.size.height"] floatValue];
        NSString * atlas = [imageInfo objectForKey:@"atlas"];
        SemiSecretTexture * textureAtlas = [FlxG addTextureWithParam1:atlas param2:NO];
        SemiSecretTexture * texture = [SemiSecretTexture textureWithAtlasTexture:textureAtlas
                                                                          offset:placement.origin
                                                                            size:placement.size];
        [FlxG setTexture:texture forKey:image];
    }
    
}

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //in canabalt, we never want linear filtering (not even on ipad)
    [SemiSecretTexture setTextureFilteringMode:SSTextureFilteringNearest];
    
    [application setStatusBarOrientation:UIInterfaceOrientationLandscapeRight
                                animated:NO];
    
    game = [[Mode alloc] init];
    
    //preload textures here, now that opengl stuff should be created
    //preloadTextureAtlases();
    
//    [self authenticateLocalPlayer];
    
    return YES;
}

//- (void) authenticateLocalPlayer
//{
//    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
//    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
//        if (localPlayer.isAuthenticated)
//        {
//            // Perform additional tasks for the authenticated player.
//        }
//    }];
//}


- (void) applicationDidEnterBackground:(UIApplication *)application
{
    [FlxG didEnterBackground];
}

- (void) applicationWillEnterForeground:(UIApplication *)application
{
    [FlxG willEnterForeground];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
    [FlxG willResignActive];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
    [FlxG didBecomeActive];
}

- (void) applicationWillTerminate:(UIApplication *)application
{
}

- (void) dealloc
{
    [game release];
    [super dealloc];
}

@end
