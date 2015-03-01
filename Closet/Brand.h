//
//  Brand.h
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject
@property (readonly) NSString *brandName;
@property (readonly) NSURL *brandURL;

-(instancetype)initWithBrandData:(NSDictionary *)brandJSONdata;

@end
