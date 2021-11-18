//
//  LFSeriesModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/17/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFSeriesModel.h"

AC_EXTERN_STRING_M_V(LFSeriesModelIdKey, @"alias")
AC_EXTERN_STRING_M_V(LFSeriesModelNameRuKey, @"title")
AC_EXTERN_STRING_M_V(LFSeriesModelNameEnKey, @"title_orig")
AC_EXTERN_STRING_M_V(LFSeriesModelPhotoUrlStrKey, @"img")
AC_EXTERN_STRING_M_V(LFSeriesModelRatingKey, @"rating")
AC_EXTERN_STRING_M_V(LFSeriesModelDateKey, @"date")
AC_EXTERN_STRING_M_V(LFSeriesModelChannelsKey, @"channels")
AC_EXTERN_STRING_M_V(LFSeriesModelGenresKey, @"genres")

AC_EXTERN_STRING_M_V(LFSeriesModelPosterURLKey, @"posterURL")
AC_EXTERN_STRING_M_V(LFSeriesModelPremiereDateKey, @"premiereDate")
AC_EXTERN_STRING_M_V(LFSeriesModelCountryKey, @"country")
AC_EXTERN_STRING_M_V(LFSeriesModelRatingIMDbKey, @"ratingIMDb")
AC_EXTERN_STRING_M_V(LFSeriesModelTypeKey, @"type")
AC_EXTERN_STRING_M_V(LFSeriesModelOfficialSiteURLKey, @"officialSiteURL")
AC_EXTERN_STRING_M_V(LFSeriesModelSeriesDescriptionKey, @"seriesDescription")

AC_EXTERN_STRING_M_V(LFSeriesModelShortDateFormat, @"yyyy")
AC_EXTERN_STRING_M_V(LFSeriesModelSFullDateFormat, @"dd MMMM yyyy")

@implementation LFSeriesModel

- (instancetype)initWithData:(NSDictionary *)data andId:(NSString *)id {
    if (self = [self initWithData:data]) {
        _id = id;
    }
    return self;
}

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _id = [data ac_stringForKey:LFSeriesModelIdKey];
        _nameRu = [data ac_stringForKey:LFSeriesModelNameRuKey];
        _nameEn = [data ac_stringForKey:LFSeriesModelNameEnKey];
        
        NSString *photoUrlData = [data ac_stringForKey:LFSeriesModelPhotoUrlStrKey];
        if (ACValidStr(photoUrlData)) {
            if (![photoUrlData hasPrefix:@"http:"]) {
                photoUrlData = [NSString stringWithFormat:@"http:%@", photoUrlData];
            }
            
            _photoUrl = [NSURL URLWithString:photoUrlData];
        }
        
        _rating = [data ac_stringForKey:LFSeriesModelRatingKey].doubleValue;
        _date = [data ac_dateForKey:LFSeriesModelDateKey withDateFormat:LFSeriesModelShortDateFormat];
        _channels = [data ac_stringForKey:LFSeriesModelChannelsKey];
        _genres = [data ac_stringForKey:LFSeriesModelGenresKey];
        
        [self updateDetails];
        
        _posterURL = [data ac_urlForKey:LFSeriesModelPosterURLKey];
        
        _premiereDate = [data ac_dateForKey:LFSeriesModelPremiereDateKey
                             withDateFormat:LFSeriesModelSFullDateFormat
                           localeIdentifier:@"ru"];
        
        _country = [data ac_stringForKey:LFSeriesModelCountryKey];
        _ratingIMDb = [data ac_stringForKey:LFSeriesModelRatingIMDbKey].doubleValue;
        _type = [data ac_stringForKey:LFSeriesModelTypeKey];
        
        NSString *officialSiteURLData = [data ac_stringForKey:LFSeriesModelOfficialSiteURLKey];
        if (ACValidStr(officialSiteURLData)) {
            _officialSiteURL = [NSURL URLWithString:officialSiteURLData];
        }
        
        _seriesDescription = [data ac_stringForKey:LFSeriesModelSeriesDescriptionKey];
    }
    return self;
}

#pragma mark - Private
- (void)updateDetails {
    NSMutableString *details = [NSMutableString new];
    
    if (self.status != LFSeriesStatusUndefined) {
        [details appendFormat:@"Статус: %@", @(self.status).stringValue];
    }
    if (self.date) {
        [details appendString:@"\n"];
        [details appendFormat:@"Год выхода: %@", [self.date ac_stringWithFormat:LFSeriesModelShortDateFormat]];
    }
    if (ACValidStr(self.channels)) {
        [details appendString:@"\n"];
        [details appendFormat:@"Канал: %@", self.channels];
    }
    if (ACValidStr(self.genres)) {
        [details appendString:@"\n"];
        [details appendFormat:@"Жанр: %@", self.genres];
    }
    
    _details = details.copy;
}

@end
