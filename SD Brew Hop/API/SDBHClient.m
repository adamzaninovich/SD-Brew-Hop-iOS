//
//  SDBHClient.m
//  SD Brew Hop
//
//  Created by Developer on 11/20/13.
//  Copyright (c) 2013 Adam Zaninovich. All rights reserved.
//

#import "SDBHClient.h"

@implementation SDBHClient

+ (SDBHClient *)sharedClient {
  static SDBHClient *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSURL *baseURL = [NSURL URLWithString:@"http://sd-brew-hop.dev/"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"SD Brew Hop iOS 1.0.0"}];
    
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                      diskCapacity:50 * 1024 * 1024
                                                          diskPath:nil];
    [config setURLCache:cache];
    
    _sharedClient = [[SDBHClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
  });
  return _sharedClient;
}

- (NSURLSessionDataTask *)get:(NSString *)endpoint completion:( void(^)(NSArray *results, NSError *error) )completion {
  NSURLSessionDataTask *task = [self GET:endpoint
                              parameters:@{}
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                   if (httpResponse.statusCode == 200) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                       completion(responseObject, nil);
                                     });
                                   } else {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                       completion(nil, nil);
                                     });
                                     NSLog(@"Received: %@", responseObject);
                                     NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                   }
                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                     completion(nil, error);
                                   });
                                 }];
  return task;
}



@end
