//
//  MyClosetManager.h
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClosetManager : NSObject

@property NSMutableArray *closetItems;

+ (instancetype)sharedClient;

@end
