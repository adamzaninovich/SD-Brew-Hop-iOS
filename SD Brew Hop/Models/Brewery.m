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
      if (results) {
          for (NSDictionary *result in results) {
              Brewery *brewery = [[Brewery alloc] initWithDictionary:result];
              [breweries addObject:brewery];
          }
      } else {
          NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                @"http://beerpulse.com/wp-content/uploads/2012/09/BallastPointArt-2.jpg" , @"image",
                @"Ballast Point" , @"name",
                nil];
          Brewery *brewery = [[Brewery alloc] initWithDictionary:dict];
          [breweries addObject:brewery];
      }
      completion(breweries);
  }];
  return task;
}

- (id)initWithDictionary:(NSDictionary *)attributes{
    self.name = attributes[@"name"];
    self.image = attributes[@"image"];
    self.endpoint = attributes[@"endpoint"];
    return self;
}


@end
