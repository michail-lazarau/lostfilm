//
//  LFApiVideos.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/6/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFApiBase.h"

#import "LFVideoModel.h"

@interface LFApiVideos : LFApiBase

- (void)getVideoListForPage:(NSUInteger)page
          completionHandler:(void (^)(NSArray<LFVideoModel *> *videoList,
                                      NSError *error))completionHandler;

@end
