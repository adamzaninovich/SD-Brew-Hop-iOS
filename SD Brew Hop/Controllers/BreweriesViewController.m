//
//  BreweriesViewController.m
//  SD Brew Hop
//
//  Created by Goldman, Caitlin on 11/21/13.
//  Copyright (c) 2013 Adam Zaninovich. All rights reserved.
//

#import "BreweriesViewController.h"
#import "Brewery.h"
#import "BreweryTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "BreweryDetailsViewController.h"

@interface BreweriesViewController ()
@property (strong, nonatomic) NSArray *breweries;
@end

@implementation BreweriesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [Brewery loadBreweriesWithCompletion:^(NSArray *breweries) {
        if (breweries) {
            self.breweries = breweries;
            [self.tableView reloadData];
        } else {
            NSLog(@"Something went wrong");
        }
    }];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.breweries.count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"breweryTableCell";
    BreweryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Brewery *brewery = [self.breweries objectAtIndex:indexPath.row];
    
    cell.name.text = brewery.name;
    cell.image.image = nil;
    [cell.image cancelImageRequestOperation];
    
    NSURL *imageURL = [NSURL URLWithString:brewery.image];
    if (imageURL) {
        [cell.image setImageWithURL:imageURL];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowBreweryDetails"]) {
        BreweryDetailsViewController *detailViewContoller = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Brewery *brewery = [self.breweries objectAtIndex:indexPath.row];
        detailViewContoller.brewery = brewery;
    }
}


#pragma mark - Refresh Control

- (void)refresh {
    //  NSURLSessionDataTask *task =
    [Brewery loadBreweriesWithCompletion:^(NSArray *breweries) {
        if (breweries) {
            self.breweries = breweries;
            [self.tableView reloadData];
        } else {
            NSLog(@"Something went wrong");
        }
        [self.refreshControl endRefreshing];
    }];
}

@end