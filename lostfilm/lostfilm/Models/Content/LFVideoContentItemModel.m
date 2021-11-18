//
//  LFVideoContentItemModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFVideoContentItemModel.h"

AC_EXTERN_STRING_M_V(LFVideoContentItemModelTitleKey, @"title")
AC_EXTERN_STRING_M_V(LFVideoContentItemModelDescriptionKey, @"description")
AC_EXTERN_STRING_M_V(LFVideoContentItemModelCoverUrlKey, @"cover_url")
AC_EXTERN_STRING_M_V(LFVideoContentItemModelVideoUrlKey, @"video_url")

@implementation LFVideoContentItemModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _videoModel = [[LFVideoModel alloc] initWithData:data];
    }
    return self;
}

@end
