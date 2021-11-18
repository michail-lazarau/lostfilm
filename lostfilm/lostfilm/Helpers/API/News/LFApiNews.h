//
//  LFApiNews.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 05.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFApiBase.h"

#import "LFNewsModel.h"

@interface LFApiNews : LFApiBase

- (void)getNewsListForPage:(NSUInteger)page
         completionHandler:(void (^)(NSArray<LFNewsModel *> *newsList,
                                     NSError *error))completionHandler;

- (void)getDetailsForNewsById:(NSString *)newsId
            completionHandler:(void (^)(LFNewsModel *newsModel,
                                        NSError *error))completionHandler;

@end
