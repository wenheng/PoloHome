//
//  NSDate+HX.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HXDateType)
{
  HXDateTypeYearMonth = 0,    //201901
  HXDateTypeYearMonthDay,     //20190101
  HXDateTypeBarStyle,         //2019-01-01
  HXDateTypeBarHourStyle,     //19-01-01 01
  HXDateTypeBarMinuteStyle,   //19-01-01 01:01
  HXDateTypeBarSecondStyle,   //19-01-01 01:01:01
};

typedef NS_ENUM(NSUInteger, HXTimeIntervalType)
{
  HXTimeIntervalTypeHour = 0, //小时
  HXTimeIntervalTypeMinute,   //分钟
  HXTimeIntervalTypeSecond,   //秒
};

//单位s
#define kDateMinute 60
#define kDateHour   3600
#define kDateDay    86400
#define kDateWeek   604800
#define kDateYear   31556926

@interface NSDate (HX)

@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;

@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;

@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

@property (nonatomic, readonly) NSInteger nearestHour;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger seconds;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger week;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (nonatomic, readonly) NSInteger year;

/**
 根据当前系统时间格式化成字符串
 
 @param dateType 格式化类型
 @return 格式化好以后的字符串
 */
+ (NSString *)getNowDateWithDateType:(HXDateType)dateType;
/**
 根据传入的日期格式化成相应的字符串
 
 @param date 需要格式化的时间
 @param dateType 格式化类型
 @return 格式化好以后的字符串
 */
+ (NSString *)getDateWithDate:(NSDate *)date
                     dateType:(HXDateType)dateType;
/**
 根据传入的字符串生成日期
 
 @param dateString 传入的字符串
 @param dateType 格式化类型
 @return 根据格式生成的日期
 */
+ (NSDate *)getDateWithString:(NSString *)dateString
                     dateType:(HXDateType)dateType;
/**
 时间字符串格式相互转换
 
 @param dateString 需要转换的时间字符串
 @param fromType 初始格式化
 @param toType 结果格式化
 @return 格式化好以后的字符串日期
 */
+ (NSString *)transformDateString:(NSString *)dateString
                     fromDateType:(HXDateType)fromType
                       toDateType:(HXDateType)toType;
/**
 日期有效性判断
 
 @param dateString 传入的日期
 @param dateType 日期格式化
 @return 是否是有效的日期
 */
+ (BOOL)checkDateIsValidWithDateString:(NSString *)dateString
                              dateType:(HXDateType)dateType;
/**
 传入的日期字符串跟当前日期进行比较
 
 @param dateString 传入的日期
 @param dateType 格式化
 @return 比较结果
 */
+ (NSComparisonResult)compareDate:(NSString *)dateString
                         dateType:(HXDateType)dateType;
/**
 两个日期进行比较
 
 @param fromDateString 起始日期
 @param fromType 起始格式化
 @param toDateString 结束日期
 @param toType 结束格式化
 @return 比较结果
 */
+ (NSComparisonResult)compareFromDate:(NSString *)fromDateString
                             fromType:(HXDateType)fromType
                               toDate:(NSString *)toDateString
                               toType:(HXDateType)toType;
/**
 计算两个日期之间的天数 YYYY-MM-DD格式
 
 @param fromDateString 其实日期
 @param fromType 起始格式化
 @param toDateString 结束日期
 @param toType 结束格式化
 @return 相隔天数
 */
+ (NSInteger)calculateIntervalFromDate:(NSString *)fromDateString
                              fromType:(HXDateType)fromType
                                toDate:(NSString *)toDateString
                                toType:(HXDateType)toType;
/**
 根据字符串 时区获取指定日期
 
 @param dateString 时间字符串
 @param dateType 格式化
 @param timeZone 时区
 @return 指定日期
 */
+ (NSDate *)getDateWithString:(NSString *)dateString
                     dateType:(HXDateType)dateType
                     timeZone:(NSString *)timeZone;
/**
 根据时区 格式生成日期格式化工具
 
 @param dateType 格式化
 @param timeZone 时区
 @return 格式化工具类
 */
+ (NSDateFormatter *)createDateFormatterWithType:(HXDateType)dateType
                                        timeZone:(NSString *)timeZone;
/**
 计算两个日期之间的间隔秒数
 
 @param fromDate 起始日期
 @param fromTimeZone 起始时区
 @param toDate 终点日期
 @param toTimeZone 终点时区
 @return 间隔秒数
 */
+ (NSTimeInterval)getSecondsTimeIntervalFromDate:(NSDate *)fromDate
                                    fromTimeZone:(NSString *)fromTimeZone
                                          toDate:(NSDate *)toDate
                                      toTimeZone:(NSString *)toTimeZone;

+ (NSCalendar *)currentCalendar;

+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterDay;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;

+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes;

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)stringWithFormat:(NSString *)format;

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterDay;

- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isThisMonth;
- (BOOL)isNextMonth;
- (BOOL)isLastMonth;

- (BOOL)isSameYearsAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;

- (BOOL)isInFuture;
- (BOOL)isInPast;

- (BOOL)isTypicallyWorkDay;
- (BOOL)isTypicallyWeekend;

- (NSDate *)dateByAddingYears:(NSInteger)dYears;
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;

- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateAtEndOfDay;

- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anOhterDate;

@end

