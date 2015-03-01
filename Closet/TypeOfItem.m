//
//  TypeOfItem.m
//  Closet
//
//  Created by Adam Cooper on 3/1/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "TypeOfItem.h"

@implementation TypeOfItem{
    NSDictionary *dictionary;
}

-(instancetype)initWithDictionary:(NSDictionary *)iconData{
    self = [super init];
    if (self) {
        dictionary = iconData;
    }
    return self;
}

-(NSString *)iconName{
    
    NSString *string = [NSString new];
    
    if(dictionary [@"iconName"] != [NSNull null]){
        return dictionary [@"iconName"];
    }
    return string;
    
}

-(NSString *)iconStorageName{
    
    NSString *string = [NSString new];
    
    if(dictionary [@"iconStorageName"] != [NSNull null]){
        return dictionary [@"iconStorageName"];
    }
    return string;
    
}

@end
