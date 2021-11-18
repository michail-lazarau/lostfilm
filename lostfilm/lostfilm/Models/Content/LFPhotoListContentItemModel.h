//
//  LFPhotoListContentItemModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFContentItemModel.h"

@interface LFPhotoListContentItemModel : LFContentItemModel
@property (nonatomic, copy, readonly) NSArray<NSURL *> *photoURLs;
@end
