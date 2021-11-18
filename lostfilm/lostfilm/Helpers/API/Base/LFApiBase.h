//
//  LFApiBase.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 17.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFApiBase : NSObject
+ (instancetype) new __attribute__((unavailable("new not available, call alloc and initWithParentApi: instead")));
- (instancetype) init __attribute__((unavailable("init not available, call initWithParentApi: instead")));

- (instancetype)initWithParentApi:(LFApiBase *)parentApi andName:(NSString *)name;
- (instancetype)initWithParentApi:(LFApiBase *)parentApi;

@property (nonatomic, weak, readonly) LFApiBase *parentApi;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *link;

- (NSString *)linkWithApiMethod:(NSString *)apiMethod;
@end
