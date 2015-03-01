//
//  TrendingItemsManager.m
//  Closet
//
//  Created by Adam Cooper on 3/1/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "TrendingItemsManager.h"

@implementation TrendingItemsManager


- (BOOL)connected{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    switch (networkStatus){
        case NotReachable:{
            NSLog(@"The internet is down.");
            return NO;
            break;
        }
        case ReachableViaWiFi:{
            NSLog(@"The internet is working via WIFI.");
            return NO;
            break;
        }
        case ReachableViaWWAN:{
            NSLog(@"The internet is working via WWAN.");
            return NO;
            break;
        }
        default:
            return YES;
            break;
    }
    return YES;
}

-(BOOL)hostConnection{
    Reachability *reachability = [Reachability reachabilityWithHostName:@"https://www.google.com"];
    [reachability startNotifier];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    switch (networkStatus){
        case NotReachable:{
            NSLog(@"A gateway to the host server is down.");
            return NO;
            break;
        }
        case ReachableViaWiFi:{
            NSLog(@"A gateway to the host server is working via WIFI.");
            return NO;
            break;
        }
        case ReachableViaWWAN:{
            NSLog(@"A gateway to the host server is working via WWAN.");
            return NO;
            break;
        }
        default:
            return YES;
            break;
    }
    return YES;
}


//Create a shared Instagram Client
+(instancetype)sharedClient{
    static TrendingItemsManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        _sharedClient = [[TrendingItemsManager alloc] init];
    });
    
    return _sharedClient;
}

-(instancetype)init{
    if (self = [super init]) {
        self.trendingItems = [NSArray array];
    }
    return self;
};

-(void)downloadItemswithSearchTerm:(NSString *)searchTerm andImageWidth:(CGFloat)width withCompletion:(void (^)(void))completion{
    
    NSString *imageWidth = [[NSNumber numberWithFloat:width*2] stringValue];
    
    //    NSString *baseURLString = [NSString stringWithFormat:@"http://api.macys.com/v4/catalog/search?searchphrase=%@&sortorderby=BEST_SELLERS", searchTerm];
    NSString *baseURLString = [NSString stringWithFormat:@"http://api.macys.com/v4/catalog/search?searchphrase=%@&show=product&sortorderby=BEST_SELLERS&imagewidth=%@&imagequality=90",searchTerm, imageWidth];
    NSURL *url = [NSURL URLWithString:[baseURLString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setAllowsCellularAccess:YES];
    [configuration setHTTPAdditionalHeaders:@{@"X-Macys-Webservice-Client-Id": @"Launch2015",
                                              @"Accept": @"application/json"}];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        if (error) {
            
            NSLog(@"ERROR: %@",error.localizedDescription);
            
        } else {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if (httpResponse.statusCode == 200) {
                
                NSDictionary *jSONresult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                NSDictionary *result = [jSONresult [@"searchresultgroups"] firstObject];
                NSDictionary *products = [result objectForKey:@"products"];
                NSArray *results = [products objectForKey:@"product"];
//                
//                NSLog(@"Products: %@",results);
//                
                NSMutableArray *items = [NSMutableArray array];
                
                for (NSDictionary *data in results) {
                    Item *item = [[Item alloc] initItemWithProductData:data];
                    [items addObject:item];
                }
                
                self.trendingItems = [[NSArray alloc] initWithArray:items];
                
            } else {
                NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
            }
        }
        
        
        completion();
    }];
    
    [task resume];
    
}

@end
