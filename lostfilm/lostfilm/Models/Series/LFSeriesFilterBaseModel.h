//
//  LFSeriesFilterBaseModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/18/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFJsonObject.h"

@interface LFSeriesFilterBaseModel : LFJsonObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) NSString *value;
@property (nonatomic, getter=isSelected) BOOL selected;
@end
