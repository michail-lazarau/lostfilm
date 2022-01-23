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

- (BOOL)isEqual:(id)object {
    BOOL result = NO;
    if ([object isKindOfClass: [self class]]) {
        LFSeriesFilterBaseModel *model = object;
        result = [self.key isEqual:model.key] &&
        [self.value isEqual:model.value] &&
        [self.name isEqual:model.name];
    }
    return result;
}
- (NSUInteger)hash
{
    NSUInteger result = 1;
    NSUInteger prime = 31;

    result = prime * result + [_name hash];
    result = prime * result + [_key hash];
    result = prime * result + [_value hash];

    return result;
}
// https://stackoverflow.com/questions/5915147/recommended-hash-function-for-overwriting-nsobjects-hash-method
// https://stackoverflow.com/questions/5054730/comparing-objects-in-obj-c

@end
