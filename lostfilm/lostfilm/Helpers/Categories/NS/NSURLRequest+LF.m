//
//  NSURLRequest+LF.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 15.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "Foundation/NSURLResponse.h"
#import "NSObject+AppCore.h"
#import "LFConstants.h"
#import "ACConstants.h" // MARK: fixing "Implicit declaration of function 'AC_USER_DEFINED_BY_KEY' is invalid in C99" issue
#import "NSURLRequest+LF.h"
#import "NSURLRequest+AppCore.h"
#import "NSHTTPURLResponse+AppCore.h"

@interface NSURLRequest(LF_Private)
- (void)ac_logRequest;
- (void)ac_logResponse:(NSHTTPURLResponse *)httpURLResponse
             startTime:(NSDate *)startTime
               jsonObj:(id)jsonObj;
@end

static NSTimeInterval const NSURLRequestStubDelay = 1;

@implementation NSURLRequest(LF)

AC_LOAD_ONCE([self ac_addSwizzlingSelector:@selector(lf_sendAsynchronousWithCompletionHandler:)
                          originalSelector:@selector(ac_sendAsynchronousWithCompletionHandler:)];
             [self ac_addSwizzlingSelector:@selector(lf_sendSynchronousWithResponse:)
                          originalSelector:@selector(ac_sendSynchronousWithResponse:)];)

- (void)lf_sendAsynchronousWithCompletionHandler:(void (^)(id, NSHTTPURLResponse *))completionHandler {
    void (^completionBlock)(id, NSHTTPURLResponse *) = ^void(id data, NSHTTPURLResponse *response) {
        if (completionHandler) {
            completionHandler(data, response);
        }
        
        [self handlerOfResponse:response data:data];
    };
    
    if (IsStubData) {
        [[NSOperationQueue new] addOperationWithBlock:^{
            NSDate *startTime = [NSDate date];
            
            [self ac_logRequest];
            
            [NSThread sleepForTimeInterval:NSURLRequestStubDelay];
            
            NSHTTPURLResponse *httpUrlResponse = [self successResponse];
            id stubData = [self stubData];
            
            NSLog(@"Stub Response");
            [self ac_logResponse:httpUrlResponse startTime:startTime jsonObj:stubData];
            
            completionBlock(stubData, httpUrlResponse);
        }];
    } else {
        [[self preparedRequest] lf_sendAsynchronousWithCompletionHandler:^(id data, NSHTTPURLResponse *response) {
            completionBlock(data, response);
        }];
    }
}

- (id)lf_sendSynchronousWithResponse:(NSHTTPURLResponse *__autoreleasing *)response {
    id data = nil;
    
    if (IsStubData) {
        [NSThread sleepForTimeInterval:NSURLRequestStubDelay];
        
        *response = [self successResponse];
        data = [self stubData];
    } else {
        data = [[self preparedRequest] lf_sendSynchronousWithResponse:response];
    }
    
    [self handlerOfResponse:*response data:data];
    
    return data;
}

#pragma mark - Utils
- (NSURLRequest *)preparedRequest {
    return self;
}

- (void)handlerOfResponse:(NSHTTPURLResponse *)response data:(id)data {
    if (response.statusCode == AC_STATUS_CODE_UNAUTHORIZED) {
        
    } if ((response.statusCode != AC_STATUS_CODE_OK) && [data isKindOfClass:[NSDictionary class]]) {
        
    }
}

- (NSHTTPURLResponse *)successResponse {
    return [[NSHTTPURLResponse alloc] initWithURL:self.URL
                                       statusCode:AC_STATUS_CODE_OK
                                      HTTPVersion:nil
                                     headerFields:nil];
}

@end
