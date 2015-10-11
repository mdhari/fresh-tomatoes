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
    [self performSegueWithIdentifier:@"MovieDetailSegue" sender:self.dataSource.movies[indexPath.row]];
}



@end
