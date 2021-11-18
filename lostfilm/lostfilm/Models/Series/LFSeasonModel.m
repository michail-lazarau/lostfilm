//
//  LFSeasonModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/16/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFSeasonModel.h"

AC_EXTERN_STRING_M_V(LFSeasonModelIdKey, @"id")
AC_EXTERN_STRING_M_V(LFSeasonModelNumberKey, @"number")
AC_EXTERN_STRING_M_V(LFSeasonModelPosterURLKey, @"posterURL")
AC_EXTERN_STRING_M_V(LFSeasonModelStatusKey, @"status")
AC_EXTERN_STRING_M_V(LFSeasonModelDateKey, @"date")
AC_EXTERN_STRING_M_V(LFSeasonModelAllSeriesNumberKey, @"allSeriesNumber")
AC_EXTERN_STRING_M_V(LFSeasonModelReleasedSeriesNumberKey, @"releasedSeriesNumber")
AC_EXTERN_STRING_M_V(LFSeasonModelRatingKey, @"rating")
AC_EXTERN_STRING_M_V(LFSeasonModelEpisodeListKey, @"episodeList")

AC_EXTERN_STRING_M_V(LFSeasonModelDateFormat, @"yyyy")


@interface NSDate (AppCore) // required for making method "ac_stringWithFormat" exposed for the class

-(NSString *)ac_stringWithFormat:(NSString *)format;

@end

@implementation LFSeasonModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _id = [data ac_stringForKey:LFSeasonModelIdKey];
        _number = [data ac_stringForKey:LFSeasonModelNumberKey].integerValue;
        _posterURL = [data ac_urlForKey:LFSeasonModelPosterURLKey];
        _status = [data ac_stringForKey:LFSeasonModelStatusKey];
        
        _date = [data ac_dateForKey:LFSeasonModelDateKey
                     withDateFormat:LFSeasonModelDateFormat
                   localeIdentifier:@"ru"];
        
        _allSeriesNumber = [data ac_stringForKey:LFSeasonModelAllSeriesNumberKey].integerValue;
        _releasedSeriesNumber = [data ac_stringForKey:LFSeasonModelReleasedSeriesNumberKey].integerValue;
        _rating = [data ac_stringForKey:LFSeasonModelRatingKey].doubleValue;
        
        NSArray *episodeListData = [data ac_arrayForKey:LFSeasonModelEpisodeListKey];
        if (ACValidArray(episodeListData)) {
            
            NSMutableArray *episodeList = [NSMutableArray new];
            
            for (NSDictionary *episodeData in episodeListData) {
                [episodeList addObject:[[LFEpisodeModel alloc] initWithData:episodeData]];
            }
            
            _episodeList = episodeList.ac_isEmpty ? nil : episodeList.copy;
        }
        
        [self updateDetails];
    }
    return self;
}

- (BOOL)isThereDetails {
    return (self.posterURL || ACValidStr(self.status) || self.date);
}

#pragma mark - Private
- (void)updateDetails {
    NSMutableString *details = [NSMutableString new];
    
    if (ACValidStr(self.status)) {
        [details appendFormat:@"Статус: %@", self.status];
    }
    if (self.date) {
        [details appendString:@"\n"];
        [details appendFormat:@"Год: %@", [self.date ac_stringWithFormat:LFSeasonModelDateFormat]];
    }
    
    [details appendString:@"\n"];
    [details appendFormat:@"Количество вышедших серий: %ld (из %ld)", self.releasedSeriesNumber, self.allSeriesNumber];
    
    _details = details.copy;
}

@end
