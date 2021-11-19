//
//  LFApiSeries.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/18/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFApiSeries.h"

#import "LFApiBase+Protected.h"

#import <DVHtmlToModels/DVHtmlToModels.h>

#import "NSError+LF.h" // MARK: for exposing "lf_errorDefault" method to the class

static NSUInteger const LFApiSeriesNumberOfItemsOnPage = 10;

@implementation LFApiSeries

- (void)getSeriesListsFilter:(void (^)(LFSeriesFilterModel *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetSeriesListsFilterContext"];
    [htmlToModels loadDataWithReplacingURLParameters:nil
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        LFSeriesFilterModel *filter = nil;
        NSError *error = nil;
        
        if (data) {
            NSArray *filtersListData = data[NSStringFromClass([LFSeriesFilterModel class])];
            if (ACValidArray(filtersListData)) {
                filter = [[LFSeriesFilterModel alloc] initWithData:filtersListData.firstObject];
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(filter, error);
        }
    }];
}

- (void)getSeriesListForPage:(NSUInteger)page
           completionHandler:(void (^)(NSArray<LFSeriesModel *> *,
                                       NSError *))completionHandler {
    
    NSURLRequest *request = [NSURLRequest ac_requestPostForRootLinkByHref:@"ajaxik.php"
                                                               parameters:@{ @"act": @"serial",
                                                                             @"type": @"search",
                                                                             @"o": @(LFApiSeriesNumberOfItemsOnPage * (page - 1)),
                                                                             @"s": @(3),
                                                                             @"t": @(0) }
                                                             headerFields:@{ @"Referer": @"https://www.lostfilm.tv/series/?type=search&s=3&t=0" }];
    [self sendAsynchronousRequest:request completionHandler:^(id data, NSError *error) {
        
        NSMutableArray<LFSeriesModel *> *seriesList = nil;

        if (data) {
            NSArray *seriesListData = [data ac_arrayForKey:@"data"];
            if (ACValidArray(seriesListData)) {
                seriesList = [NSMutableArray new];

                for (NSDictionary *seriesData in seriesListData) {
                    [seriesList addObject:[[LFSeriesModel alloc] initWithData:seriesData]];
                }
            }
        }

        if (completionHandler) {
            completionHandler(ACValidArray(seriesList) ? seriesList.copy : nil, error);
        }
    }];
}

- (void)getNewEpisodeListForPage:(NSUInteger)page
               completionHandler:(void (^)(NSArray<LFEpisodeModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetNewEpisodeListContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ @(page).stringValue ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        NSMutableArray<LFEpisodeModel *> *newEpisodeList = nil;
        NSError *error = nil;
        
        if (data) {
            NSArray *newEpisodeListData = data[NSStringFromClass([LFEpisodeModel class])];
            if (ACValidArray(newEpisodeListData)) {
                newEpisodeList = [NSMutableArray new];
                
                for (NSDictionary *newEpisodeData in newEpisodeListData) {
                    [newEpisodeList addObject:[[LFEpisodeModel alloc] initWithData:newEpisodeData]];
                }
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(ACValidArray(newEpisodeList) ? newEpisodeList.copy : nil, error);
        }
    }];
}

- (void)getDetailsForSeriesById:(NSString *)seriesId
              completionHandler:(void (^)(LFSeriesModel *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetSeriesDetailsContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ ACUnnilStr(seriesId) ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        LFSeriesModel *seriesModel = nil;
        NSError *error = nil;
        
        if (data) {
            NSDictionary *seriesData = ((NSArray *)data[NSStringFromClass([LFSeriesModel class])]).firstObject;
            if (ACValidDictionary(seriesData)) {
                
                seriesModel = [[LFSeriesModel alloc] initWithData:seriesData
                                                            andId:seriesId];
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(seriesModel, error);
        }
    }];
}

- (void)getSeriesGuideForSeriesById:(NSString *)seriesId
                  completionHandler:(void (^)(NSArray<LFSeasonModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetSeriesGuideContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ ACUnnilStr(seriesId) ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        NSMutableArray<LFSeasonModel *> *seasonList = nil;
        NSError *error = nil;
        
        if (data) {
            NSArray *seasonListData = data[NSStringFromClass([LFSeasonModel class])];
            if (ACValidArray(seasonListData)) {
                seasonList = [NSMutableArray new];
                
                for (NSDictionary *seasonData in seasonListData) {
                    [seasonList addObject:[[LFSeasonModel alloc] initWithData:seasonData]];
                }
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(ACValidArray(seasonList) ? seasonList.copy : nil, error);
        }
    }];
}

- (void)getNewsListForSeriesById:(NSString *)seriesId
                            page:(NSUInteger)page
               completionHandler:(void (^)(NSArray<LFNewsModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetSeriesNewsListContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ ACUnnilStr(seriesId),
                                                        @(page).stringValue ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        NSMutableArray<LFNewsModel *> *newsList = nil;
        NSError *error = nil;
        
        if (data) {
            NSArray *newsListData = data[NSStringFromClass([LFNewsModel class])];
            if (ACValidArray(newsListData)) {
                newsList = [NSMutableArray new];
                
                for (NSDictionary *newsData in newsListData) {
                    [newsList addObject:[[LFNewsModel alloc] initWithData:newsData]];
                }
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(newsList, error);
        }
    }];
}

- (void)getVideoListForSeriesById:(NSString *)seriesId
                             page:(NSUInteger)page
                completionHandler:(void (^)(NSArray<LFVideoModel *> *, NSError *))completionHandler {

    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetSeriesVideoListContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ ACUnnilStr(seriesId),
                                                        @(page).stringValue ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        NSMutableArray<LFVideoModel *> *videoList = nil;
        NSError *error = nil;
        
        if (data) {
            NSArray *videoListData = data[NSStringFromClass([LFVideoModel class])];
            if (ACValidArray(videoListData)) {
                videoList = [NSMutableArray new];
                
                for (NSDictionary *videoData in videoListData) {
                    [videoList addObject:[[LFVideoModel alloc] initWithData:videoData]];
                }
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(videoList, error);
        }
    }];
}

