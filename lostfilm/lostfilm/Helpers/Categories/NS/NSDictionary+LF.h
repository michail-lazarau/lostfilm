//
//  NSDictionary+LF.h
//  Lostfilm
//
//  Created by Denis Vashkovski on 05.01.2020.
//  Copyright © 2020 VandV. All rights reserved.
//

#import <Foundation/NSDictionary.h> // MARK: fix for "Cannot find interface declaration for 'NSDictionary'"

@interface NSDictionary(LF)
- (NSArray *)lf_itemsForKey:(NSString *)key itemClass:(Class)itemClass;
- (NSArray *)lf_itemsForKeyWhichAsNameOfItemClass:(Class)itemClass;
@end
