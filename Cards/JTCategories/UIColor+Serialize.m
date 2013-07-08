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

#import "UIColor+Serialize.h"
#import "NSDictionary+Access.h"

@implementation UIColor (Serialize)

- (NSDictionary*) toRGBADict
{
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  
  CGFloat red = 0.0 , green = 0.0, blue = 0.0;
  CGFloat alpha  = 1.0;
  
  CGColorRef colorref = [self CGColor];
  int numComponents = CGColorGetNumberOfComponents(colorref);
  if (numComponents == 4) {
    const CGFloat *components = CGColorGetComponents(colorref);
    red    = components[0];
    green  = components[1];
    blue   = components[2];
    alpha  = components[3];
  }

  [dict setObject:[NSString stringWithFormat:@"%.0f", red*255] forKey:@"r"];
  [dict setObject:[NSString stringWithFormat:@"%.0f", green*255] forKey:@"g"];
  [dict setObject:[NSString stringWithFormat:@"%.0f", blue *255] forKey:@"b"];
  [dict setObject:[NSString stringWithFormat:@"%.0f", alpha] forKey:@"a"];
  return dict;
}


+ (UIColor*) colorWithRGBADict:(NSDictionary*)dict
{
  CGFloat red   = [[dict stringValueForKeyPath:@"r"] floatValue]/255.0;
  CGFloat green = [[dict stringValueForKeyPath:@"g"] floatValue]/255.0;
  CGFloat blue  = [[dict stringValueForKeyPath:@"b"] floatValue]/255.0;
  CGFloat alpha = [[dict stringValueForKeyPath:@"a" defaultValue:@"1.0"] floatValue];
  
  UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
  
  return color;
}

@end
