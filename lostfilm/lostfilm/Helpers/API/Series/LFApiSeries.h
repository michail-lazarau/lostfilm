//
//  LFApiSeries.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/18/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFApiBase.h"

#import "LFSeriesModel.h"
#import "LFSeriesFilterModel.h"
#import "LFEpisodeModel.h"
#import "LFSeasonModel.h"
#import "LFNewsModel.h"
#import "LFVideoModel.h"
#import "LFPhotoModel.h"
#import "LFPersonModel.h"

@interface LFApiSeries : LFApiBase

- (void)getSeriesListsFilter:(void (^)(LFSeriesFilterModel *filter,
                                       NSError *error))completionHandler;

- (void)getSeriesListForPage:(NSUInteger)page
           completionHandler:(void (^)(NSArray<LFSeriesModel *> *seriesList,
                                       NSError *error))completionHandler;

- (void)getSeriesListForPage:(NSUInteger)page
              withParameters:(NSDictionary *)parameters
           completionHandler:(void (^)(NSArray<LFSeriesModel *> *seriesList,
                                       NSError *error))completionHandler;

- (void)getNewEpisodeListForPage:(NSUInteger)page
               completionHandler:(void (^)(NSArray<LFEpisodeModel *> *episodeList,
                                           NSError *error))completionHandler;

- (void)getDetailsForSeriesById:(NSString *)seriesId
              completionHandler:(void (^)(LFSeriesModel *seriesModel,
                                          NSError *error))completionHandler;

- (void)getSeriesGuideForSeriesById:(NSString *)seriesId
                  completionHandler:(void (^)(NSArray<LFSeasonModel *> *seasonList,
                                              NSError *error))completionHandler;

- (void)getNewsListForSeriesById:(NSString *)seriesId
                            page:(NSUInteger)page
               completionHandler:(void (^)(NSArray<LFNewsModel *> *newsList,
                                           NSError *error))completionHandler;

- (void)getVideoListForSeriesById:(NSString *)seriesId
                             page:(NSUInteger)page
                completionHandler:(void (^)(NSArray<LFVideoModel *> *videoList,
                                            NSError *error))completionHandler;

- (void)getPhotoListForSeriesById:(NSString *)seriesId
                             page:(NSUInteger)page
                completionHandler:(void (^)(NSArray<LFPhotoModel *> *photoList,
                                            NSError *error))completionHandler;

- (void)getCastForSeriesById:(NSString *)seriesId
           completionHandler:(void (^)(NSArray<LFPersonModel *> *personsList,
                                       NSError *error))completionHandler;

- (void)getTimetableWithCompletionHandler:(void (^)(NSArray<LFEpisodeModel *> *episodeList,
                                                    NSError *error))completionHandler;

- (void)getGlobalSearchOutputForContext:(NSString *)searchContext
                  withCompletionHandler:(void (^)(NSArray<LFSeriesModel *> *, NSArray<LFPersonModel *> *, NSError *))completionHandler;

@end
