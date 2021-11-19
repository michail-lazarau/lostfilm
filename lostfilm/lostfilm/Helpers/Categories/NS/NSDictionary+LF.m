//
//  NSDictionary+LF.m
//  Lostfilm
//
//  Created by Denis Vashkovski on 05.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import "NSDictionary+LF.h"
#import "LFJsonObject.h" // MARK: fixing "Use of undeclared identifier 'LFJsonObject'" issue
#import "LFPhotoModel.h" // MARK: fixing "Unknown type name 'LFPhotoModel'" issue

@implementation NSDictionary(LF)

- (NSArray *)lf_itemsForKey:(NSString *)key itemClass:(Class)itemClass {
    
    NSAssert([itemClass isSubclassOfClass:LFJsonObject.class], @"%@ must be a subclass of LFJsonObject", NSStringFromClass(itemClass));

    NSMutableArray<LFPhotoModel *> *itemList = nil;

    NSArray *itemListData = [self ac_arrayForKey:key];
    if (ACValidArray(itemListData)) {
        itemList = [NSMutableArray new];
        
        for (NSDictionary *itemData in itemListData) {
            [itemList addObject:[[itemClass alloc] initWithData:itemData]];
        }
    }
    
    return itemList.ac_isEmpty ? nil : itemList.copy;
}

- (NSArray *)lf_itemsForKeyWhichAsNameOfItemClass:(Class)itemClass {
    
    return [self lf_itemsForKey:NSStringFromClass(itemClass) itemClass:itemClass];
}

@end
