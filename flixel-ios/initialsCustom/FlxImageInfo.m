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


// Black pixel = 1



#import "FlxImageInfo.h"

@implementation FlxImageInfo


+ (NSData *) readImage:(NSString *)imageToRead
{    
    //NSLog(@"I am reading an image");

    
    UIImage* image = [UIImage imageNamed:imageToRead]; // An image
    NSData* pixelData = (NSData*) CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    //unsigned char* pixelBytes = (unsigned char *)[pixelData bytes];
    
//    // Take away the red pixel, assuming 32-bit RGBA
//    for(int i = 0; i < [pixelData length]; i += 4) {
////        pixelBytes[i] = 0; // red
////        pixelBytes[i+1] = pixelBytes[i+1]; // green
////        pixelBytes[i+2] = pixelBytes[i+2]; // blue
////        pixelBytes[i+3] = pixelBytes[i+3]; // alpha
//        
//        NSLog(@"PIXEL DATA %d %hhu %hhu %hhu %hhu", i, pixelBytes[i], pixelBytes[i+1], pixelBytes[i+2], pixelBytes[i+3]);
//    } 
    
    return pixelData;
    
    
}


@end
