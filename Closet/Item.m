//
//  ClosetItem.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "Item.h"

@implementation Item{
    NSDictionary *json;
}


-(instancetype)initItemWithProductData:(NSDictionary *)productData {
    self = [super init];
    if (self) {
        json = productData;
    }
    return self;
}

-(NSNumber *)id{
    NSNumber *number = [NSNumber new];
    
    if(json [@"id"] != [NSNull null]){
        return json [@"id"];
    }
    return number;
    
}

-(NSString *)name {
    NSString *string = [NSString new];
    
    if(json [@"summary"][@"name"] != [NSNull null]){
        return json [@"summary"][@"name"];
    }
    return string;
    
    
}

-(NSString *)brand {
    NSString *string = [NSString new];
    
    if(json [@"summary"][@"brand"] != [NSNull null]){
        return json [@"summary"][@"brand"];
    }
    return string;
    
    
}

-(NSURL *)productURL {
    NSURL *url = [NSURL new];
    if(json [@"summary"][@"producturl"] != [NSNull null]){
        return json [@"summary"][@"description"];
    }
    return url;
}


-(NSURL *)standardResolutonImageURL{
    NSURL *url = [NSURL new];
    if([json [@"image"] firstObject] != [NSNull null]){
        NSString *theURLString = [json [@"image"] firstObject][@"imageurl"];
        return [NSURL URLWithString:theURLString];
    }
    return url;
}

-(NSNumber *)categoryID{
    NSNumber *number = [NSNumber new];
    
    if([json [@"image"] firstObject] != [NSNull null]){
        return [json [@"image"] firstObject][@"id"];
    }
    return number;
    
}




@end
