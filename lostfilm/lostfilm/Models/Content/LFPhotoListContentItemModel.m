//
//  LFPhotoListContentItemModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFPhotoListContentItemModel.h"

AC_EXTERN_STRING_M_V(LFPhotoListContentItemModelUrlsKey, @"urls")
AC_EXTERN_STRING_M_V(LFPhotoListContentItemModelUrlKey, @"url")

@implementation LFPhotoListContentItemModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        
        NSArray<NSDictionary *> *urlsData = [data ac_arrayForKey:LFPhotoListContentItemModelUrlsKey];
        if (ACValidArray(urlsData)) {
            
            NSMutableArray<NSURL *> *urls = [NSMutableArray new];
            
            for (NSDictionary *urlData in urlsData) {
                
                NSString *urlString = [urlData ac_stringForKey:LFPhotoListContentItemModelUrlKey];
                if (!ACValidStr(urlString)) {
                    continue;
                }
                
                NSURL *url = [NSURL URLWithString:urlString];
                if (url) {
                    [urls addObject:url];
                }
            }
            
            _photoURLs = urls.ac_isEmpty ? nil : urls.copy;
        }
    }
    return self;
}

@end
