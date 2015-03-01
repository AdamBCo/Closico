//
//  TrendingItemsManager.h
//  Closet
//
//  Created by Adam Cooper on 3/1/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Item.h"

@interface TrendingItemsManager : NSObject

@property NSArray *trendingItems;
@property NSCache *itemImageCache;

+ (instancetype)sharedClient;

-(void)downloadItemswithSearchTerm:(NSString *)searchTerm andImageWidth:(CGFloat)width withCompletion:(void (^)(void))completion;

@end
