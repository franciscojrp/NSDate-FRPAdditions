// Copyright (c) 2013 Francisco José Rodríguez Pérez
//
// Permission is hereby granted, free of charge, to any
// person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the
// Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice
// shall be included in all copies or substantial portions of
// the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
// KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
// OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "NSDate+FRPAdditions.h"

#define DAY_SECS 86400

@implementation NSDate (FRPAdditions)

- (BOOL)isEqualToDateIgnoringTimeInGMT:(NSDate *)aDate
{
    return [[self dateAtStartOfDayInGMT] isEqualToDate:[aDate dateAtStartOfDayInGMT]];
}

- (BOOL)isEqualToDateIgnoringTimeInSystemTimezone:(NSDate *)aDate
{
    return [[self dateAtStartOfDayInSystemTimezone] isEqualToDate:[aDate dateAtStartOfDayInSystemTimezone]];
}

- (BOOL)isTodayInGMT
{
    unsigned long nowSecsFromReferenceDate = [[NSDate date] timeIntervalSinceReferenceDate];
    unsigned long todayStartSecsFromReferenceDate = nowSecsFromReferenceDate / DAY_SECS * DAY_SECS;
    
    unsigned long selfSecsFromReferenceDate = [self timeIntervalSinceReferenceDate];
    return selfSecsFromReferenceDate > todayStartSecsFromReferenceDate;
}

- (BOOL)isTodayInSystemTimezone
{
    int timezoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    unsigned long nowSecsFromReferenceDate = [[NSDate date] timeIntervalSinceReferenceDate] + timezoneOffset;
    unsigned long todayStartSecsFromReferenceDate = nowSecsFromReferenceDate / DAY_SECS * DAY_SECS;
    
    unsigned long selfSecsFromReferenceDate = [self timeIntervalSinceReferenceDate] + timezoneOffset;
    return selfSecsFromReferenceDate > todayStartSecsFromReferenceDate;
}

- (BOOL)isTomorrowInGMT
{
    unsigned long nowSecsFromReferenceDate = [[NSDate date] timeIntervalSinceReferenceDate];
    unsigned long todayEndSecsFromReferenceDate = nowSecsFromReferenceDate / DAY_SECS * DAY_SECS + DAY_SECS;
    unsigned long tomorrowEndSecsFromReferenceDate = todayEndSecsFromReferenceDate + DAY_SECS;
    
    unsigned long selfSecsFromReferenceDate = [self timeIntervalSinceReferenceDate];
    return selfSecsFromReferenceDate > todayEndSecsFromReferenceDate
        && selfSecsFromReferenceDate < tomorrowEndSecsFromReferenceDate;
}

- (BOOL)isTomorrowInSystemTimezone
{
    int timezoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    unsigned long nowSecsFromReferenceDate = [[NSDate date] timeIntervalSinceReferenceDate] + timezoneOffset;
    unsigned long todayEndSecsFromReferenceDate = nowSecsFromReferenceDate / DAY_SECS * DAY_SECS + DAY_SECS;
    unsigned long tomorrowEndSecsFromReferenceDate = todayEndSecsFromReferenceDate + DAY_SECS;
    
    unsigned long selfSecsFromReferenceDate = [self timeIntervalSinceReferenceDate] + timezoneOffset;
    return selfSecsFromReferenceDate > todayEndSecsFromReferenceDate
    && selfSecsFromReferenceDate < tomorrowEndSecsFromReferenceDate;
}

- (BOOL)isYesterdayInGMT
{
    unsigned long nowSecsFromReferenceDate = [[NSDate date] timeIntervalSinceReferenceDate];
    unsigned long todayStartSecsFromReferenceDate = nowSecsFromReferenceDate / DAY_SECS * DAY_SECS;
    unsigned long yesterdayStartSecsFromReferenceDate = todayStartSecsFromReferenceDate - DAY_SECS;
    
    unsigned long selfSecsFromReferenceDate = [self timeIntervalSinceReferenceDate];
    return selfSecsFromReferenceDate > yesterdayStartSecsFromReferenceDate
        && selfSecsFromReferenceDate < todayStartSecsFromReferenceDate;
}

- (BOOL)isYesterdayInSystemTimezone
{
    int timezoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    unsigned long nowSecsFromReferenceDate = [[NSDate date] timeIntervalSinceReferenceDate] + timezoneOffset;
    unsigned long todayStartSecsFromReferenceDate = nowSecsFromReferenceDate / DAY_SECS * DAY_SECS;
    unsigned long yesterdayStartSecsFromReferenceDate = todayStartSecsFromReferenceDate - DAY_SECS;
    
    unsigned long selfSecsFromReferenceDate = [self timeIntervalSinceReferenceDate] + timezoneOffset;
    return selfSecsFromReferenceDate > yesterdayStartSecsFromReferenceDate
    && selfSecsFromReferenceDate < todayStartSecsFromReferenceDate;
}

- (NSDate *)dateAtStartOfDayInGMT
{
    unsigned long secsFromReferenceDate = [self timeIntervalSinceReferenceDate];
    unsigned long todayStartSecsFromReferenceDate = secsFromReferenceDate / DAY_SECS * DAY_SECS;
    
    return [NSDate dateWithTimeIntervalSinceReferenceDate:todayStartSecsFromReferenceDate];
}

- (NSDate *)dateAtStartOfDayInSystemTimezone
{
    int timezoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    unsigned long secsFromReferenceDate = [self timeIntervalSinceReferenceDate] + timezoneOffset;
    unsigned long todayStartSecsFromReferenceDate = secsFromReferenceDate / DAY_SECS * DAY_SECS;
    
    return [NSDate dateWithTimeIntervalSinceReferenceDate:todayStartSecsFromReferenceDate];
}

@end
