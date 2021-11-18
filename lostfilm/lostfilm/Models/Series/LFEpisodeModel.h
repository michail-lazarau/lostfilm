//
//  LFEpisodeModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/6/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFJsonObject.h"

#import "LFSeriesModel.h"

@interface LFEpisodeModel : LFJsonObject
@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, strong, readonly) LFSeriesModel *series;
@property (nonatomic, readonly) NSUInteger seasonNumber;
@property (nonatomic, readonly) NSUInteger number;
@property (nonatomic, strong, readonly) NSString *titleRu;
@property (nonatomic, strong, readonly) NSString *titleEn;
@property (nonatomic, strong, readonly) NSDate *dateRu;
@property (nonatomic, strong, readonly) NSDate *dateEn;

- (BOOL)isAvailable;
@end
