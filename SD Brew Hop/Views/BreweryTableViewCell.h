//
//  BreweryTableViewCell.h
//  SD Brew Hop
//
//  Created by Goldman, Caitlin on 11/21/13.
//  Copyright (c) 2013 Adam Zaninovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreweryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *cityState;



@end
