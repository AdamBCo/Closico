//
//  MacysNetworkingAPI.h
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"


@protocol MacysAPIDelegate <NSObject>

@end

@interface MacysAPIClient : NSObject

@property NSArray *brands;


@property BOOL isLoading;
@property id<MacysAPIDelegate>delegate;



+ (instancetype)sharedClient;

-(BOOL)connected;
-(void)downloadBrandsFor:(NSString *)categoryID withCompletion:(void (^)(void))completion;
-(void)downloadItemswithBrandID:(NSString *)categoryID andDesigner:(NSString *)designerName withCompletion:(void (^)(NSArray *items))completion;

@end
