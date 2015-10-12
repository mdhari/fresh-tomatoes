//
//  MovieDatasource.h
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/10/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface MovieDataSource : NSObject <UITableViewDataSource>

@property(strong,nonatomic) NSArray *movies;
@property(strong,nonatomic) NSArray *searchResults;
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) UISearchController *searchController;
@property(strong,nonatomic) UIView *view;

-(id)initWithView:(UIView*) view;
-(void)loadNewMovies:(UITableView*)tblView;
-(void)loadSearchResults:(NSString*) searchTxt;
-(void)setNewMovies:(NSArray *)movies;
-(void)dismissHUD;

@end


