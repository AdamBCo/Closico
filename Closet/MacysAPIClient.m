//
//  MacysNetworkingAPI.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "MacysAPIClient.h"
#import "Brand.h"

@interface MacysAPIClient()

@property NSURLSession *brandSession;

@end

@implementation MacysAPIClient

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
    static MacysAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        _sharedClient = [[MacysAPIClient alloc] init];
    });
    
    return _sharedClient;
}

-(instancetype)init{
    if (self = [super init]) {
        self.brands = [NSMutableArray array];
    }
    return self;
};

-(void)downloadBrandsFor:(NSString *)categoryID withCompletion:(void (^)(void))completion{
    
    NSString *baseURLString = [NSString stringWithFormat:@"https://api.macys.com/v4/catalog/category/brandindex/%@?refcatid=118",categoryID];
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
                NSArray *results = [jSONresult valueForKey:@"brandIndex"];
                
                NSMutableArray *brands = [NSMutableArray array];
                
                for (NSDictionary *brandData in results) {
                    Brand *brand = [[Brand alloc] initWithBrandData:brandData];
                    [brands addObject:brand];
                }
                
                self.brands = [[NSArray alloc] initWithArray:brands];
                
                
            } else {
                NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
            }
        }
        
        
        completion();
    }];
    
    [task resume];
    
}

-(void)downloadItemswithBrandID:(NSString *)categoryID andDesigner:(NSString *)designerName withCompletion:(void (^)(NSArray *items))completion{

    
    NSString *baseURLString = [NSString stringWithFormat:@"v4/catalog/category/brandindex/%@?refcatid=%@",designerName, categoryID];
    NSURL *url = [NSURL URLWithString:[baseURLString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setAllowsCellularAccess:YES];
    [configuration setHTTPAdditionalHeaders:@{@"X-Macys-Webservice-Client-Id": @"Launch2015",
                                              @"Accept": @"application/json"}];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"Data: %@",response);
        
        
        if (error) {
            
            NSLog(@"ERROR: %@",error.localizedDescription);
            
        } else {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if (httpResponse.statusCode == 200) {
                
                NSDictionary *jSONresult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                NSLog(@"Items: %@",jSONresult);
//                NSArray *results = [jSONresult valueForKey:@"brandIndex"];
//                
//                NSMutableArray *brands = [NSMutableArray array];
//                
//                for (NSDictionary *brandData in results) {
//                    Brand *brand = [[Brand alloc] initWithBrandData:brandData];
//                    [brands addObject:brand];
//                }
//                
//                self.brands = [[NSArray alloc] initWithArray:brands];
                
                
            } else {
                NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
            }
        }
        
        
//        completion();
    }];
    
    [task resume];
    
}


@end


