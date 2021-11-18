//
//  LFApiVideos.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/6/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFApiVideos.h"

#import <DVHtmlToModels/DVHtmlToModels.h>
#import "NSError+LF.h" // for exposing "lf_errorDefault" method to the class

@implementation LFApiVideos

- (void)getVideoListForPage:(NSUInteger)page
          completionHandler:(void (^)(NSArray<LFVideoModel *> *, NSError *))completionHandler {
    
    DVHtmlToModels *htmlToModels = [DVHtmlToModels htmlToModelsWithContextByName:@"GetVideoListContext"];
    [htmlToModels loadDataWithReplacingURLParameters:@[ @(page).stringValue,
                                                        @"0" ]
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

@end
