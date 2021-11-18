//
//  LFSeriesFilterModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/18/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFSeriesFilterModel.h"

AC_EXTERN_STRING_M_V(LFSeriesFilterModelTypesKey, @"types")
AC_EXTERN_STRING_M_V(LFSeriesFilterModelGenresKey, @"genres")
AC_EXTERN_STRING_M_V(LFSeriesFilterModelYearsKey, @"years")
AC_EXTERN_STRING_M_V(LFSeriesFilterModelChannelsKey, @"channels")
AC_EXTERN_STRING_M_V(LFSeriesFilterModelGroupsKey, @"groups")

@implementation LFSeriesFilterModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        // TYPES
        NSArray *typesData = [data ac_arrayForKey:LFSeriesFilterModelTypesKey];
        if (ACValidArray(typesData)) {
            NSMutableArray<LFSeriesFilterBaseModel *> *types = [NSMutableArray new];
            
            for (NSDictionary *typeData in typesData) {
                [types addObject:[[LFSeriesFilterBaseModel alloc] initWithData:typeData]];
            }
            
            _types = types.ac_isEmpty ? nil : types.copy;
        }
        
        // GENRES
        NSArray *genresData = [data ac_arrayForKey:LFSeriesFilterModelGenresKey];
        if (ACValidArray(genresData)) {
            NSMutableArray<LFSeriesFilterBaseModel *> *genres = [NSMutableArray new];
            
            for (NSDictionary *genreData in genresData) {
                [genres addObject:[[LFSeriesFilterBaseModel alloc] initWithData:genreData]];
            }
            
            _genres = genres.ac_isEmpty ? nil : genres.copy;
        }
        
        //YEARS
        NSArray *yearsData = [data ac_arrayForKey:LFSeriesFilterModelYearsKey];
        if (ACValidArray(yearsData)) {
            NSMutableArray<LFSeriesFilterBaseModel *> *years = [NSMutableArray new];
            
            for (NSDictionary *yearData in yearsData) {
                [years addObject:[[LFSeriesFilterBaseModel alloc] initWithData:yearData]];
            }
            
            _years = years.ac_isEmpty ? nil : years.copy;
        }
        
        //CHANNELS
        NSArray *channelsData = [data ac_arrayForKey:LFSeriesFilterModelChannelsKey];
        if (ACValidArray(channelsData)) {
            NSMutableArray<LFSeriesFilterBaseModel *> *channels = [NSMutableArray new];
            
            for (NSDictionary *channelData in channelsData) {
                [channels addObject:[[LFSeriesFilterBaseModel alloc] initWithData:channelData]];
            }
            
            _channels = channels.ac_isEmpty ? nil : channels.copy;
        }
        
        // GROUPS
        NSArray *groupsData = [data ac_arrayForKey:LFSeriesFilterModelGroupsKey];
        if (ACValidArray(groupsData)) {
            NSMutableArray<LFSeriesFilterBaseModel *> *groups = [NSMutableArray new];
            
            for (NSDictionary *groupData in groupsData) {
                [groups addObject:[[LFSeriesFilterBaseModel alloc] initWithData:groupData]];
            }
            
            _groups = groups.ac_isEmpty ? nil : groups.copy;
        }
    }
    return self;
}

@end
