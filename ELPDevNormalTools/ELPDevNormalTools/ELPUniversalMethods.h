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

@end

