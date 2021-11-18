//
//  LFSeriesFilterBaseModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 12/18/19.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFSeriesFilterBaseModel.h"

AC_EXTERN_STRING_M_V(LFSeriesFilterBaseModelNameKey, @"name")
AC_EXTERN_STRING_M_V(LFSeriesFilterBaseModelKeyKey, @"key")
AC_EXTERN_STRING_M_V(LFSeriesFilterBaseModelValueKey, @"value")

@implementation LFSeriesFilterBaseModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _name = [data ac_stringForKey:LFSeriesFilterBaseModelNameKey];
        _key = [data ac_stringForKey:LFSeriesFilterBaseModelKeyKey];
        _value = [data ac_stringForKey:LFSeriesFilterBaseModelValueKey];
    }
    return self;
}

@end
