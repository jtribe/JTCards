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

#import "UIView+Position.h"

@implementation UIView (Position)
- (void) moveDownBy:(CGFloat)down {
    self.center = CGPointMake(self.center.x, self.center.y+down);
}
- (void) moveUpBy:(CGFloat)up {
    [self moveDownBy:-1*up];
}
- (void) moveRightBy:(CGFloat)right {
    self.center = CGPointMake(self.center.x+right, self.center.y);
}
- (void) moveLeftBy:(CGFloat)left {
    [self moveRightBy:-1*left];
}
- (void) moveCenterYTo:(CGFloat)y {
    self.center = CGPointMake(self.center.x, y);
}
- (void) moveCenterXTo:(CGFloat)x {
    self.center = CGPointMake(x, self.center.y);
}
- (void) setOriginTo:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}
- (void) increaseHeightBy:(CGFloat)offset {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+offset);
}
- (void) increaseWidthBy:(CGFloat)offset{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+offset, self.frame.size.height);    
}
- (void) setHeightTo:(CGFloat)dimension{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, dimension);
}
- (void) setWidthTo:(CGFloat)dimension{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, dimension, self.frame.size.height);
}

+ (CGRect) makeZeroRect {
    return CGRectMake(0, 0, 0, 0);
}
+ (CGRect) rectWithRect:(CGRect)rect {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

+ (CGSize) sizeWithSize:(CGSize)size scale:(CGFloat)scale {
  return CGSizeMake(size.width*scale, size.height*scale);
}
+ (NSString*) stringForRect:(CGRect)rect {
    return [NSString stringWithFormat:@"(%f,%f,%f,%f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}
+ (CGFloat) screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat) screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

- (void) centerOnScreen {
    [self moveCenterXTo:[UIScreen mainScreen].bounds.size.width/2];
    [self moveCenterYTo:[UIScreen mainScreen].bounds.size.height/2];
}

- (void)centerOnSuperview {
    [self centerYOnSuperview];
    [self centerXOnSuperview];
}

- (void)centerYOnSuperview {
    [self moveCenterYTo:(self.superview.bounds.size.height/2)];
}

- (void)centerXOnSuperview {
    [self moveCenterXTo:self.superview.bounds.size.width/2];
}
- (void) rightAlign {
    [self moveRightBy:self.superview.bounds.size.width - self.bounds.size.width];
}
- (void) leftAlign {
    [self setOriginTo:CGPointMake(0.0, self.frame.origin.y)];
}
- (void) topAlign {
    [self setOriginTo:CGPointMake(self.frame.origin.x, 0.0)];
}
- (void) bottomAlign {
    // assumes it is already in a view hirarchy and has a superview
    [self setOriginTo:CGPointMake(self.frame.origin.x, self.superview.bounds.size.height-self.bounds.size.height)];
}
- (CGFloat) x {
    return self.frame.origin.x;
}
- (CGFloat) y {
    return self.frame.origin.y;
}
- (CGFloat) w {
    return self.bounds.size.width;
}
- (CGFloat) h {
    return self.bounds.size.height;
}

@end

