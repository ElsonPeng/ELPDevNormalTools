//
//  ELPUniversalMethods.m
//  ELPDevNormalTools
//
//  Created by ElsonPeng on 2018/5/11.
//  Copyright © 2018年 ElsonPeng. All rights reserved.
//

#import "ELPUniversalMethods.h"
#include <sys/sysctl.h>
#import <sys/mount.h>

@implementation ELPUniversalMethods

/*
 6. 获取手机的设备信息,是iPhone哪一款
 */
+ (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [ELPUniversalMethods machineModel];
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch",
                              @"Watch1,2" : @"Apple Watch",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              @"iPhone10,1" : @"iPhone 8",
                              @"iPhone10,2" : @"iPhone 8 Plus",
                              @"iPhone10,3" : @"iPhone X",
                              @"iPhone10,4" : @"iPhone 8",
                              @"iPhone10,5" : @"iPhone 8 Plus",
                              @"iPhone10,6" : @"iPhone X",
                              @"iPhone11,8" : @"iPhone XR",
                              @"iPhone11,2" : @"iPhone XS",
                              @"iPhone11,6" : @"iPhone XS Max",
                              @"iPhone11,4" : @"iPhone XS Max",
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

+ (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

@end

@implementation NSString (ValidStringWithOutSqlInjection)

-(BOOL)isValidStringWithOutSqlInjection {
    BOOL state = YES;
    NSString *inj_str = @"'|and|exec|create|insert|select|delete|update|count|*|%|char|declare|xp_|+|:|：|?|？|&|!|$|#";
    NSArray *lab = [inj_str componentsSeparatedByString:@"|"];
    for(NSString *tempStr in lab)
    {
        if([self containsString:tempStr]){
            return NO;
        }
    }
    return state;
}

//判断字符串中是否包含中文字符
-(BOOL)containChinese{
    
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

/* 判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于8位
 2. 密码中必须同时包含数字和字母
 */
-(BOOL)isValidPasswordString
{
    BOOL result = NO;
    if ([self length] >= 8 && [self length] <= 16){
        
        //数字条件
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        
        //符合数字条件的有几个
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                                                           options:NSMatchingReportProgress
                                                                             range:NSMakeRange(0, self.length)];
        
        //英文字条件
        NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
        
        //符合英文字条件的有几个
        NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:self
                                                                                 options:NSMatchingReportProgress
                                                                                   range:NSMakeRange(0, self.length)];
        
        //        NSLog(@"isValidPasswordString 数字 有%lu个 , 字母有%lu个",(unsigned long)tNumMatchCount,(unsigned long)tLetterMatchCount);
        if(tNumMatchCount >= 1 && tLetterMatchCount >= 1){
            result = YES;
        }
    }
    return result;
}

-(BOOL)MatchLetter:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}

/*
 4.判断中国大陆的手机号是否合法
 */
-(BOOL)validateChinesePhone {
    if (!self || [self isEqualToString:@""]) {
        return NO;
    }
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] initWithPattern:@"^1[3|4|5|6|7|8|9][0-9][0-9]{8}$" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    if(numberofMatch > 0) {
        return YES;
    }
    return NO;
}

/*
 5.得到中英文混合字符串长度
 */
+(NSInteger)getStringAbsoluteLength:(NSString *)stringTemp{
    NSStringEncoding enc =
    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSData* da = [stringTemp dataUsingEncoding:enc];
    return [da length];
}

@end

@implementation NSString (GetZoneTimeNSString)

static NSDateFormatter  *yyyyMMddhhmmssDateformatter;

