//
//  Movie.h
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/10/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *imageUrl;
@property(strong,nonatomic) NSString *rating;
@property(strong,nonatomic) NSString *desc;

@end
