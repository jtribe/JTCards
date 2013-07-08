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

#import "NSDate+Expanded.h"

@implementation NSDate (Expanded)

// FIXME: this is error prone, as the same components in UTC wont be the same in Australia/Melbourne
- (BOOL)isSameDayAs:(NSDate *)date {
    BOOL sameDay = NO;
    
    if (!date) {
        return sameDay;
    }
    
    // Convert both dates into local time
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
    NSDateComponents *firstComps = [calendar components:unitFlags fromDate:self];
    NSDateComponents *secondComps = [calendar components:unitFlags fromDate:date];
    sameDay = ([firstComps year] == [secondComps year] 
               && [firstComps month] == [secondComps month] 
               && [firstComps day] == [secondComps day]);    
    return sameDay;
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:days];
    NSDate *movedDate = [calendar dateByAddingComponents:dateComponents toDate:self options:0];
    return movedDate;
}

-(NSDate*)dateAtMidnightInLocalTimeZone
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];

    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSTimeZoneCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    
    return [calendar dateFromComponents:components];
}

+ (NSDateFormatter*) utc8601DateFormatter {
    NSDateFormatter *_utc8601DateFormatter = [[NSDateFormatter alloc] init];
    [_utc8601DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [_utc8601DateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];       
    return _utc8601DateFormatter;
}

- (NSString *)stringByFormattingTheDayOfWeek {
    NSDateFormatter *dayOfWeekFormatter = [[NSDateFormatter alloc] init];
    [dayOfWeekFormatter setDateFormat:@"EEEE"];
//        [dayOfWeekFormatter setTimeZone:[DateTimeStringFormatter timeZone]];
    return [dayOfWeekFormatter stringFromDate:self];
}

+ (NSDate*)dateFromISO8601String:(NSString*)iso8610
{
    return [[self utc8601DateFormatter] dateFromString:iso8610];
}

- (NSString*)stringByCovertingToISO8601
{
    return [[NSDate utc8601DateFormatter] stringFromDate:self];
}

- (NSString *)stringByFormattingTheDayOfTheMonthWithOrdinalSuffix {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit fromDate:self];
    NSInteger dayOfMonth = [dateComponents day];
    NSString *suffix = @"th";
    if (dayOfMonth == 1) {
        suffix = @"st";
    } else if (dayOfMonth == 2) {
        suffix = @"nd";
    } else if (dayOfMonth == 3) {
        suffix = @"rd";
    } else if (dayOfMonth == 21) {
        suffix = @"st";
    } else if (dayOfMonth == 22) {
        suffix = @"nd";
    } else if (dayOfMonth == 23) {
        suffix = @"rd";
    } else if (dayOfMonth == 31) {
        suffix = @"st";
    }
    return [NSString stringWithFormat:@"%d%@", dayOfMonth, suffix];
}


- (NSString *)stringByDescribingRelativeDay {
    NSMutableString *messageLabelString = [NSMutableString string];
    NSDate *now = [NSDate date];
    if ([self isSameDayAs:now]) {
        [messageLabelString appendString:@"Today"];
    } else if ([self isSameDayAs:[now dateByAddingDays:1]]) {
        [messageLabelString appendString:@"Tomorrow"];
    } else if ([self isSameDayAs:[now dateByAddingDays:-1]]) {
        [messageLabelString appendString:@"Yesterday"];
    } else {
        [messageLabelString appendFormat:@"%@ %@", [self stringByFormattingTheDayOfWeek], 
         [self stringByFormattingTheDayOfTheMonthWithOrdinalSuffix]];
    }
    return messageLabelString;
}

- (NSString*)stringByFormattingInMediumDateFormat
{
    NSDateFormatter *mediumDateFormatter = [[NSDateFormatter alloc] init];
    [mediumDateFormatter setDateFormat:@"dd MMM yyyy, h:mm a"]; 
    return [mediumDateFormatter stringFromDate:self];
}

- (NSString*)stringByFormattingInShortDateFormat
{
    NSDateFormatter *shortDateFormatter = [[NSDateFormatter alloc] init];
    [shortDateFormatter setDateFormat:@"yyyy-MM-dd"]; 
    return [shortDateFormatter stringFromDate:self];
}

- (NSString *)stringByFormattingInAbsoluteTimeFormat
{    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    return [formatter stringFromDate:self];
}

- (NSString *)stringByFormattingInRelativeTimeFormat
{    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSMinuteCalendarUnit | NSSecondCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:[NSDate date] 
                                                  toDate:self
                                                 options:0];
    NSInteger minutes = [components minute];
    NSInteger seconds = [components second];
    NSInteger hours = [components hour];
    //NSInteger days = [components day];
    NSInteger dateInThePast = (fabs(hours) != hours || fabs(minutes) != minutes || fabs(seconds) != seconds) ? -1: 1;
    
    hours = abs(hours);
    minutes = abs(minutes);
    seconds = abs(seconds);
    
    if (hours !=0) {
        NSInteger rounding = hours +round(minutes/60.0f);
        return [NSString stringWithFormat:@"%d:hr+", dateInThePast*rounding];
    }else if (minutes != 0) {
        NSInteger rounding = minutes +round(seconds/60.0f);
        return [NSString stringWithFormat:@"%d:min", dateInThePast*rounding];
    } else {
        //less than a minute
        if (seconds < 15) {
            return @"Now";
        } else {
            return [NSString stringWithFormat:@"%d:min", dateInThePast*1];
        }
    } 
}

- (NSString *)stringByCalculatingRelativeTimeUntil:(NSDate*)toDate 
{
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *components = [gregorianCalendar components:unitFlags
                                                        fromDate:self
                                                          toDate:toDate
                                                         options:0];    
    NSInteger minutes = [components minute];
    NSInteger hours = [components hour];
    
    if(hours>0) {
        NSMutableString *result = [[NSMutableString alloc]init];
        if (hours >0 && hours == 1) {
            [result appendString:@"1h"];
        } else if (hours > 1) {
            [result appendFormat:@"%ih",hours];
        }
        
        [result appendString:[result length] > 0 ? @" " : @""];
        if (minutes > 0)
            [result appendFormat:@"%im",minutes];      
        
        return result;
    } else {
        if (minutes == 1) {
            return @"1min";
        } else {
            return [NSString stringWithFormat:@"%imins", minutes];
        }
    }
}

@end
