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

@interface NSDictionary (Access)

// Generic values
- (id)valueForKey:(id)key ifKindOf:(Class)aClass;
- (id)valueForKey:(id)key ifKindOf:(Class)aClass defaultValue:(id)defaultValue;
- (id)valueForKeyPath:(NSString *)path ifKindOf:(Class)aClass defaultValue:(id)defaultValue;

// String values
- (NSString *)stringValueForKeyPath:(NSString *)key defaultValue:(NSString*)defaultValue;
- (NSString *)stringValueForKeyPath:(NSString *)key;

// Array values
- (NSArray *)arrayValueForKeyPath:(NSString *)key;  // Defaults to nil
- (NSArray *)arrayValueForKeyPath:(NSString *)key defaultValue:(id)defaultValue;

// Dictionary values
- (NSDictionary *)dictionaryValueForKeyPath:(NSString *)key;

// URL
- (NSURL *)urlValueForKeyPath:(NSString*)key;

// Primitive Values
- (NSInteger)intValueForKeyPath:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (NSUInteger)unsignedIntValueForKeyPath:(NSString *)key defaultValue:(NSUInteger)defaultValue;
- (double)doubleValueForKeyPath:(NSString *)key defaultValue:(double)defaultValue;
- (double)floatValueForKeyPath:(NSString *)key defaultValue:(float)defaultValue;
- (BOOL)boolValueForKeyPath:(NSString *)key defaultValue:(BOOL)defaultValue;

- (NSInteger)intValueForKeyPath:(NSString *)key;
- (NSUInteger)unsignedIntValueForKeyPath:(NSString *)key;
- (double)doubleValueForKeyPath:(NSString *)key;
- (double)floatValueForKeyPath:(NSString *)key;
- (BOOL)boolValueForKeyPath:(NSString *)key;
@end
