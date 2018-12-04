# ELPDevNormalTools
Normal develop tools
添加开发中常用到的一些工具方法

1.判断字符串中是否包含中文字符
-(BOOL)containChinese;

2.判断字符串是否包含容易产生sql注入的一些字符
-(BOOL)isValidStringWithOutSqlInjection;

3.判断用户输入的密码是否符合规范，符合规范的密码要求：（1）长度8-16位 （2）密码中必须同时包含数字和字母（可包含其他特殊字符）
-(BOOL)isValidPasswordString;

4.判断中国大陆的手机号是否合法
-(BOOL)validateChinesePhone;

5.得到中英文混合字符串长度
+(NSInteger)getStringAbsoluteLength:(NSString *)stringTemp;

6.做时区转换的时候用到的方法
+(NSDate *)convertYYMMDDhhmmssToDate:(NSString *)YYMMDDhhmmss;
+(NSDate *)convertYYMMDDhhmmssToDate:(NSString *)YYMMDDhhmmss;
+(NSString *)getZoneConvertHHMMStandardTime:(NSString *)inputYY_MM_DD_time;
+(NSString *)getZoneConvertYYMMDDTimeStandardTime:(NSString *)inputYY_MM_DD_time;
+(NSString *)gettZoneConverHHMMNumberOnlyTime:(NSString *)inputYYMMDDtime;
