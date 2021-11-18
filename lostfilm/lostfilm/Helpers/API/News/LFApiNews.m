//
//  LFApiNews.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 05.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFApiNews.h"

#import <DVHtmlToModels/DVHtmlToModels.h>

@implementation LFApiNews

- (void)getNewsListForPage:(NSUInteger)page
         completionHandler:(void (^)(NSArray<LFNewsModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetNewsListContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ @(page).stringValue,
                                                        @"0" ]
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

- (void)getDetailsForNewsById:(NSString *)newsId
            completionHandler:(void (^)(LFNewsModel *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetNewsDetailsContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ ACUnnilStr(newsId) ]
                                  queryURLParameters:nil
                                              asJSON:YES
                                   completionHandler:
     ^(NSDictionary *data, NSData *htmlData) {
        
        LFNewsModel *newsModel = nil;
        NSError *error = nil;
        
        if (data) {
            NSDictionary *newsData = ((NSArray *)data[NSStringFromClass([LFNewsModel class])]).firstObject;
            if (ACValidDictionary(newsData)) {
                
                newsModel = [[LFNewsModel alloc] initWithData:newsData];
            }
        } else {
            error = [NSError lf_errorDefault];
        }
        
        if (completionHandler) {
            completionHandler(newsModel, error);
        }
    }];
}

@end
