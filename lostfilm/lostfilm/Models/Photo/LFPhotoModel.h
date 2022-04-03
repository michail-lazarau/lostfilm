//
//  LFPhotoModel.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 19.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFJsonObject.h"

@interface LFPhotoModel : LFJsonObject
@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong, readonly) NSURL *highQualityImageUrl;
@property (nonatomic, copy, readonly) NSString *title;
@end
