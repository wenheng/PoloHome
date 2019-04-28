//
//  NSDate+HX.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "NSDate+HX.h"

//因NSDateFormatter内存开销较大，所以使用静态变量的形式
static NSDateFormatter *cachedDateFormatter = nil;

static const unsigned componentFlags = (NSCalendarUnitEra| NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (HX)

#pragma mark - 私有方法
/**
 根据不同的类别创建NSDateFormatter
 
 @param type 传入的类别
 @return 返回的NSDateFormatter
 */
+ (NSDateFormatter *)createDateFormatterForType:(HXDateType)type
{
  if (!cachedDateFormatter) {
    cachedDateFormatter = [[NSDateFormatter alloc]init];
  }
  // 设置中国地区
  cachedDateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
  // 设置默认系统时区
  cachedDateFormatter.timeZone = [NSTimeZone systemTimeZone];
  
  switch (type) {
    case HXDateTypeYearMonth:
      cachedDateFormatter.dateFormat = @"yyyyMM";
      break;
    case HXDateTypeYearMonthDay:
      cachedDateFormatter.dateFormat = @"yyyyMMdd";
      break;
    case HXDateTypeBarStyle:
      cachedDateFormatter.dateFormat = @"yyyy-MM-dd";
      break;
    case HXDateTypeBarHourStyle:
      cachedDateFormatter.dateFormat = @"yy-MM-dd HH";
      break;
    case HXDateTypeBarMinuteStyle:
      cachedDateFormatter.dateFormat = @"yy-MM-dd HH:mm";
      break;
    case HXDateTypeBarSecondStyle:
      cachedDateFormatter.dateFormat = @"yy-MM-dd HH:mm:ss";
      break;
      
    default:
      break;
  }
  return cachedDateFormatter;
}

#pragma mark -
#pragma mark - 公共方法
/**
 根据当前系统时间格式化成字符串
 
 @param dateType 格式化类型
 @return 格式化好以后的字符串
 */
+ (NSString *)getNowDateWithDateType:(HXDateType)dateType
{
  NSDate *date = [NSDate date];
  return [self getDateWithDate:date dateType:dateType];
}
/**
 根据传入的日期格式化成相应的字符串
 
 @param date 需要格式化的时间
 @param dateType 格式化类型
 @return 格式化好以后的字符串
 */
+ (NSString *)getDateWithDate:(NSDate *)date
                     dateType:(HXDateType)dateType
{
  NSDateFormatter *formatter = [self createDateFormatterForType:dateType];
  return date ? [formatter stringFromDate:date] : @"";
}


/**
 根据传入的字符串生成日期
 
 @param dateString 传入的字符串
 @param dateType 格式化类型
 @return 根据格式生成的日期
 */
+ (NSDate *)getDateWithString:(NSString *)dateString
                     dateType:(HXDateType)dateType
{
  NSDateFormatter *formatter = [self createDateFormatterForType:dateType];
  return [formatter dateFromString:dateString];
}


/**
 时间字符串格式相互转换
 
 @param dateString 需要转换的时间字符串
 @param fromType 初始格式化
 @param toType 结果格式化
 @return 格式化好以后的字符串日期
 */
+ (NSString *)transformDateString:(NSString *)dateString
                     fromDateType:(HXDateType)fromType
                       toDateType:(HXDateType)toType
{
  if (toType != fromType) {
    NSDate *date = [self getDateWithString:dateString dateType:fromType];
    return [self getDateWithDate:date dateType:toType];
  }
  else {
    return dateString;
  }
}


/**
 日期有效性判断
 
 @param dateString 传入的日期
 @param dateType 日期格式化
 @return 是否是有效的日期
 */
+ (BOOL)checkDateIsValidWithDateString:(NSString *)dateString
                              dateType:(HXDateType)dateType
{
  NSString *newString = [self transformDateString:dateString fromDateType:dateType toDateType:HXDateTypeYearMonthDay];
  BOOL valid = NO;
  if (newString.length > 0) {
    if ([newString hasPrefix:@"19"] || [newString hasPrefix:@"20"]) {
      NSDateFormatter *dateFormatter = [self createDateFormatterForType:HXDateTypeYearMonthDay];
      dateFormatter.locale   = [NSLocale systemLocale];
      dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
      NSDate *date           = [dateFormatter dateFromString:newString];
      if (date) {
        valid = YES;
      }
    }
  }
  return valid;
}


/**
 传入的日期字符串跟当前日期进行比较
 
 @param dateString 传入的日期
 @param dateType 格式化
 @return 比较结果
 */
+ (NSComparisonResult)compareDate:(NSString *)dateString
                         dateType:(HXDateType)dateType
{
  NSString *newString = [self transformDateString:dateString fromDateType:dateType toDateType:HXDateTypeYearMonthDay];
  NSDateFormatter *dateFormatter = [self createDateFormatterForType:HXDateTypeYearMonthDay];
  dateFormatter.locale   = [NSLocale systemLocale];
  dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
  NSDate *startDate = [dateFormatter dateFromString:newString];
  NSDate *nowDate   = [NSDate date];
  return [startDate compare:nowDate];
}


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
                               toType:(HXDateType)toType
{
  NSString *beginStr = [self transformDateString:fromDateString fromDateType:fromType toDateType:HXDateTypeYearMonthDay];
  NSString *endStr   = [self transformDateString:toDateString fromDateType:toType toDateType:HXDateTypeYearMonthDay];
  NSDateFormatter *dateFormatter = [self createDateFormatterForType:HXDateTypeYearMonthDay];
  dateFormatter.locale = [NSLocale systemLocale];
  dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
  NSDate *startDate = [dateFormatter dateFromString:beginStr];
  NSDate *endDate   = [dateFormatter dateFromString:endStr];
  return [startDate compare:endDate];
  
}

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
                                toType:(HXDateType)toType
{
  NSString *beginStr = [self transformDateString:fromDateString fromDateType:fromType toDateType:HXDateTypeBarStyle];
  NSString *endStr   = [self transformDateString:toDateString fromDateType:toType toDateType:HXDateTypeBarStyle];
  
  NSInteger intervals = 0;
  if (beginStr.length > 0 && endStr.length > 0) {
    NSDateFormatter *dateFormatter = [self createDateFormatterForType:HXDateTypeBarStyle];
    dateFormatter.locale = [NSLocale systemLocale];
    NSDate *beginDate = [dateFormatter dateFromString:beginStr];
    NSDate *endDate   = [dateFormatter dateFromString:endStr];
    
    //用于记录两个日期的时间间隔
    NSInteger seconds = [endDate timeIntervalSince1970] - [beginDate timeIntervalSince1970];
    
    if (seconds > 0) {//当前日期大于规定的审核日期
      intervals = seconds / (60 * 60 * 24);
    }
    else {//当前日期小于规定的审核日期
      intervals = 0;
    }
  }
  else {
    intervals = 0;
  }
  return intervals;
  
}


/**
 根据字符串 时区获取指定日期
 
 @param dateString 时间字符串
 @param dateType 格式化
 @param timeZone 时区
 @return 指定日期
 */
+ (NSDate *)getDateWithString:(NSString *)dateString
                     dateType:(HXDateType)dateType
                     timeZone:(NSString *)timeZone
{
  NSDateFormatter *dateFormatter = [self createDateFormatterWithType:dateType timeZone:timeZone];
  NSDate *newDate = [dateFormatter dateFromString:dateString];
  return newDate;
}


/**
 根据时区 格式生成日期格式化工具
 
 @param dateType 格式化
 @param timeZone 时区
 @return 格式化工具类
 */
+ (NSDateFormatter *)createDateFormatterWithType:(HXDateType)dateType
                                        timeZone:(NSString *)timeZone
{
  if (!cachedDateFormatter) {
    cachedDateFormatter = [[NSDateFormatter alloc]init];
  }
  //时区格式 GMT+8
  //获取+/-号位置
  NSString *GMTStr = @"";
  if ([timeZone containsString:@"-"]) {//有负号
    GMTStr = [NSString stringWithFormat:@"GMT-"];
  }else{
    GMTStr = [NSString stringWithFormat:@"GMT+"];
  }
  NSRange locationGMT = [timeZone rangeOfString:GMTStr];
  NSString *lastTimeZoneStr = [timeZone substringFromIndex:locationGMT.location + locationGMT.length];
  if (lastTimeZoneStr.length == 1) {
    lastTimeZoneStr = [NSString stringWithFormat:@"%@0%@00",GMTStr,lastTimeZoneStr];
  }else{
    lastTimeZoneStr = [NSString stringWithFormat:@"%@%@00",GMTStr,lastTimeZoneStr];
  }
  //获取当地
  NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:lastTimeZoneStr];
  // 设置默认系统时区
  cachedDateFormatter.timeZone = zone;
  
  switch (dateType) {
    case HXDateTypeYearMonth:
      cachedDateFormatter.dateFormat = @"yyyyMM";
      break;
    case HXDateTypeYearMonthDay:
      cachedDateFormatter.dateFormat = @"yyyyMMdd";
      break;
    case HXDateTypeBarStyle:
      cachedDateFormatter.dateFormat = @"yyyy-MM-dd";
      break;
    case HXDateTypeBarHourStyle:
      cachedDateFormatter.dateFormat = @"yy-MM-dd HH";
      break;
    case HXDateTypeBarMinuteStyle:
      cachedDateFormatter.dateFormat = @"yy-MM-dd HH:mm";
      break;
    case HXDateTypeBarSecondStyle:
      cachedDateFormatter.dateFormat = @"yy-MM-dd HH:mm:ss";
      break;
      
    default:
      break;
  }
  return cachedDateFormatter;
}

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
                                      toTimeZone:(NSString *)toTimeZone
{
  //时区格式 GMT+8
  //获取+/-号位置
  
  //处理起始时间
  NSString *beginGMTStr = @"";
  if ([fromTimeZone containsString:@"-"]) {//有负号
    beginGMTStr = [NSString stringWithFormat:@"GMT-"];
  }
  else {
    beginGMTStr = [NSString stringWithFormat:@"GMT+"];
  }
  
  NSRange beginLocationGMT = [fromTimeZone rangeOfString:beginGMTStr];
  NSString *beginTimeZoneStr = [fromTimeZone substringFromIndex:beginLocationGMT.location + beginLocationGMT.length];
  if (beginTimeZoneStr.length == 1) {
    beginTimeZoneStr = [NSString stringWithFormat:@"%@0%@00",beginGMTStr,beginTimeZoneStr];
  }else{
    beginTimeZoneStr = [NSString stringWithFormat:@"%@%@00",beginGMTStr,beginTimeZoneStr];
  }
  
  //处理结束时间
  NSString *endGMTStr = @"";
  if ([toTimeZone containsString:@"-"]) {//有负号
    endGMTStr = [NSString stringWithFormat:@"GMT-"];
  }else{
    endGMTStr = [NSString stringWithFormat:@"GMT+"];
  }
  NSRange endLocationGMT = [toTimeZone rangeOfString:endGMTStr];
  NSString *endTimeZoneStr = [toTimeZone substringFromIndex:endLocationGMT.location + endLocationGMT.length];
  if (endTimeZoneStr.length == 1) {
    endTimeZoneStr = [NSString stringWithFormat:@"%@0%@00",endGMTStr,endTimeZoneStr];
  }else{
    endTimeZoneStr = [NSString stringWithFormat:@"%@%@00",endGMTStr,endTimeZoneStr];
  }
  
  
  //生成起始时间
  //获取当地
  NSTimeZone *beginZone = [NSTimeZone timeZoneWithAbbreviation:beginTimeZoneStr];
  //日期距离0时区的秒数
  NSTimeInterval beginInterval = [beginZone secondsFromGMTForDate:fromDate];
  NSDate *lastBeginDate = [fromDate dateByAddingTimeInterval:beginInterval];
  
  //生成结束时间
  //获取当地
  NSTimeZone *endZone = [NSTimeZone timeZoneWithAbbreviation:endTimeZoneStr];
  //日期距离0时区的秒数
  NSTimeInterval endInterval = [endZone secondsFromGMTForDate:toDate];
  NSDate *lastEndDate = [toDate dateByAddingTimeInterval:endInterval];
  
  NSInteger intervalInSecond = [lastEndDate timeIntervalSince1970] - [lastBeginDate timeIntervalSince1970];
  return intervalInSecond;
}

