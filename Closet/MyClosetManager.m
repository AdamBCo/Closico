//
//  MyClosetManager.m
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "MyClosetManager.h"

@implementation MyClosetManager

+(instancetype)sharedClient{
    static MyClosetManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        _sharedClient = [[MyClosetManager alloc] init];
    });
    
    return _sharedClient;
}

-(instancetype)init{
    if (self = [super init]) {
        self.closetItems = [NSMutableArray array];
        
        NSDictionary *clothesZero = @{@"Name": @"Cool"};
        [self.closetItems addObject:clothesZero];
        
        NSDictionary *clothesOne = @{@"Name": @"Awesom"};
        [self.closetItems addObject:clothesOne];

        NSDictionary *clothesTwo = @{@"Name": @"Sick"};
        [self.closetItems addObject:clothesTwo];

        NSDictionary *clothesThree = @{@"Name": @"Nice"};
        [self.closetItems addObject:clothesThree];

        NSDictionary *clothesFour = @{@"Name": @"Suck"};
        [self.closetItems addObject:clothesFour];

    }
    return self;
};

@end
