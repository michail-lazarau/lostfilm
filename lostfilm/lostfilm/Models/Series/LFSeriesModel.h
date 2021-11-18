//
//  LFSeriesModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/17/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFJsonObject.h"

typedef enum {
    LFSeriesStatusUndefined = -1
} LFSeriesStatus;

@interface LFSeriesModel : LFJsonObject
- (instancetype)initWithData:(NSDictionary *)data
                       andId:(NSString *)id;

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *nameRu;
@property (nonatomic, copy, readonly) NSString *nameEn;
@property (nonatomic, copy, readonly) NSURL *photoUrl;
@property (nonatomic, readonly) double rating;
@property (nonatomic, readonly) LFSeriesStatus status;
@property (nonatomic, strong, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *channels;
@property (nonatomic, copy, readonly) NSString *genres;

@property (nonatomic, copy, readonly) NSString *details;

// Full Details
@property (nonatomic, copy, readonly) NSURL *posterURL;
@property (nonatomic, strong, readonly) NSDate *premiereDate;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, readonly) double ratingIMDb;
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSURL *officialSiteURL;
@property (nonatomic, strong, readonly) NSString *seriesDescription;
@end
