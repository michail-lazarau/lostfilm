//
//  LFApiHelper.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 15.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFApiHelper.h"
#import "LFApiBase+Protected.h"
#import "NSURLRequest+AppCore.h" // MARK: required for typedef ACURLCompletionHadler

// MARK: commented exposed interface NSDate (AppCore) was substituted with #import "NSURLRequest+AppCore.h"
//@interface NSURLRequest (AppCore) // MARK: required for making method "ac_sendAsynchronousWithCompletionHandler" exposed for the class
//
//- (void)ac_sendAsynchronousWithCompletionHandler:(ACURLCompletionHadler)handler;
//
//@end

@implementation LFApiHelper

+ (instancetype)defaultHelper {
    return [[self alloc] initApiHelper];
}

- (instancetype)initApiHelper {
    if (self = [super initWithParentApi:nil andName:nil]) {
        _series = [[LFApiSeries alloc] initWithParentApi:self];
        _news = [[LFApiNews alloc] initWithParentApi:self];
        _videos = [[LFApiVideos alloc] initWithParentApi:self];
    }
    return self;
}

- (void)sendAsynchronousRequest:(NSURLRequest *)request
              completionHandler:(void (^)(id, NSError *))completionHandler {
    
    __weak typeof(self) weakSelf = self;
    
    [request ac_sendAsynchronousWithCompletionHandler:^(id data, NSHTTPURLResponse *response) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        NSError *error = nil;
        
        if (response.statusCode == 523) { // MARK: 523 - Cloudflare error "origin is unreachable"
            error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:NSURLErrorCannotFindHost userInfo:nil];
        }
        
//        if (!response) {
//            error = [NSError tf_errorWithCode:TFErrorTypeNoInternetConnection
//                                      message:ACStringByKey(@"TF_ERROR_NO_INTERNET_CONNECTION")];
//        } else if (!response.ac_isStatusCorrect) {
//            error = [NSError tf_errorWithCode:TFErrorTypeNoInternetConnection
//                                      message:ACStringByKey(@"TF_ERROR_NO_INTERNET_CONNECTION")];
//        }
        
        if (completionHandler) {
            completionHandler((error ? nil : data), error);
        }
    }];
}

@end
