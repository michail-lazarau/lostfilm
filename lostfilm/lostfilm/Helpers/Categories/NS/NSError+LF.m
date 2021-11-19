//
//  NSError+LF.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 15.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "NSError+LF.h"
#import "NSObject+AppCore.h" // MARK: fixing "Expected identifier" issue
#import "ACLocalizationHelper.h" // MARK: fixing "Implicit declaration of function 'ACStringByKey' is invalid in C99" issue

AC_EXTERN_STRING_M_V(LF_ERROR_DOMAIN, @"com.vandv.Lostfilm")

AC_EXTERN_STRING_M_V(LFNSErrorCodeKey, @"code")
AC_EXTERN_STRING_M_V(LFNSErrorMessageKey, @"message")

AC_EXTERN_STRING_M(LFErrorMessage)

@implementation NSError(LF)

+ (instancetype)lf_errorWithCode:(NSInteger)code message:(NSString *)message {
    if (!ACValidStr(message)) {
        message = ACStringByKey(@"TF_ERROR_SOMETHING_WENT_WRONG");
    }
    
    if (code != LFErrorTypeUndefined) {
        message = [NSString stringWithFormat:@"Code %ld: %@", code, message];
    }
    
    return [[NSError alloc] initWithDomain:LF_ERROR_DOMAIN
                                      code:code
                                  userInfo:@{ LFErrorMessage: message }];
}

+ (instancetype)lf_errorWithMessage:(NSString *)message {
    if (!ACValidStr(message)) {
        message = ACStringByKey(@"LF_ERROR_SOMETHING_WENT_WRONG");
    }
    
    return [[NSError alloc] initWithDomain:LF_ERROR_DOMAIN
                                      code:LFErrorTypeUndefined
                                  userInfo:@{ LFErrorMessage: message }];
}

+ (instancetype)lf_errorWithData:(NSDictionary *)data {
    NSInteger code = LFErrorTypeUndefined;
    NSString *message = nil;
    
    if (ACValidDictionary(data)) {
        code = [data ac_numberForKey:LFNSErrorCodeKey].integerValue;
        message = [data ac_stringForKey:LFNSErrorMessageKey];
    }
    
    return [self lf_errorWithCode:code message:message];
}

+ (instancetype)lf_errorDefault {
    return [self lf_errorWithMessage:nil];
}

- (NSString *)lf_message {
    return [self.userInfo ac_stringForKey:LFErrorMessage];
}

@end
