//
//  TypeOfItem.h
//  Closet
//
//  Created by Adam Cooper on 3/1/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TypeOfItem : NSObject

@property (readonly) NSString *iconName;
@property (readonly) NSNumber *categoryID;
@property (readonly) NSString *iconStorageName;

-(instancetype)initWithDictionary:(NSDictionary *)iconData;

@end
