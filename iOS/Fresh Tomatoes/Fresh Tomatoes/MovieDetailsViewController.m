//
//  MovieDetailsViewController.m
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/10/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.movieImageView;
    self.movieTitleLbl.text = self.movie.title;
    self.movieRatingLbl.text = self.movie.rating;
    self.descriptionTxtView.text = self.movie.desc;
    self.descriptionTxtView.scrollEnabled = NO;
    self.descriptionTxtView.textContainer.maximumNumberOfLines = 0;
    self.descriptionTxtView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 * User pressed back button on modal, just dismiss it.
 */
- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
