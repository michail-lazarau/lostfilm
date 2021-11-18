//
//  LFNewsModel.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 05.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFJsonObject.h"

#import "LFContentModel.h"

@interface LFNewsModel : LFJsonObject
@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSURL *photoUrl;
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *briefText;
@property (nonatomic, strong, readonly) NSDate *date;

// Full Details
@property (nonatomic, strong, readonly) LFContentModel *content;
@end
