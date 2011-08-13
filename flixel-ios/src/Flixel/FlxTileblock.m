//
//  FlxTileblock.m
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

#import <Flixel/Flixel.h>

int zDepth = 2;

@interface FlxTileblock ()
- (void) renderBlock; 
@end

@implementation FlxTileblock

@synthesize arbitraryID;
@synthesize index;

@synthesize  moving;
@synthesize  moveStart;
@synthesize  moveEnd;
@synthesize  moveSpeed;
@synthesize  oscillate;

+ (id) tileblockWithX:(float)X y:(float)Y width:(float)Width height:(float)Height;
{
  return [[[self alloc] initWithX:X y:Y width:Width height:Height] autorelease];
}

- (id) initWithX:(float)X y:(float)Y width:(float)Width height:(float)Height;
{
  if ((self = [super initWithX:X y:Y width:Width height:Height])) {
    fixed = YES;
    byteCount = 0;
    verticesUVs = NULL;
    [self refreshHulls];
  }
  return self;
}

- (void) dealloc
{
  [texture release];
  [super dealloc];
}



// - (void) setY:(float)newY
// {
//   NSLog(@"setting y to : %f, old : %f", newY, self.y);
//   [super setY:newY];
// }

- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint isGradient:(int)repeats arbitraryID:(int)ArbitraryID index:(int)Index {
    if (TileGraphic == nil) {
        NSLog(@"can't load a null graphic");
        return self;
    }
    
    if (texture != nil) {
        [texture release];
        texture = nil;
    }
    
    texture = [[FlxG addTextureWithParam1:TileGraphic param2:NO] retain];
    if (texture == nil) {
        NSLog(@"couldn't find texture");
        return self;
    }
    
    arbitraryID = ArbitraryID;
    index = Index;
    
    moving = NO;
    moveStart = CGPointMake(self.x, self.y);
    moveEnd = CGPointMake(self.x, self.y);;
    moveSpeed= CGPointMake(0, 0);
    oscillate = YES;
    
    tileSize = texture.height;
    unsigned int widthInTiles = ceil(width*1.0/tileSize);
    unsigned int heightInTiles = ceil(height*1.0/tileSize);
    width = widthInTiles * tileSize;
    height = heightInTiles * tileSize;
    //unsigned int numTiles = widthInTiles*heightInTiles;
    unsigned int numGraphics = texture.width/tileSize;
    
    int m = widthInTiles;
    int n = heightInTiles;
    
    vertexCount = 4*m + (2 + 4*m)*(n-1);
    unsigned int newByteCount = sizeof(GLshort)*vertexCount*2*2;
    if (verticesUVs != NULL && newByteCount > byteCount)
        free(verticesUVs);
    if (verticesUVs == NULL || newByteCount > byteCount) {
        byteCount = newByteCount;
        verticesUVs = malloc(byteCount);
    }
    
    uShort = [FlxGLView convertToShort:tileSize/texture.paddedWidth];
    vShort = [FlxGLView convertToShort:tileSize/texture.paddedHeight];
    
    //for (unsigned int i = 0; i < numTiles; ++i) {
    int vi = 0;
    for (unsigned int j=0; j<n; ++j) {
        for (unsigned int i=0; i<m; ++i) {
            if (i == 0) {
                if (j != 0) { //add in 'stitching'
                    verticesUVs[vi] = (GLshort)(m*tileSize);
                    verticesUVs[vi+1] = (GLshort)(j*tileSize);
                    verticesUVs[vi+4] = (GLshort)(0);
                    verticesUVs[vi+5] = (GLshort)(j*tileSize);
                    //doesn't matter what uvs are set to
                    verticesUVs[vi+2] = verticesUVs[vi+3] = verticesUVs[vi+6] = verticesUVs[vi+7] = 0;
                    vi += 8;
                }
            }
            verticesUVs[vi] = (GLshort)(i*tileSize);
            verticesUVs[vi+1] = (GLshort)(j*tileSize);
            verticesUVs[vi+4] = (GLshort)(i*tileSize);
            verticesUVs[vi+5] = (GLshort)((j+1)*tileSize);
            verticesUVs[vi+8] = (GLshort)((i+1)*tileSize);
            verticesUVs[vi+9] = (GLshort)(j*tileSize);
            verticesUVs[vi+12] = (GLshort)((i+1)*tileSize);
            verticesUVs[vi+13] = (GLshort)((j+1)*tileSize);
            if (FlxU.random * (numGraphics + Empties) > Empties || Empties == 0) {
                int gi;
                if (!AutoTile) {
                    gi = FlxU.random*numGraphics;
                    
                }
                
                else {
                    gi = 14 + FlxU.random*(numGraphics - 14);
                    //int gi = 12;
                    //determine which block to use:
                    if (j==0 && i == 0) { //top left
                        gi = 0; 
                    } else if (j==0 && i == m-1) { //top right
                        gi = 1;
                    } else if (j==n-1 && i == 0) { //bottom left
                        gi = 2;
                    } else if (j==n-1 && i == m-1) { //bottom right
                        gi = 3;
                    } else if (j==0 && i!=0 && i!=m-1) { //straight top
                        gi = 4;
                    } else if (j==n-1 && i!=0 && i!=m-1) { //straight bottom
                        gi = 5;
                    } else if (i==0 && j!=0 && j!=n-1) { //left down straight
                        gi = 6;
                    } else if (i==m-1 && j!=0 && j!=n-1) { //right down straight
                        gi = 7;
                    } 
                    
                    if (m==1 && j==0) { //top single down.
                        gi = 12;
                    } else if (m==1 && j==n-1) { //bottom single down.
                        gi = 13;
                    } else if (m==1 ) { // single straight down
                        gi = 11;
                    } else if (n==1 && i==0) { //single flat first
                        gi = 9;
                    } else if (n==1 && i==m-1) { //single flat horizontal last.
                        gi = 10;
                    } else if (n==1 ) { // single flat horizontal middle
                        gi = 8;
                    }
                }
                
                if (LocationOfPoint !=0 ) {
                    if (j==0 && i == 0) { //top left
                        gi = 0;
                    } else if (j==0 && i == m-1) { //top right
                        gi = 1;
                    } else if (j==n-1 && i == 0) { //bottom left
                        gi = 2;
                    } else if (j==n-1 && i == m-1) { //bottom right
                        gi = 3;
                    } else if (j==0 && i!=0 && i!=m-1) { //straight top
                        gi = 4;
                    } else if (j==n-1 && i!=0 && i!=m-1) { //straight bottom
                        gi = 5;
                    } else if (i==0 && j!=0 && j!=n-1) { //left down straight
                        gi = 6;
                    } else if (i==m-1 && j!=0 && j!=n-1) { //right down straight
                        gi = 7;
                    }                     
                    
                    else { //empty
                        gi = 8;
                    }
                    
                    if (j==n-1 && i==LocationOfPoint) { //Location of Point!!! can be 9 or 10.
                        gi = 9;
                    }
                    
                    
                }
                
                if (repeats !=0 ) {
                    if (j<repeats) { //straight top
                        gi = 0;
                    } else if (j<repeats*2) { //straight top
                        gi = 1;
                    } else if (j<repeats*3) { //straight top
                        gi = 2;
                    } else if (j<repeats*4) { //straight top
                        gi = 3;
                    } else if (j<repeats*5) { //straight top
                        gi = 4;
                    } else if (j<repeats*6) { //straight top
                        gi = 5;
                    } else if (j<repeats*7) { //straight top
                        gi = 6;
                    } else if (j<repeats*8) { //straight top
                        gi = 7;
                    } else if (j<repeats*9) { //straight top
                        gi = 8;
                    } else if (j<repeats*10) { //straight top
                        gi = 9;
                    } else if (j<repeats*11) { //straight top
                        gi = 10;
                    } else if (j<repeats*12) { //straight top
                        gi = 11;
                    } else if (j<repeats*13) { //straight top
                        gi = 12;
                    } else if (j<repeats*14) { //straight top
                        gi = 13;
                    } else if (j<repeats*15) { //straight top
                        gi = 14;
                    } else if (j<repeats*16) { //straight top
                        gi = 15;
                    } else if (j<repeats*17) { //straight top
                        gi = 16;
                    }
                    
                    
                    
                    
                    
                }
                
                
                
                if (texture.atlasTexture) {
                    verticesUVs[vi+2] = (GLshort)(gi*uShort*texture.atlasScale.x + texture.atlasOffset.x + 0.5);
                    verticesUVs[vi+3] = (GLshort)(0 + texture.atlasOffset.y + 0.5);
                    verticesUVs[vi+6] = (GLshort)(gi*uShort*texture.atlasScale.x + texture.atlasOffset.x + 0.5);
                    verticesUVs[vi+7] = (GLshort)(vShort*texture.atlasScale.y + texture.atlasOffset.y + 0.5);
                    verticesUVs[vi+10] = (GLshort)((gi+1)*uShort*texture.atlasScale.x + texture.atlasOffset.x + 0.5);
                    verticesUVs[vi+11] = (GLshort)(0 + texture.atlasOffset.y + 0.5);
                    verticesUVs[vi+14] = (GLshort)((gi+1)*uShort*texture.atlasScale.x + texture.atlasOffset.x + 0.5);
                    verticesUVs[vi+15] = (GLshort)(vShort*texture.atlasScale.y + texture.atlasOffset.y + 0.5);
                } else {
                    verticesUVs[vi+2] = gi*uShort;
                    verticesUVs[vi+3] = 0;
                    verticesUVs[vi+6] = gi*uShort;
                    verticesUVs[vi+7] = vShort;
                    verticesUVs[vi+10] = (gi+1)*uShort;
                    verticesUVs[vi+11] = 0;
                    verticesUVs[vi+14] = (gi+1)*uShort;
                    verticesUVs[vi+15] = vShort;
                }
            } else {
                //blank entry
                verticesUVs[vi+2] = verticesUVs[vi+3] = verticesUVs[vi+6] = verticesUVs[vi+7] =
                verticesUVs[vi+10] = verticesUVs[vi+11] = verticesUVs[vi+14] = verticesUVs[vi+15] = 0;
            }
            vi += 16;
        }
    }
    return self;
}


