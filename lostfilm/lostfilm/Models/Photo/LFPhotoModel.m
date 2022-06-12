//
//  LFPhotoModel.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 19.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFPhotoModel.h"

AC_EXTERN_STRING_M_V(LFPhotoModelIdKey, @"id")
AC_EXTERN_STRING_M_V(LFPhotoModelUrlKey, @"url")
AC_EXTERN_STRING_M_V(LFPhotoModelTitleKey, @"title")

@implementation LFPhotoModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _id = [data ac_stringForKey:LFPhotoModelIdKey];
        _url = [data ac_urlForKey:LFPhotoModelUrlKey];
        _title = [data ac_stringForKey:LFPhotoModelTitleKey];
    }
    return self;
}

- (NSURL *)highResolutionImageUrl {
    NSString *initialUrlLastPart = [_url lastPathComponent];
    NSString *modifiedUrlLastPart = [initialUrlLastPart substringFromIndex: @"t_".length];
    return [_url.URLByDeletingLastPathComponent URLByAppendingPathComponent:modifiedUrlLastPart];
}

@end