- (void)getPhotoListForSeriesById:(NSString *)seriesId
                             page:(NSUInteger)page
                completionHandler:(void (^)(NSArray<LFPhotoModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetSeriesPhotoListContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ ACUnnilStr(seriesId),
                                                        @(page).stringValue ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        NSArray<LFPhotoModel *> *photoList = [data lf_itemsForKeyWhichAsNameOfItemClass:LFPhotoModel.class];
        NSError *error = (ACValidArray(photoList) ? nil : [NSError lf_errorDefault]);
        
        if (completionHandler) {
            completionHandler(photoList, error);
        }
    }];
}

- (void)getCastForSeriesById:(NSString *)seriesId
           completionHandler:(void (^)(NSArray<LFPersonModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetSeriesCastContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ ACUnnilStr(seriesId) ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        NSMutableArray<LFPersonModel *> *personList = nil;
        NSError *error = nil;
        
        if (data) {
            NSArray *personListData = data[NSStringFromClass([LFPersonModel class])];
            if (ACValidArray(personListData)) {
                personList = [NSMutableArray new];
                
                for (NSDictionary *personData in personListData) {
                    [personList addObject:[[LFPersonModel alloc] initWithData:personData]];
                }
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(ACValidArray(personList) ? personList.copy : nil, error);
        }
    }];
}

- (void)getTimetableWithCompletionHandler:(void (^)(NSArray<LFEpisodeModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetTimetableContext"];
    [htmlToModels loadDataWithReplacingURLParameters:nil
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        NSMutableArray<LFEpisodeModel *> *newEpisodeList = nil;
        NSError *error = nil;
        
        if (data) {
            NSArray *newEpisodeListData = data[NSStringFromClass([LFEpisodeModel class])];
            if (ACValidArray(newEpisodeListData)) {
                newEpisodeList = [NSMutableArray new];
                
                for (NSDictionary *newEpisodeData in newEpisodeListData) {
                    [newEpisodeList addObject:[[LFEpisodeModel alloc] initWithData:newEpisodeData]];
                }
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(ACValidArray(newEpisodeList) ? newEpisodeList.copy : nil, error);
        }
    }];
}

@end
