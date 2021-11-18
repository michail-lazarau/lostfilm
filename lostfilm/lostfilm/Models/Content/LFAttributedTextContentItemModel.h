//
//  LFAttributedTextContentItemModel.h
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFTextContentItemModel.h"

@interface LFAttributedTextContentItemModel : LFTextContentItemModel
- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText;

@property (nonatomic, copy, readonly) NSAttributedString *attributedText;
@end
