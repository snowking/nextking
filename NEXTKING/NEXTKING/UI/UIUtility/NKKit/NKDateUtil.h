//
//  NKDateUtil.h
//  ZUO
//
//  Created by King on 9/7/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKDateUtil : NSObject


+ (NSString *)intervalSinceNowWithDate:(NSDate *)date;
+ (NSString *)intervalSinceNowWithLongLong:(long long)milliseconds;
+ (NSString *)showBirth:(NSString *)formerStr;
+ (NSString *)dateToString:(long long)milliseconds truncateTime:(BOOL)bTruncateTime;

+ (NSString *)eventYearMonthWithLongLong:(long long)milliseconds;
+ (NSString *)eventYearMonthWithDate:(NSDate *)date;
+ (NSString *)eventDayWithLongLong:(long long)milliseconds;
+ (NSString *)eventDayWithDate:(NSDate *)date;
+ (BOOL)isCurrentDay:(long long)milliseconds;
+ (BOOL)isCurrentDayWithDate:(NSDate *)date;
+ (NSString *)eventCreateWithDate:(NSDate *)date;
+ (NSDate *)NSStringDateToNSDate:(NSString *)string;

+ (NSString *)howOldNowWithBirthday:(NSDate *)date;




@end
