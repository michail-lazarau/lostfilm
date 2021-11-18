//
//  LFNewsModel.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 05.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFNewsModel.h"

AC_EXTERN_STRING_M_V(LFNewsModelIdKey, @"id")
AC_EXTERN_STRING_M_V(LFNewsModelPhotoUrlStrKey, @"photoUrlStr")
AC_EXTERN_STRING_M_V(LFNewsModelTypeKey, @"type")
AC_EXTERN_STRING_M_V(LFNewsModelTitleKey, @"title")
AC_EXTERN_STRING_M_V(LFNewsModelBriefTextKey, @"briefText")
AC_EXTERN_STRING_M_V(LFNewsModelDateKey, @"date")
AC_EXTERN_STRING_M_V(LFNewsModelContentKey, @"content")

AC_EXTERN_STRING_M_V(LFNewsModelDateFormat, @"dd MMMM yyyy г.")

@implementation LFNewsModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _id = [data ac_stringForKey:LFNewsModelIdKey];
        _photoUrl = [data ac_urlForKey:LFNewsModelPhotoUrlStrKey];
        _type = [data ac_stringForKey:LFNewsModelTypeKey];
        _title = [data ac_stringForKey:LFNewsModelTitleKey];
        _briefText = [data ac_stringForKey:LFNewsModelBriefTextKey];
        
//        _date = [data ac_dateForKey:LFNewsModelDateKey withDateFormat:LFNewsModelDateFormat];

        NSString *dateData = [data ac_stringForKey:LFNewsModelDateKey];
        if (ACValidStr(dateData)) {
            NSDateFormatter *df = [NSDateFormatter new];
            df.dateFormat = LFNewsModelDateFormat;
            df.locale = [NSLocale localeWithLocaleIdentifier:@"ru"];

            NSDate *date = [df dateFromString:dateData];
            _date = date;
        }
        
        NSArray *contentListData = [data ac_arrayForKey:LFNewsModelContentKey];
        if (ACValidArray(contentListData)) {
            
            _content = [[LFContentModel alloc] initWithItemsData:contentListData];
        }
    }
    return self;
}

@end
