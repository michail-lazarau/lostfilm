//
//  NSError+LF.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 15.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import <Foundation/NSError.h> // MARK: fix for "Cannot find interface declaration for 'NSError'"

typedef enum {
    LFErrorTypeUndefined
} LFErrorType;

@interface NSError(LF)
+ (instancetype)lf_errorWithCode:(NSInteger)code message:(NSString *)message;
+ (instancetype)lf_errorWithMessage:(NSString *)message;
+ (instancetype)lf_errorWithData:(NSDictionary *)data;
+ (instancetype)lf_errorDefault;

- (NSString *)lf_message;
@end
