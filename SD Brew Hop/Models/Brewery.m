//
//  Brewery.m
//  SD Brew Hop
//
//  Created by Developer on 11/20/13.
//  Copyright (c) 2013 Adam Zaninovich. All rights reserved.
//

#import "Brewery.h"

@implementation Brewery

+ (NSURLSessionDataTask *)loadBreweriesWithCompletion:( void(^)(NSArray *breweries) )completion {
  NSURLSessionDataTask *task = [[SDBHClient sharedClient] get:@"breweries" completion:^(NSArray *results, NSError *error) {
    NSMutableArray *breweries = [[NSMutableArray alloc] init];
    // fill in the array here
  }];
  return task;
}

@end
