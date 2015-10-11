//
//  MovieDetailsViewController.h
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/10/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *movieImageView;
@property (strong, nonatomic) IBOutlet UILabel *movieTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *movieRatingLbl;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTxtView;
@property (strong, nonatomic) Movie *movie;


- (IBAction)backBtnPressed:(id)sender;

@end
