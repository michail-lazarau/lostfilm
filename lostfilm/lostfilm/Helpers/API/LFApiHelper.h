//
//  LFApiHelper.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 15.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFApiSeries.h"
#import "LFApiNews.h"
#import "LFApiVideos.h"

@interface LFApiHelper : LFApiBase
+ (instancetype)defaultHelper;

- (instancetype)initWithParentApi:(LFApiBase *)parentApi __attribute__((unavailable("initWithParentApi not available, call defaultHelper instead")));
- (instancetype)initWithParentApi:(LFApiBase *)parentApi andName:(NSString *)name __attribute__((unavailable("initWithParentApi:andName: not available, call defaultHelper instead")));

@property (nonatomic, strong, readonly) LFApiSeries *series;
@property (nonatomic, strong, readonly) LFApiNews *news;
@property (nonatomic, strong, readonly) LFApiVideos *videos;
@end
