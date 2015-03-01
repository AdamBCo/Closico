//
//  ClosetItem.h
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface Item : NSObject


@property (readonly) NSNumber *id;
@property (readonly) NSString *name;
@property (readonly) NSString *brand;
@property (readonly) NSNumber *categoryID;

//@property (readonly) NSString *description;
//@property (readonly) NSString *typeName;
@property (readonly) NSURL *productURL;
//@property (readonly) NSString *color;
//@property (readonly) NSNumber *upcNumber;
//@property (readonly) NSArray *styles;
@property NSData *standardResolutionImageData;
@property (readonly) NSURL *standardResolutonImageURL;

-(instancetype)initItemWithProductData:(NSDictionary *)productData;




@end
