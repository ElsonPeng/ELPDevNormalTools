//
//  ELPUniversalMethods.m
//  ELPDevNormalTools
//
//  Created by ElsonPeng on 2018/5/11.
//  Copyright © 2018年 ElsonPeng. All rights reserved.
//

#import "ELPUniversalMethods.h"

@implementation ELPUniversalMethods

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


@end
