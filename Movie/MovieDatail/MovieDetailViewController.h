//
//  MovieDetailViewController.h
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 15/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailViewController : UIViewController{
    Boolean isFavorited;
}
@property (strong,nonatomic) Movie *movie;
-(void)favorite;
-(void)notFavorite;
@end

NS_ASSUME_NONNULL_END