#pragma mark -
#pragma mark - Date 分类
+ (NSCalendar *)currentCalendar
{
  static NSCalendar *calendar = nil;
  if (!calendar) {
    calendar = [NSCalendar autoupdatingCurrentCalendar];
  }
  return calendar;
}

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days
{
  return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days
{
  return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateTomorrow
{
  return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterDay
{
  return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours
{
  NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kDateHour * hours;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
  
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours
{
  NSTimeInterval aTimeTerval = [[NSDate date] timeIntervalSinceReferenceDate] - kDateHour * hours;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeTerval];
  return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes
{
  NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kDateMinute * minutes;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes
{
  NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kDateMinute * minutes;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}

- (NSString *)stringWithFormat:(NSString *)format
{
  NSDateFormatter *formatter = [NSDateFormatter new];
  //    formatter.locale = [NSLocale currentLocale]; // Necessary?
  formatter.dateFormat = format;
  return [formatter stringFromDate:self];
  
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.dateStyle = dateStyle;
  formatter.timeStyle = timeStyle;
  //    formatter.locale = [NSLocale currentLocale]; // Necessary?
  return [formatter stringFromDate:self];
}

- (NSString *)shortString
{
  return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}
- (NSString *)shortTimeString
{
  return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}
- (NSString *)shortDateString
{
  return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}
- (NSString *)mediumString
{
  return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)mediumTimeString
{
  return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
}
- (NSString *)mediumDateString
{
  return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}
- (NSString *)longString
{
  return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
}
- (NSString *)longTimeString
{
  return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle];
}
- (NSString *)longDateString
{
  return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate
{
  NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
  return ((components1.year == components2.year) &&
          (components1.month == components2.month) &&
          (components1.day == components2.day));
}

- (BOOL)isToday
{
  return [self isEqualToDateIgnoringTime:[NSDate date]];
}
- (BOOL)isTomorrow
{
  return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}
- (BOOL)isYesterDay
{
  return [self isEqualToDateIgnoringTime:[NSDate dateYesterDay]];
}

- (BOOL)isSameWeekAsDate:(NSDate *)aDate
{
  NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
  
  if (components1.weekOfMonth != components2.weekOfMonth) {
    return NO;
  }
  return (abs([self timeIntervalSinceDate:aDate])) < kDateWeek;
}

- (BOOL)isThisWeek
{
  return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek
{
  NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kDateWeek;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return [self isSameWeekAsDate:newDate];
}
- (BOOL)isLastWeek
{
  NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kDateWeek;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return [self isSameWeekAsDate:newDate];
}

- (BOOL)isSameMonthAsDate:(NSDate *)aDate
{
  NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
  return ((components1.month == components2.month) &&
          (components1.year == components2.year));
}
- (BOOL)isThisMonth
{
  return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isLastMonth
{
  return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL)isNextMonth
{
  return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL)isSameYearsAsDate:(NSDate *)aDate
{
  NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
  return (components1.year == components2.year);
}

- (BOOL)isThisYear
{
  return [self isSameYearsAsDate:[NSDate date]];
}

- (BOOL)isNextYear
{
  NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:[NSDate date]];
  return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear
{
  NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:[NSDate date]];
  return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate
{
  return ([self compare:aDate] == NSOrderedAscending);
}
- (BOOL)isLaterThanDate:(NSDate *)aDate
{
  return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isInFuture
{
  return ([self isLaterThanDate:[NSDate date]]);
}
- (BOOL)isInPast
{
  return ([self isEarlierThanDate:[NSDate date]]);
}

- (BOOL)isTypicallyWeekend
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  if ((components.weekday == 1 || (components.weekday == 7))) {
    return YES;
  }
  return NO;
}

- (BOOL)isTypicallyWorkDay
{
  return ![self isTypicallyWeekend];
}

- (NSDate *)dateByAddingYears:(NSInteger)dYears
{
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.year = dYears;
  NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
  return newDate;
}

- (NSDate *)dateBySubtractingYears:(NSInteger)dYears
{
  return [self dateByAddingYears:-dYears];
}

- (NSDate *)dateByAddingMonths:(NSInteger)dMonths
{
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.month = dMonths;
  NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
  return newDate;
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths
{
  return [self dateByAddingMonths:-dMonths];
}

- (NSDate *)dateByAddingDays:(NSInteger)dDays
{
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = dDays;
  NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
  return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSInteger)dDays
{
  return [self dateByAddingDays:-dDays];
}

- (NSDate *)dateByAddingHours:(NSInteger)dHours
{
  NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + kDateHour * dHours;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)dHours
{
  return [self dateByAddingHours:-dHours];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes
{
  NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + kDateMinute * dMinutes;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes
{
  return [self dateByAddingMinutes:-dMinutes];
}


- (NSDate *)dateAtStartOfDay
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  components.hour   = 0;
  components.minute = 0;
  components.second = 0;
  return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  components.hour   = 23;
  components.minute = 59;
  components.second = 59;
  return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSInteger)minutesAfterDate:(NSDate *)aDate
{
  NSTimeInterval timeInterval = [self timeIntervalSinceDate:aDate];
  return (NSInteger)(timeInterval / kDateMinute);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate
{
  NSTimeInterval timeInterval = [aDate timeIntervalSinceDate:self];
  return (NSInteger)(timeInterval / kDateMinute);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate
{
  NSTimeInterval timeInterval = [self timeIntervalSinceDate:aDate];
  return (NSInteger)(timeInterval / kDateHour);
}
- (NSInteger)hoursBeforeDate:(NSDate *)aDate
{
  NSTimeInterval timeInterval = [aDate timeIntervalSinceDate:self];
  return (NSInteger)(timeInterval / kDateHour);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate
{
  NSTimeInterval timeInterval = [self timeIntervalSinceDate:aDate];
  return (NSInteger)(timeInterval / kDateDay);
}
- (NSInteger)daysBeforeDate:(NSDate *)aDate
{
  NSTimeInterval timeInterval = [aDate timeIntervalSinceDate:self];
  return (NSInteger)(timeInterval / kDateDay);
}

- (NSInteger)distanceInDaysToDate:(NSDate *)anOhterDate
{
  NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *components = [gregorianCalendar components:componentFlags fromDate:self toDate:anOhterDate options:0];
  return components.day;
}

- (NSInteger)nearestHour
{
  NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kDateMinute * 30;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:newDate];
  return components.hour;
}

- (NSInteger)hour
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.hour;
}

- (NSInteger)minute
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.minute;
}

- (NSInteger)seconds
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.second;
}

- (NSInteger)day
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.day;
}

- (NSInteger)month
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.month;
}

- (NSInteger)week
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.weekOfMonth;
}

- (NSInteger)weekday
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.weekday;
}

- (NSInteger)nthWeekday
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.weekdayOrdinal;
}

- (NSInteger)year
{
  NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
  return components.year;
}

@end
