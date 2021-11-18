//
//  LFApiBase.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 17.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFApiBase+Protected.h"
#import "NSString+AppCore.h"

@interface LFApiBase()
@property (nonatomic, strong) LFApiBase *rootParent;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *link;
@end

@implementation LFApiBase

- (instancetype)initWithParentApi:(LFApiBase *)parentApi
                          andName:(NSString *)name {
    if (self = [super init]) {
        _parentApi = parentApi;
        _name = name;
        
        NSMutableArray *linkParts = [NSMutableArray new];
        [linkParts addObject:ACUnnilStr(self.name)];
        
        self.rootParent = self.parentApi;
        while (self.rootParent.parentApi) {
            NSString *rootParentName = self.rootParent.name;
            if (ACValidStr(rootParentName)) {
                [linkParts addObject:rootParentName];
            }
            
            self.rootParent = self.rootParent.parentApi;
        }
        
        self.link = [[[linkParts reverseObjectEnumerator] allObjects] componentsJoinedByString:@"/"];
    }
    return self;
}

- (instancetype)initWithParentApi:(LFApiBase *)parentApi {
    return [self initWithParentApi:parentApi andName:self.name];
}

- (NSString *)linkWithApiMethod:(NSString *)apiMethod {
    return [self.link stringByAppendingPathComponent:apiMethod];
}

- (void)sendAsynchronousRequest:(NSURLRequest *)request
              completionHandler:(void (^)(id, NSError *))completionHandler {
    
    if (!self.rootParent) {
        NSAssert(NO, @"You need to overwrite this method into root parentApi");
    } else {
        [self.rootParent sendAsynchronousRequest:request completionHandler:completionHandler];
    }
}

@end
