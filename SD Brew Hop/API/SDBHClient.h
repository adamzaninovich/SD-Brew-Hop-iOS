//
//  SDBHClient.h
//  SD Brew Hop
//
//  Created by Developer on 11/20/13.
//  Copyright (c) 2013 Adam Zaninovich. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SDBHClient : AFHTTPSessionManager
+ (SDBHClient *)sharedClient;
- (NSURLSessionDataTask *)get:(NSString *)endpoint completion:( void(^)(NSArray *results, NSError *error) )completion;
@end
