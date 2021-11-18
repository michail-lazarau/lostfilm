//
//  LFPersonModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/10/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFPersonModel.h"

AC_EXTERN_STRING_M_V(LFPersonModelIdKey, @"id")
AC_EXTERN_STRING_M_V(LFPersonModelPhotoURLKey, @"photoURL")
AC_EXTERN_STRING_M_V(LFPersonModelNameRuKey, @"nameRu")
AC_EXTERN_STRING_M_V(LFPersonModelNameEnKey, @"nameEn")
AC_EXTERN_STRING_M_V(LFPersonModelRoleRuKey, @"roleRu")
AC_EXTERN_STRING_M_V(LFPersonModelRoleEnKey, @"roleEn")

@implementation LFPersonModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        _id = [data ac_stringForKey:LFPersonModelIdKey];
        _photoURL = [data ac_urlForKey:LFPersonModelPhotoURLKey];
        _nameRu = [data ac_stringForKey:LFPersonModelNameRuKey];
        _nameEn = [data ac_stringForKey:LFPersonModelNameEnKey];
        _roleRu = [data ac_stringForKey:LFPersonModelRoleRuKey];
        _roleEn = [data ac_stringForKey:LFPersonModelRoleEnKey];
    }
    return self;
}

@end
