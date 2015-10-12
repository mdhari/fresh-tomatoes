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
    
    self.hud = [MBProgressHUD HUDForView:self.view];
    self.dataSource = [[MovieDataSource alloc] initWithView:self.view];
    
    // initialize the movie tables delegate and datasource
    self.movieTableView.delegate=self;
    self.movieTableView.dataSource=self.dataSource;
    
    // searchDisplayController was deprecated in iOS 8
    // used manual impl here
    // https://github.com/kharrison/CodeExamples/blob/master/WorldFacts/WorldFacts/UYLCountryTableViewController.m
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.movieTableView.tableHeaderView = self.searchController.searchBar;
    
    [self.searchController.searchBar sizeToFit];
    self.dataSource.searchController = self.searchController;
    
    // start the network calls
    [self populateMovies];

}

/*
 * present the keyboard
 */
- (void)didPresentSearchController:(UISearchController *)searchController
{
    [searchController.searchBar becomeFirstResponder];
}

/*
 * make sure when we return from movie details page that if there is valid search, then
 * force the searchbar to be active
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if(self.searchController.searchBar.text.length > 0){
        self.searchController.active=YES;
    }
    
}

/*
 * method to start network calls for data. Will show the spinner to indicate activity.
 */
- (void) populateMovies{
    NSLog(@"ViewController::populateMovies");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.dataSource loadNewMovies:self.movieTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * make sure to pass along the movie that we want details for
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MovieDetailSegue"])
    {
        Movie *movie = (Movie*)sender;
        MovieDetailsViewController *viewController = [segue destinationViewController];
        viewController.movie = movie;
        
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // lets piggyback on the sender argument to save ourselves the trouble of having another Movie reference
    if(self.searchController.active){ // we need to pop searchController off the view stack before proceeding
                                      // make sure we are using what the user actually picked from either search or normal pick
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"MovieDetailSegue" sender:self.dataSource.searchResults[indexPath.row]];
    }else{
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"MovieDetailSegue" sender:self.dataSource.movies[indexPath.row]];
    }
}

#pragma mark -
#pragma mark UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    [self.dataSource loadSearchResults:searchString];
}

/*
 * Restart data pull, should not be queued multiple times because of activity spinner blocking it
 */
- (IBAction)refreshBtnPressed:(id)sender {
    self.searchController.searchBar.text = @"";
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    [self populateMovies];
}
@end
