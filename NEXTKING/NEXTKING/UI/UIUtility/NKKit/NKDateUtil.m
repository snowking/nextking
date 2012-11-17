//
//  NKDateUtil.m
//  ZUO
//
//  Created by King on 9/7/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKDateUtil.h"

@implementation NKDateUtil

// 10秒以内： 刚刚
// 10秒－1分钟：xx秒前
// 1分钟－1小时：xx分钟前
// 1小时－24小时：xx小时前
// 24小时后,3天内 显示 xx天前
// 3天后, 当年内 显示日期, x月x日
// 非本年发送，显示日期 xxxx年x月x日

//update 2012.6.11
//1. 如果跨自然年，则显示: “年-月-日 时:分”
//2. 如果相差大于两天（48小时），则显示: “月-日 时:分”
//3. 如果跨自然天，则显示: “昨天 时:分”
//4. 如果大于一小时，则显示: “今天 时:分”
//5. 如果大于一分钟，则显示: “X分钟前”
//6. 若以上均不满足，也就是小于一分钟，则显示“刚刚”
+ (NSString *)intervalSinceNowWithDate:(NSDate *)date
{
    NSTimeInterval dateTime = [date timeIntervalSince1970] * 1;
    long long milliseconds = (long long)dateTime*1000;
    return [self dateToString:milliseconds truncateTime:YES];
}

+ (NSString *)newIntervalSinceNowWithLongLong:(long long)milliseconds
{
//    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval nowTime = [nowDate timeIntervalSince1970] * 1;
//    NSTimeInterval publishTime = milliseconds/1000.0;
//    NSTimeInterval spacingTime = nowTime - publishTime;
//    
//    NSString *timeString = @"";
//    
//    if (spacingTime < 60) {
//        timeString = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if (spacingTime >= 60 && spacingTime < 3600) {
//        timeString = [NSString stringWithFormat:@"%f", spacingTime/60];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
//    }
//    else {
//        NSDate *publishDate = [NSDate dateWithTimeInterval:-spacingTime sinceDate:nowDate];
//        NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
//        [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
//        NSString *publishDateString = [formatter stringFromDate:publishDate];
//        NSString *publishYearString = [publishDateString substringToIndex:4];
//        NSString *nowYearString = [[formatter stringFromDate:nowDate] substringToIndex:4];
//        NSString *nowDayString = [[formatter stringFromDate:nowDate] substringWithRange:NSMakeRange(8,2)];
//        NSString *publishDayString = [publishDateString substringWithRange:NSMakeRange(8,2)];
//        if ([publishDayString isEqualToString:nowDayString]) {
//            timeString = [NSString stringWithFormat:@"今天 %@", [publishDateString substringFromIndex:11]];
//        }
//        if ([nowYearString isEqualToString:publishYearString]) {
//            timeString = [publishDateString substringFromIndex:11];
//        }
//        //timeString = [NSString stringWithFormat:@"%@", publishDateString];
//    }
//    
//    return timeString;
    return nil;
	
}

