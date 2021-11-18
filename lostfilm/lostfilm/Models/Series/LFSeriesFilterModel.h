//
//  LFSeriesFilterModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/18/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFSeriesFilterBaseModel.h"

@interface LFSeriesFilterModel : LFJsonObject
@property (nonatomic, copy, readonly) NSArray<LFSeriesFilterBaseModel *> *types;
@property (nonatomic, copy, readonly) NSArray<LFSeriesFilterBaseModel *> *genres;
@property (nonatomic, copy, readonly) NSArray<LFSeriesFilterBaseModel *> *years;
@property (nonatomic, copy, readonly) NSArray<LFSeriesFilterBaseModel *> *channels;
@property (nonatomic, copy, readonly) NSArray<LFSeriesFilterBaseModel *> *groups;
@end
