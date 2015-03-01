//
//  Brand.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "Brand.h"

@implementation Brand{
    NSDictionary *json;
}

-(instancetype)initWithBrandData:(NSDictionary *)brandJSONdata {
    self = [super init];
    if (self) {
        json = brandJSONdata;
    }
    return self;
}

-(NSString *)brandName{
    
    NSString *string = [NSString new];
    
    if(json [@"brandName"] != [NSNull null]){
        return json [@"brandName"];
    }
    return string;
    
}

-(NSURL *)brandURL{
    
    NSURL *url = [NSURL new];
    
    if(json [@"brandURL"] != [NSNull null]){
        NSString *urlString = json [@"brandURL"];
        return [NSURL URLWithString:urlString];
    }
    
    return url;
    
}

@end
