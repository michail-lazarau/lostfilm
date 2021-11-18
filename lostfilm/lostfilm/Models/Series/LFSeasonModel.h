//
//  LFSeasonModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/16/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFJsonObject.h"

#import "LFEpisodeModel.h"

@interface LFSeasonModel : LFJsonObject
@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, readonly) NSUInteger number;
@property (nonatomic, strong, readonly) NSURL *posterURL;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, strong, readonly) NSDate *date;
@property (nonatomic, readonly) NSUInteger allSeriesNumber;
@property (nonatomic, readonly) NSUInteger releasedSeriesNumber;
@property (nonatomic, readonly) double rating;

@property (nonatomic, copy, readonly) NSArray<LFEpisodeModel *> *episodeList;

@property (nonatomic, copy, readonly) NSString *details;
- (BOOL)isThereDetails;
@end
