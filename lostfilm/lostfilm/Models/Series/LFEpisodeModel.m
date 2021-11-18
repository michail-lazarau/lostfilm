//
//  LFEpisodeModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/6/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFEpisodeModel.h"

AC_EXTERN_STRING_M_V(LFEpisodeModelIdKey, @"id")
AC_EXTERN_STRING_M_V(LFEpisodeModelSeriesKey, @"series")
AC_EXTERN_STRING_M_V(LFEpisodeModelSeasonNumberKey, @"seasonNumber")
AC_EXTERN_STRING_M_V(LFEpisodeModelNumberKey, @"number")
AC_EXTERN_STRING_M_V(LFEpisodeModelTitleRuKey, @"titleRu")
AC_EXTERN_STRING_M_V(LFEpisodeModelTitleEnKey, @"titleEn")
AC_EXTERN_STRING_M_V(LFEpisodeModelDateRuKey, @"dateRu")
AC_EXTERN_STRING_M_V(LFEpisodeModelDateEnKey, @"dateEn")

AC_EXTERN_STRING_M_V(LFEpisodeModelDateFormatKey, @"dd.MM.yyyy")

@implementation LFEpisodeModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _id = [data ac_stringForKey:LFEpisodeModelIdKey];
        
        NSDictionary *seriesData = [data ac_arrayForKey:LFEpisodeModelSeriesKey].firstObject;
        if (ACValidDictionary(seriesData)) {
            _series = [[LFSeriesModel alloc] initWithData:seriesData];
        }
        
        _seasonNumber = [data ac_stringForKey:LFEpisodeModelSeasonNumberKey].integerValue;
        _number = [data ac_stringForKey:LFEpisodeModelNumberKey].integerValue;
        _titleRu = [data ac_stringForKey:LFEpisodeModelTitleRuKey];
        _titleEn = [data ac_stringForKey:LFEpisodeModelTitleEnKey];
        _dateRu = data[LFEpisodeModelDateRuKey];
        _dateEn = data[LFEpisodeModelDateEnKey];
    }
    return self;
}

- (BOOL)isAvailable {
    return self.dateRu.timeIntervalSinceNow < 0;
}

@end
