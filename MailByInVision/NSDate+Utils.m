//
//  NSDate+Utils.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "NSDate+Utils.h"

#define D_DAY 86400
#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)

static NSDateFormatter *formatter;
static NSCalendar *calendar;

@implementation NSDate (Utils)

- (NSString *)stringFromDateWithFormat:(NSString *)formatString {
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    formatter.dateFormat = formatString;
    return [formatter stringFromDate:self];
}

- (NSString *)stringFromDateWithLongFormat {
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    
    formatter.dateStyle = NSDateFormatterLongStyle;
    return [formatter stringFromDate:self];
}

- (NSString *)wordsExpression {
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    
    if ([self isToday]) {
        return [NSString stringWithFormat:@"%@", [self stringFromDateWithFormat:@"HH:mm"]];
    } else if ([self isYesterday]) {
        return @"Yesterday";
    }
    else {
        return [self stringFromDateWithFormat:@"EEEE"];
    }
}

#pragma mark - Private

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
    if (!calendar) {
        calendar = [NSCalendar currentCalendar];
    }
    
    NSDateComponents *components1 = [calendar components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [calendar components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day));
}

- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isYesterday {
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL)isDayBeforeTwoDays {
    return [self isEqualToDateIgnoringTime:[NSDate dateWithDaysBeforeNow:2]];
}

- (BOOL)isDayBeforeThreeDays {
    return [self isEqualToDateIgnoringTime:[NSDate dateWithDaysBeforeNow:3]];
}

- (NSDate *) dateByAddingDays:(NSInteger)dDays {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingDays:(NSInteger)dDays {
    return [self dateByAddingDays: (dDays * -1)];
}


+ (NSDate *) dateWithDaysBeforeNow:(NSInteger)days {
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateYesterday {
    return [NSDate dateWithDaysBeforeNow:1];
}

@end
