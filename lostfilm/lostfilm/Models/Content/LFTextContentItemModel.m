//
//  LFTextContentItemModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFTextContentItemModel.h"

AC_EXTERN_STRING_M_V(LFTextContentItemModelTextKey, @"text")

@implementation LFTextContentItemModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _text = [data ac_stringForKey:LFTextContentItemModelTextKey];
    }
    return self;
}

@end
