//
//  ELPUniversalMethods.h
//  ELPDevNormalTools
//
//  Created by ElsonPeng on 2018/5/11.
//  Copyright © 2018年 ElsonPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELPUniversalMethods : NSObject


@end

@interface NSString (ValidStringWithOutSqlInjection)

/*
 1.判断字符串中是否包含中文字符
 */
-(BOOL)containChinese;

/*
 2.判断字符串是否包含容易产生sql注入的一些字符
 */
-(BOOL)isValidStringWithOutSqlInjection;

/*
 3.判断用户输入的密码是否符合规范，符合规范的密码要求：（1）长度8-16位 （2）密码中必须同时包含数字和字母（可包含其他特殊字符）
 */
-(BOOL)isValidPasswordString;

/*
 4.判断中国大陆的手机号是否合法
 */
-(BOOL)validateChinesePhone;

/*
 5.得到中英文混合字符串长度
*/
+(NSInteger)getStringAbsoluteLength:(NSString *)stringTemp;

@end

/*
 6.做时区转换的时候用到的方法（该方法主要是将东八区的时间转换成相应时区的时间）
 */
@interface NSString (GetZoneTimeNSString)

+(NSDate *)convertYYMMDDhhmmssToDate:(NSString *)YYMMDDhhmmss;

//将时间 yymmdd hh:mm:ss 按 时区 转换 时：分：秒
//eg: 2018-01-29 19:56:34 转化为相应时区的时间  21:56:34
+ (NSString *)getZoneConvertHHMMssStandardTime:(NSString *)inputYY_MM_DD_time;

//将时间 yymmdd hh:mm:ss 按 时区 转换 时：分
//eg: 2018-01-29 19:56:34 转化为相应时区的时间  19:56
+ (NSString *)getZoneConvertHHMMStandardTime:(NSString *)inputYY_MM_DD_time;

//将时间 yymmdd hh:mm:ss 按 时区 转换
//eg: 2018-01-29 19:56:34 转化为相应时区的时间  2018-01-29 21:56:34
+ (NSString *)getZoneConvertYYMMDDTimeStandardTime:(NSString *)inputYY_MM_DD_time;

//将时间 yymmddhhmmss 按 时区 转换
//eg:20180129195634 转化为相应时区的时间  19:56
+ (NSString *)gettZoneConverHHMMNumberOnlyTime:(NSString *)inputYYMMDDtime;

@end


