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

#import "NSDictionary+Access.h"

@implementation NSDictionary (Access)

- (id)valueForKey:(id)key ifKindOf:(Class)aClass {
    return [self valueForKey:key ifKindOf:aClass defaultValue:nil];
}

- (id)valueForKey:(id)key ifKindOf:(Class)aClass defaultValue:(id)defaultValue {
    id value = [self objectForKey:key];
    return [value isKindOfClass:aClass] ? value : defaultValue;
}

- (id)valueForKeyPath:(NSString *)path ifKindOf:(Class)aClass defaultValue:(id)defaultValue {
    id value = [self valueForKeyPath:path];
    return [value isKindOfClass:aClass] ? value : defaultValue;
}


- (NSString *)stringValueForKeyPath:(NSString *)key defaultValue:(NSString*)defaultValue {
    return [self valueForKeyPath:key ifKindOf:[NSString class] defaultValue:defaultValue];
}

- (NSString *)stringValueForKeyPath:(NSString *)key {
    return [self stringValueForKeyPath:key defaultValue:nil];
}

- (NSArray *)arrayValueForKeyPath:(NSString *)key defaultValue:(id)defaultValue {
    return [self valueForKeyPath:key ifKindOf:[NSArray class] defaultValue:defaultValue];
}

- (NSArray *)arrayValueForKeyPath:(NSString *)key{
    return [self arrayValueForKeyPath:key defaultValue:nil];
}

- (NSDictionary *)dictionaryValueForKeyPath:(NSString *)key defaultValue:(id)defaultValue {
    return [self valueForKeyPath:key ifKindOf:[NSDictionary class] defaultValue:defaultValue];;
}

- (NSDictionary *)dictionaryValueForKeyPath:(NSString *)key {
    return [self dictionaryValueForKeyPath:key defaultValue:[NSDictionary dictionary]];
}

- (NSURL *)urlValueForKeyPath:(NSString *)key 
{
    NSString *stringValue = [self stringValueForKeyPath:key defaultValue:nil];
    return stringValue==nil ? nil : [NSURL URLWithString:stringValue];
}

- (NSInteger)intValueForKeyPath:(NSString *)key defaultValue:(NSInteger)defaultValue {
    return [[self valueForKeyPath:key ifKindOf:[NSNumber class] defaultValue:[NSNumber numberWithInt:defaultValue]] intValue];
}

- (NSUInteger)unsignedIntValueForKeyPath:(NSString *)key defaultValue:(NSUInteger)defaultValue {
    return [[self valueForKeyPath:key ifKindOf:[NSNumber class] defaultValue:[NSNumber numberWithUnsignedInt:defaultValue]] unsignedIntValue];
}

- (double)doubleValueForKeyPath:(NSString *)key defaultValue:(double)defaultValue {
    return [[self valueForKeyPath:key ifKindOf:[NSNumber class] defaultValue:[NSNumber numberWithDouble:defaultValue]] doubleValue];
}

- (double)floatValueForKeyPath:(NSString *)key defaultValue:(float)defaultValue {
    return [[self valueForKeyPath:key ifKindOf:[NSNumber class] defaultValue:[NSNumber numberWithFloat:defaultValue]] floatValue];
}

- (BOOL)boolValueForKeyPath:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [[self valueForKeyPath:key ifKindOf:[NSNumber class] defaultValue:[NSNumber numberWithBool:defaultValue]] boolValue];
}

- (NSInteger)intValueForKeyPath:(NSString *)key {
    return [self intValueForKeyPath:key defaultValue:0];
}

- (NSUInteger)unsignedIntValueForKeyPath:(NSString *)key {
    return [self unsignedIntValueForKeyPath:key defaultValue:0];
}

- (double)doubleValueForKeyPath:(NSString *)key {
    return [self doubleValueForKeyPath:key defaultValue:0];
}

- (double)floatValueForKeyPath:(NSString *)key {
    return [self floatValueForKeyPath:key defaultValue:0];
}

- (BOOL)boolValueForKeyPath:(NSString *)key {
    return [self boolValueForKeyPath:key defaultValue:FALSE];
}

@end

