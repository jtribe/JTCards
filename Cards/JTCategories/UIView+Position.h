// Copyright (C) 2012 jTribe Labs Pty Ltd
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


// Simple UIView positioning. Great when you need to move views around dymanically.

#import <UIKit/UIKit.h>

@interface UIView (Position)

- (void) moveDownBy:(CGFloat)down;
- (void) moveUpBy:(CGFloat)up;
- (void) moveRightBy:(CGFloat)up;
- (void) moveLeftBy:(CGFloat)left;
- (void) moveCenterYTo:(CGFloat)y;
- (void) moveCenterXTo:(CGFloat)x;
- (void) setOriginTo:(CGPoint)point;
- (void) increaseHeightBy:(CGFloat)offset;
- (void) increaseWidthBy:(CGFloat)offset;
- (void) setHeightTo:(CGFloat)dimension;
- (void) setWidthTo:(CGFloat)dimension;
+ (CGRect) makeZeroRect;
+ (CGRect) rectWithRect:(CGRect)rect;
+ (CGSize) sizeWithSize:(CGSize)size scale:(CGFloat)scale;
+ (NSString*) stringForRect:(CGRect)rect;
+ (CGFloat) screenWidth;
+ (CGFloat) screenHeight;
- (void) centerOnScreen;
- (void) centerOnSuperview;
- (void) centerYOnSuperview;
- (void) centerXOnSuperview;
- (void) rightAlign;
- (void) leftAlign;
- (void) topAlign;
- (void) bottomAlign;
- (CGFloat) x;
- (CGFloat) y;
- (CGFloat) w;
- (CGFloat) h;


@end

