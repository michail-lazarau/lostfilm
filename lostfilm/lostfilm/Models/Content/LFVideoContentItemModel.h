//
//  LFVideoContentItemModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFContentItemModel.h"

#import "LFVideoModel.h"

@interface LFVideoContentItemModel : LFContentItemModel
@property (nonatomic, strong, readonly) LFVideoModel *videoModel;
@end
