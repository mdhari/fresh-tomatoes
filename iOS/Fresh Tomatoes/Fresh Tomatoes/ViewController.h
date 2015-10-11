//
//  ViewController.h
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/8/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDataSource.h"

@interface ViewController : UIViewController <UISearchBarDelegate, UISearchResultsUpdating,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *movieTableView;

@property (strong,nonatomic) MovieDataSource *dataSource;
@property (strong, nonatomic) UISearchController *searchController;



@end

