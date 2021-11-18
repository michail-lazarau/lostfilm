//
//  LFVideoModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/6/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFVideoModel.h"

AC_EXTERN_STRING_M_V(LFVideoModelIdKey, @"id")
AC_EXTERN_STRING_M_V(LFVideoModelPreviewURLKey, @"previewURL")
AC_EXTERN_STRING_M_V(LFVideoModelTitleKey, @"title")
AC_EXTERN_STRING_M_V(LFVideoModelDetailsKey, @"details")
AC_EXTERN_STRING_M_V(LFVideoModelVideoURLKey, @"videoURL")

@implementation LFVideoModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _id = [data ac_stringForKey:LFVideoModelIdKey];
        _previewURL = [data ac_urlForKey:LFVideoModelPreviewURLKey];
        _title = [data ac_stringForKey:LFVideoModelTitleKey];
        _details = [data ac_stringForKey:LFVideoModelDetailsKey];
        _videoURL = [data ac_urlForKey:LFVideoModelVideoURLKey];
    }
    return self;
}

@end
