//
//  LFApiBase+Protected.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 17.12.2019.
//  Copyright © 2019 VandV. All rights reserved.
//

#import "LFApiBase.h"

@interface LFApiBase(Protected)
- (void)sendAsynchronousRequest:(NSURLRequest *)request
              completionHandler:(void (^)(id data, NSError *error))completionHandler;
@end
