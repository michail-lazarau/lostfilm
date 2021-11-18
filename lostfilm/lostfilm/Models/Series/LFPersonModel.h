//
//  LFPersonModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/10/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFJsonObject.h"

@interface LFPersonModel : LFJsonObject
@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, strong, readonly) NSURL *photoURL;
@property (nonatomic, copy, readonly) NSString *nameRu;
@property (nonatomic, copy, readonly) NSString *nameEn;
@property (nonatomic, copy, readonly) NSString *roleRu;
@property (nonatomic, copy, readonly) NSString *roleEn;
@end
