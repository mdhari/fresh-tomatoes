//
//  RottenTomatoesAPI.h
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/8/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieDataSource.h"


@interface RottenTomatoesAPI : NSObject

+(void)loadNewMoviesAndReturnToDataSource:(MovieDataSource*)movieDataSource;
+(void)loadImages:(NSArray*)movies;

@end
