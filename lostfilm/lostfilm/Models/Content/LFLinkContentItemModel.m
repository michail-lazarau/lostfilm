//
//  LFLinkContentItemModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFLinkContentItemModel.h"

AC_EXTERN_STRING_M_V(LFLinkContentItemModelTitleKey, @"title")
AC_EXTERN_STRING_M_V(LFLinkContentItemModelUrlKey, @"url")

@implementation LFLinkContentItemModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _title = [data ac_stringForKey:LFLinkContentItemModelTitleKey];
        _url = [data ac_urlForKey:LFLinkContentItemModelUrlKey];
    }
    return self;
}

@end
