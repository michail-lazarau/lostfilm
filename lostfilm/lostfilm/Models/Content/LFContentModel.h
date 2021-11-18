//
//  LFContentModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFTextContentItemModel.h"
#import "LFAttributedTextContentItemModel.h"
#import "LFLinkContentItemModel.h"
#import "LFPhotoListContentItemModel.h"
#import "LFVideoContentItemModel.h"

@interface LFContentModel : LFJsonObject
- (instancetype)initWithItemsData:(NSArray<NSDictionary *> *)itemsData;

@property (nonatomic, copy, readonly) NSArray<LFContentItemModel *> *items;
@end
