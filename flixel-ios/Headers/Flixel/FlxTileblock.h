//
//  FlxTileblock.h
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


#import <Flixel/FlxObject.h>
#import <OpenGLES/ES1/gl.h>

@class SemiSecretTexture;

@interface FlxTileblock : FlxObject
{
  SemiSecretTexture * texture;
  GLshort * verticesUVs;
  GLshort uShort;
  GLshort vShort;

  CGFloat tileSize;
  unsigned int vertexCount;
  unsigned int empties;
  unsigned int byteCount;

  int arbitraryID;
  int index;

  BOOL moving;
  CGPoint moveStart;
  CGPoint moveEnd;
  CGPoint moveSpeed;
  BOOL oscillate;

}

+ (id) tileblockWithX:(float)X y:(float)Y width:(float)Width height:(float)Height;
- (id) initWithX:(float)X y:(float)Y width:(float)Width height:(float)Height;
- (id) loadGraphic:(NSString *)TileGraphic;
- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties;
- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile;
- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint;
- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint isGradient:(int)repeats;
- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint isGradient:(int)repeats arbitraryID:(int)ArbitraryID;
- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint isGradient:(int)repeats arbitraryID:(int)ArbitraryID index:(int)Index;


- (void) render;

@property int arbitraryID;
@property int index;

@property BOOL moving;
@property CGPoint moveStart;
@property CGPoint moveEnd;
@property CGPoint moveSpeed;
@property BOOL oscillate;


@end