+(NSDate *)convertYYMMDDhhmmssToDate:(NSString *)YYMMDDhhmmss
{
    if(!yyyyMMddhhmmssDateformatter){
        yyyyMMddhhmmssDateformatter = [[NSDateFormatter alloc]init];
        [yyyyMMddhhmmssDateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *convertDate = [yyyyMMddhhmmssDateformatter dateFromString:YYMMDDhhmmss];
    return convertDate;
}

+ (NSString *)getZoneConvertHHMMssStandardTime:(NSString *)inputYY_MM_DD_time{
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSInteger timeZoneValueOffset = [zone secondsFromGMT] / 3600;

    NSRange rang = NSMakeRange(inputYY_MM_DD_time.length - 8, 8);
    NSString *hhMMTimeString = [inputYY_MM_DD_time substringWithRange:rang];
    
    NSInteger hourValue = [[hhMMTimeString substringToIndex:2] integerValue];
    NSString *mmssString = [hhMMTimeString substringWithRange:NSMakeRange(3, 5)];
    NSInteger deltaHourInteger = timeZoneValueOffset - 8;
    
    NSInteger hourIntValue = hourValue + deltaHourInteger;
    
    if(hourIntValue > 24){
        hourIntValue = hourIntValue - 24;
    }
    else if(hourIntValue < 0){
        hourIntValue = hourIntValue + 24;
    }
    
    NSString *showTimeString = [NSString stringWithFormat:@"%02ld:%@",hourIntValue,mmssString];
    return showTimeString;
}

+ (NSString *)getZoneConvertHHMMStandardTime:(NSString *)inputYY_MM_DD_time
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSInteger timeZoneValueOffset = [zone secondsFromGMT] / 3600;

    NSRange rang = NSMakeRange(inputYY_MM_DD_time.length - 8, 5);
    NSString *hhMMTimeString = [inputYY_MM_DD_time substringWithRange:rang];
    
    NSInteger hourValue = [[hhMMTimeString substringToIndex:2] integerValue];
    NSString *minValueString = [hhMMTimeString substringWithRange:NSMakeRange(3, 2)];
    NSInteger deltaHourInteger = timeZoneValueOffset;
    
    NSInteger hourIntValue = hourValue + deltaHourInteger;
    
    if(hourIntValue > 24){
        hourIntValue = hourIntValue - 24;
    }
    else if(hourIntValue < 0){
        hourIntValue = hourIntValue + 24;
    }
    
    NSString *showTimeString = [NSString stringWithFormat:@"%02ld:%@",hourIntValue,minValueString];
    return showTimeString;
}

+ (NSString *)getZoneConvertYYMMDDTimeStandardTime:(NSString *)inputYY_MM_DD_time{
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSInteger timeZoneValueOffset = [zone secondsFromGMT] / 3600;

    NSDate *initialDate = [NSString convertYYMMDDhhmmssToDate:inputYY_MM_DD_time];
    
    NSTimeInterval timeInterval = (timeZoneValueOffset - 8) * 60 * 60;
    NSDate *ConvertTimeDate = [initialDate dateByAddingTimeInterval:timeInterval];
    NSString *convertZoneTimeString = [yyyyMMddhhmmssDateformatter stringFromDate:ConvertTimeDate];
    return convertZoneTimeString;
}

+ (NSString *)gettZoneConverHHMMNumberOnlyTime:(NSString *)inputYYMMDDtime
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSInteger timeZoneValueOffset = [zone secondsFromGMT] / 3600;

    NSRange rang = NSMakeRange(8, 4);
    NSString *hhMMTimeString = [inputYYMMDDtime substringWithRange:rang];
    NSInteger hourValue = [[hhMMTimeString substringToIndex:2] integerValue];
    NSString *minValueString = [hhMMTimeString substringWithRange:NSMakeRange(2, 2)];
    NSInteger deltaHourIntValue = timeZoneValueOffset - 8;
    
    NSInteger hourIntValue = hourValue + deltaHourIntValue;
    
    if(hourIntValue > 24){
        hourIntValue = hourIntValue- 24;
    }
    else if(hourIntValue < 0){
        hourIntValue = hourIntValue + 24;
    }
    NSString *showTimeString = [NSString stringWithFormat:@"%02ld:%@",hourIntValue,minValueString];
    return showTimeString;
}

@end