#pragma mark returners

- (id) loadGraphic:(NSString *)TileGraphic;
{
    return [self loadGraphic:TileGraphic empties:0 autoTile:NO isSpeechBubble:0  isGradient:0 arbitraryID:0 index:0];
}


- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint isGradient:(int)repeats arbitraryID:(int)ArbitraryID {
        return [self loadGraphic:TileGraphic empties:Empties autoTile:AutoTile isSpeechBubble:LocationOfPoint isGradient:repeats  arbitraryID:ArbitraryID index:0];
}



- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint isGradient:(int)repeats {
    return [self loadGraphic:TileGraphic empties:Empties autoTile:AutoTile isSpeechBubble:LocationOfPoint isGradient:repeats  arbitraryID:0 index:0];
    
}

- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile isSpeechBubble:(int)LocationOfPoint {
    return [self loadGraphic:TileGraphic empties:Empties autoTile:AutoTile isSpeechBubble:LocationOfPoint isGradient:0  arbitraryID:0 index:0];

    
}

- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties autoTile:(BOOL)AutoTile {
    return [self loadGraphic:TileGraphic empties:Empties autoTile:AutoTile isSpeechBubble:0 isGradient:0  arbitraryID:0 index:0];

}

#pragma mark moving Block

- (void) moveBlock {
//    moveStart = CGPointMake(self.x, self.y);
//    moveEnd = CGPointMake(self.x, self.y);;
//    moveSpeed= 10;
//    oscillate = YES;
    
    //self.velocity = CGPointMake(moveSpeed.x, moveSpeed.y);
    
    //yes we are moving and moving left
    
    if (self.velocity.x < 0) {
        //NSLog(@"moving left");
        //self.velocity = CGPointMake(-moveSpeed.x, 0);
        if (self.x < moveStart.x) {
            self.x = moveStart.x;
            
            if (oscillate) self.velocity = CGPointMake(-self.velocity.x, 0);
            else {
                self.velocity = CGPointMake(0, 0);
                self.x = moveStart.x;
                self.y = moveStart.y;
            }
        }
    } 
    //moving right
    else if (self.velocity.x > 0){
        //NSLog(@"moving rigght");
        //self.velocity = CGPointMake(moveSpeed.x, 0);
        if (self.x > moveEnd.x) {
            self.x = moveEnd.x;

            if (oscillate) self.velocity = CGPointMake(-self.velocity.x, 0);
            else {
                self.velocity = CGPointMake(0, 0);
                self.x = moveEnd.x;
                self.y = moveEnd.y;
            }
        }    
    }
    if (self.velocity.y < 0) {
        //NSLog(@"moving left");
        //self.velocity = CGPointMake(-moveSpeed.x, 0);
        if (self.y < moveStart.y) {
            self.y = moveStart.y;
            
            if (oscillate) self.velocity = CGPointMake(0,-self.velocity.y);
            else {
                self.velocity = CGPointMake(0, 0);
                self.x = moveStart.x;
                self.y = moveStart.y;
            }
        }
    } 
    //moving right
    else if (self.velocity.y > 0){
        //NSLog(@"moving rigght");
        //self.velocity = CGPointMake(moveSpeed.x, 0);
        if (self.y > moveEnd.y) {
            self.y = moveEnd.y;
            
            if (oscillate) self.velocity = CGPointMake(0,-self.velocity.y);
            else {
                self.velocity = CGPointMake(0, 0);
                self.x = moveEnd.x;
                self.y = moveEnd.y;
            }
        }    
    }    
    
    
    
    
}


#pragma mark renderers

- (void) render;
{
    [self renderBlock];
}

- (void) renderBlock
{
    if (texture == nil)
        return;
    if (moving) {
        [self moveBlock];
    }
    CGPoint _point = [self getScreenXY];
    [[self class] bind:texture.texture];
    glPushMatrix();
    glTranslatef(_point.x, _point.y, 0);
    glVertexPointer(2, GL_SHORT, sizeof(GLshort)*4, &verticesUVs[0]);
    glTexCoordPointer(2, GL_SHORT, sizeof(GLshort)*4, &verticesUVs[2]);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, vertexCount);
    glPopMatrix();
    zDepth++;    
}

- (id) loadGraphic:(NSString *)TileGraphic empties:(unsigned int)Empties;
{
    return [self loadGraphic:TileGraphic empties:Empties autoTile:NO];

}

@end
