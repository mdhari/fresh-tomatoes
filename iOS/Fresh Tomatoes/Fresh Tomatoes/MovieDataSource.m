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


-(void) loadNewMovies:(UITableView *)tblView{
    NSLog(@"MovieDataSource::getMovies start");
    self.tableView = tblView;
    [RottenTomatoesAPI loadNewMoviesAndReturnToDataSource:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

-(void)setNewMovies:(NSArray *)movies{
    self.movies = movies;
    [self.tableView reloadData];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MovieItem";
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Movie *movie = (Movie*)self.movies[indexPath.row];
    
    cell.movieTitleLbl.text = movie.title;
    cell.movieRatingLbl.text = movie.rating;
    
    return cell;
}

@end
