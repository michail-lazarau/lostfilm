//
//  LFContentModel.m
//  Lostfilm
//
//  Created by Dzianis Vashkouski on 2/4/20.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "LFContentModel.h"

AC_EXTERN_STRING_M_V(LFContentModelTypeKey, @"type")

typedef enum {
    LFContentTypeUndefined = -1,
    LFContentTypeText,
    LFContentTypeLink,
    LFContentTypePhotos,
    LFContentTypeVideo,
} LFContentType;

ACTypeFromString(LFContentType, ( @[ @"text",
                                     @"link",
                                     @"photos",
                                     @"video" ] ),
                 LFContentTypeUndefined)

@implementation LFContentModel

- (instancetype)initWithItemsData:(NSArray<NSDictionary *> *)itemsData {
    if (self = [super init]) {
        
        if (ACValidArray(itemsData)) {
            
            NSMutableArray<LFContentItemModel *> *items = [NSMutableArray new];
            
            LFContentItemModel *previousContentItem = nil;
            __block NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
            
            void (^addAttributedTextContentItemIfNeeded)(void) = ^(void) {

                if (attributedString && !attributedString.string.ac_isEmpty) {
                    
                    [items addObject:[[LFAttributedTextContentItemModel alloc] initWithAttributedText:attributedString.copy]];
                    attributedString = [NSMutableAttributedString new];
                }
            };
            
            for (NSDictionary *itemData in itemsData) {
                
                LFContentItemModel *contentItem = [self contentItemByData:itemData];
                if (!contentItem) {
                    continue;
                }
                
                if ([self isAttributableContentItem:contentItem]) {
                    
                    if (previousContentItem.class == contentItem.class) {
                        
                        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
                    }
                    
                    [attributedString appendAttributedString:[self attributedTextForContentItem:contentItem]];
                } else {
                    
                    addAttributedTextContentItemIfNeeded();
                    [items addObject:contentItem];
                }
                
                previousContentItem = contentItem;
            }

            addAttributedTextContentItemIfNeeded();
            
            _items = items.ac_isEmpty ? nil : items.copy;
        }
    }
    return self;
}

#pragma mark - Private
- (LFContentItemModel *)contentItemByData:(NSDictionary *)itemData {

    NSString *typeData = [itemData ac_stringForKey:LFContentModelTypeKey];
    if (!ACValidStr(typeData)) {
        return nil;
    }

    Class contentItemClass = nil;
    
    switch (LFContentTypeFromString(typeData)) {
        case LFContentTypeText: {
            
            contentItemClass = LFTextContentItemModel.class;
            break;
        }
        case LFContentTypeLink: {
            
            contentItemClass = LFLinkContentItemModel.class;
            break;
        }
        case LFContentTypePhotos: {
            
            contentItemClass = LFPhotoListContentItemModel.class;
            break;
        }
        case LFContentTypeVideo: {
            
            contentItemClass = LFVideoContentItemModel.class;
            break;
        }
        default:
            return nil;
    }
    
    return [[contentItemClass alloc] initWithData:itemData];
}

- (NSAttributedString *)attributedTextForContentItem:(LFContentItemModel *)contentItem {
    
    if ([contentItem isKindOfClass:LFLinkContentItemModel.class]) {
        
        LFLinkContentItemModel *linkContentItem = (LFLinkContentItemModel *)contentItem;
        return [[NSAttributedString alloc] initWithString:linkContentItem.title
                                               attributes:@{ NSLinkAttributeName: linkContentItem.url }];
    } else if ([contentItem isKindOfClass:LFTextContentItemModel.class]) {
        
        LFTextContentItemModel *textContentItem = (LFTextContentItemModel *)contentItem;
        return [[NSAttributedString alloc] initWithString:textContentItem.text];
    } else {
        
        return nil;
    }
}

- (BOOL)isAttributableContentItem:(LFContentItemModel *)contentItem {
    
    return ([contentItem isKindOfClass:LFTextContentItemModel.class]
            || [contentItem isKindOfClass:LFLinkContentItemModel.class]);
}

@end
