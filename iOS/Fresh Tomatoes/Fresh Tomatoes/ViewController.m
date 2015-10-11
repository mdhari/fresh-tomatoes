//
//  ViewController.m
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/8/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import "ViewController.h"
#import "MovieDetailsViewController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"ViewController::viewDidLoad");
    
    self.dataSource = [[MovieDataSource alloc]init];
    
    // initialize the movie tables delegate and datasource
    self.movieTableView.delegate=self;
    self.movieTableView.dataSource=self.dataSource;
    
    
    [self populateMovies];
    
    // searchDisplayController was deprecated in iOS 8
    // used manual impl here
    // https://github.com/kharrison/CodeExamples/blob/master/WorldFacts/WorldFacts/UYLCountryTableViewController.m
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.movieTableView.tableHeaderView = self.searchController.searchBar;
    
    
    
    // The search bar does not seem to set its size automatically
    // which causes it to have zero height when there is no scope
    // bar. If you remove the scopeButtonTitles above and the
    // search bar is no longer visible make sure you force the
    // search bar to size itself (make sure you do this after
    // you add it to the view hierarchy).
    [self.searchController.searchBar sizeToFit];
    self.dataSource.searchController = self.searchController;

}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    [searchController.searchBar becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if(self.searchController.searchBar.text.length > 0){
        self.searchController.active=YES;
    }
    
}

- (void) populateMovies{
    NSLog(@"ViewController::populateMovies");
    
    [self.dataSource loadNewMovies:self.movieTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MovieDetailSegue"])
    {
        Movie *movie = (Movie*)sender;
        MovieDetailsViewController *viewController = [segue destinationViewController];
        viewController.movie = movie;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // lets piggyback on the sender argument to save ourselves the trouble of having another Movie reference
    if(self.searchController.active){
        
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"MovieDetailSegue" sender:self.dataSource.searchResults[indexPath.row]];
    }else{
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"MovieDetailSegue" sender:self.dataSource.movies[indexPath.row]];
    }
}

#pragma mark -
#pragma mark === UISearchResultsUpdating ===
#pragma mark -

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    [self.dataSource loadSearchResults:searchString];
}



@end
