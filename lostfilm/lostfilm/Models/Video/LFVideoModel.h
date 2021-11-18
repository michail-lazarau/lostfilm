//
//  LFVideoModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 1/6/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFJsonObject.h"

@interface LFVideoModel : LFJsonObject
@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSURL *previewURL;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *details;
@property (nonatomic, copy, readonly) NSURL *videoURL;
@end
