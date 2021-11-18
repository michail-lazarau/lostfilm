//
//  LFAttributedTextContentItemModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFAttributedTextContentItemModel.h"

@implementation LFAttributedTextContentItemModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        
    }
    return self;
}

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText {
    if (self = [super init]) {
        _attributedText = attributedText;
    }
    return self;
}

- (NSString *)text {
    return self.attributedText.string;
}

@end
