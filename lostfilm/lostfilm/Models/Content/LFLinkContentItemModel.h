//
//  LFLinkContentItemModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFContentItemModel.h"

@interface LFLinkContentItemModel : LFContentItemModel
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSURL *url;
@end
