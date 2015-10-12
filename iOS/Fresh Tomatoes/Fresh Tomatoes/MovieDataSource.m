//
//  MovieDatasource.m
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/10/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import "MovieDatasource.h"
#import "RottenTomatoesAPI.h"
#import "MovieTableViewCell.h"
#import "Movie.h"

@implementation MovieDataSource

/*
 * method for initializing the data source with a view from a 
 * UIViewController so that we can display the MBProgressHUD easily
 */
-(id)initWithView:(UIView*) view{
    self = [super init];
    if(self){
        // do any initializations
        self.view = view;
    }
    return self;
}

/*
 * method that will filter the movie array based on what the user typed
 * in the search bar and reloading the tableview with those results. Returns
 * the original movie array if the search text is blank
 */
-(void)loadSearchResults:(NSString*) searchTxt{
    if(searchTxt.length>0){
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"title contains[c] %@",
                                    searchTxt];
    
        self.searchResults = [self.movies filteredArrayUsingPredicate:resultPredicate];}
    else{
        self.searchResults = self.movies;
    }
    [self.tableView reloadData];
}

/*
 * method that simply kicks off task to API class, does not wait for return
 */
-(void) loadNewMovies:(UITableView *)tblView{
    NSLog(@"MovieDataSource::getMovies start");
    self.tableView = tblView;
    [RottenTomatoesAPI loadNewMoviesAndReturnToDataSource:self];
}

/*
 * method to dismiss the activity indicator spinner
 */
-(void)dismissHUD{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/*
 * method to set the results from the API as the new source of data and reload the tableview
 */
-(void)setNewMovies:(NSArray *)movies{
    self.movies = movies;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.searchController.active){
        return self.searchResults.count;
    }
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MovieItem";
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Movie *movie;
    if(self.searchController.active){ // check if user is searching something to return the right array
        movie = (Movie*)self.searchResults[indexPath.row];
    }
    else{
        movie = (Movie*)self.movies[indexPath.row];
    }
    
    cell.movieTitleLbl.text = movie.title;
    cell.movieRatingLbl.text = movie.rating;
    
    movie.imageView = cell.movieImageView;
    movie.imageView.image = movie.posterImg;
    
    return cell;
}




@end