+ (NSString *)intervalSinceNowWithLongLong:(long long)milliseconds
{
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowTime = [nowDate timeIntervalSince1970] * 1;
    NSTimeInterval publishTime = milliseconds/1000.0;
    NSTimeInterval spacingTime = nowTime - publishTime;
    
    NSString *timeString = @"";
    
    if (spacingTime < 10) {
        timeString = [NSString stringWithFormat:@"刚刚"];
    }
    else if (spacingTime >= 10 && spacingTime < 60) {
        timeString = [NSString stringWithFormat:@"%f", spacingTime];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@秒前", timeString];
    }
    else if (spacingTime >= 60 && spacingTime < 3600) {
        timeString = [NSString stringWithFormat:@"%f", spacingTime/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
    }
    else if (spacingTime >= 3600 && spacingTime < 86400) {
        timeString = [NSString stringWithFormat:@"%f", spacingTime/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    else if (spacingTime >= 86400 && spacingTime < 86400*3)
    {
        timeString = [NSString stringWithFormat:@"%f", spacingTime/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@天前", timeString];
    }
    else
    {
        NSDate *publishDate = [[NSDate alloc] initWithTimeInterval:-spacingTime sinceDate:nowDate];
        NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *publishDateString = [formatter stringFromDate:publishDate];
        NSString *publishYearString = [publishDateString substringToIndex:4];
        NSString *nowYearString = [[formatter stringFromDate:nowDate] substringToIndex:4];
        if ([nowYearString isEqualToString:publishYearString]) {
            publishDateString = [publishDateString substringFromIndex:5];
        }
        timeString = [NSString stringWithFormat:@"%@", publishDateString];
        [publishDate release];
    }
    
    return timeString;
	
}

+ (NSString *)showBirth:(NSString *)formerStr
{
    if (!formerStr || [formerStr isEqualToString:@""]) {
        return @"";
    }
    NSRange range = [formerStr rangeOfString:@"-"];
    NSString *subStr = [formerStr substringFromIndex:range.location+1];
    NSString *adjustStr = [subStr stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    NSString *showBirthStr = [[[NSString stringWithFormat:@"%@日", adjustStr] retain] autorelease];
    
    return showBirthStr;
}

+(NSString *)dateToString:(long long)milliseconds truncateTime:(BOOL)bTruncateTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:milliseconds/1000.0];
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setLocale:locale];
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger nFlags=NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | kCFCalendarUnitSecond;
    NSDateComponents *dateComponents=[calendar components:nFlags fromDate:date];
    NSInteger nYear=[dateComponents year];
    NSInteger nDay=[dateComponents day];
    NSDate *currentDate=[NSDate date];
    NSDateComponents *currentDateComponents=[calendar components:nFlags fromDate:currentDate];
    NSInteger nCurrentYear=[currentDateComponents year];
    NSInteger nCurrentDay=[currentDateComponents day];
    NSString *szFormat=nil;
    NSString *szFormatDateTime=nil;
    NSInteger interval=[currentDate timeIntervalSinceDate:date];
    
    NSInteger nCurrentHour=[currentDateComponents hour];
    NSInteger nHour=[dateComponents hour];
    NSInteger nCurrentMin=[currentDateComponents minute];
    NSInteger nMin=[dateComponents minute];
    NSInteger nCurrentSecond=[currentDateComponents second];
    NSInteger nSecond=[dateComponents second];
    
    if(interval<60){
        szFormatDateTime=[NSString stringWithFormat:@"刚刚"];
    }else if(interval<3600){
        szFormatDateTime= [NSString stringWithFormat:@"%d分钟前",interval/60];
    }else if(interval<86400) {
        if(nDay==nCurrentDay){
            szFormat=@"今天 H:mm";
        }else {
            szFormat=@"昨天 H:mm";
        }
    }else if(interval<86400 *2 && (nHour<nCurrentHour || (nHour==nCurrentHour && nMin<nCurrentMin) || (nHour==nCurrentHour && nMin==nCurrentMin && nSecond<nCurrentSecond))){
        szFormat=@"昨天 H:mm";
    }else{
        if(nYear==nCurrentYear){
            szFormat=@"M月d日 H:mm";
        }else{
            if (bTruncateTime) {
                szFormat=@"yyyy-MM-dd";
            } else {
                szFormat=@"yyyy-MM-dd H:mm";
            }
            
        }
    }
    
    if(nil==szFormatDateTime){
        [dateFormatter setDateFormat:szFormat];
        szFormatDateTime=[dateFormatter stringFromDate:date];
    }
    [locale release];
    [dateFormatter release];
    [calendar release];
    return szFormatDateTime;
}

+ (NSString *)eventYearMonthWithLongLong:(long long)milliseconds
{
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowTime = [nowDate timeIntervalSince1970] * 1;
    NSTimeInterval publishTime = milliseconds/1000.0;
    NSTimeInterval spacingTime = nowTime - publishTime;
    
    NSString *timeString = @"";
    NSDate *publishDate = [[NSDate alloc] initWithTimeInterval:-spacingTime sinceDate:nowDate];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *publishDateString = [formatter stringFromDate:publishDate];
    timeString = [publishDateString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    [publishDate release];
    
    return [[timeString retain] autorelease];
}

+ (NSString *)eventYearMonthWithDate:(NSDate *)date
{
    NSTimeInterval dateTime = [date timeIntervalSince1970] * 1;
    long long milliseconds = (long long)dateTime*1000;
    return [self eventYearMonthWithLongLong:milliseconds];
}

+ (NSString *)eventCreateWithDate:(NSDate *)date
{
    NSTimeInterval dateTime = [date timeIntervalSince1970] * 1;
    long long milliseconds = (long long)dateTime*1000;
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:milliseconds/1000.0];
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setLocale:locale];
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger nFlags=NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponents=[calendar components:nFlags fromDate:createDate];
    NSInteger nYear=[dateComponents year];
    NSDate *currentDate=[NSDate date];
    NSDateComponents *currentDateComponents=[calendar components:nFlags fromDate:currentDate];
    NSInteger nCurrentYear=[currentDateComponents year];
    NSString *szFormat=nil;
    NSString *szFormatDateTime=nil;
    
    if(nYear==nCurrentYear){
        szFormat=@"M月d日";
    }
    else{
        szFormat=@"y年M月";
    }
    if(nil==szFormatDateTime){
        [dateFormatter setDateFormat:szFormat];
        szFormatDateTime=[dateFormatter stringFromDate:date];
    }
    [locale release];
    [dateFormatter release];
    [calendar release];
    
    return szFormatDateTime;
}

+ (NSString *)eventDayWithLongLong:(long long)milliseconds
{
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowTime = [nowDate timeIntervalSince1970] * 1;
    NSTimeInterval publishTime = milliseconds/1000.0;
    NSTimeInterval spacingTime = nowTime - publishTime;
    
    NSDate *publishDate = [[NSDate alloc] initWithTimeInterval:-spacingTime sinceDate:nowDate];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *publishDateString = [formatter stringFromDate:publishDate];
    NSString *timeString = [publishDateString substringFromIndex:8];
    [publishDate release];
    
    return [[timeString retain] autorelease];
}

+ (NSString *)eventDayWithDate:(NSDate *)date
{
    NSTimeInterval dateTime = [date timeIntervalSince1970] * 1;
    long long milliseconds = (long long)dateTime*1000;
    return [self eventDayWithLongLong:milliseconds];
}

+ (BOOL)isCurrentDay:(long long)milliseconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:milliseconds/1000.0];
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setLocale:locale];
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger nFlags=NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponents=[calendar components:nFlags fromDate:date];
    NSInteger nDay=[dateComponents day];
    NSDate *currentDate=[NSDate date];
    NSDateComponents *currentDateComponents=[calendar components:nFlags fromDate:currentDate];
    NSInteger nCurrentDay=[currentDateComponents day];
    NSInteger interval=[currentDate timeIntervalSinceDate:date];
    [locale release];
    [dateFormatter release];
    [calendar release];
    if (interval<86400 && nDay==nCurrentDay) {
        return TRUE;
    }
    return FALSE;
}

+ (BOOL)isCurrentDayWithDate:(NSDate *)date
{
    NSTimeInterval dateTime = [date timeIntervalSince1970] * 1;
    long long milliseconds = (long long)dateTime*1000;
    return [self isCurrentDay:milliseconds];
}


+ (NSDate *)NSStringDateToNSDate:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:string];
    [formatter release];
    return date;
}



@end
