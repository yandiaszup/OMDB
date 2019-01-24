//
//  MovieDetailViewController.m
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 15/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "AppDelegate.h"
#import "Movie.h"

@interface MovieDetailViewController () <UIScrollViewDelegate>{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *movietitle;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *plot;
@property (weak, nonatomic) IBOutlet UILabel *genre;
@property (weak, nonatomic) IBOutlet UILabel *awards;
@property (weak, nonatomic) IBOutlet UILabel *production;
@property (weak, nonatomic) IBOutlet UILabel *director;

@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;


@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_movie test];
    [self draw];
    
    if (isFavorited){
        [self.favoriteButton setTitle:@"Delete from favorites" forState:UIControlStateNormal];
    }   else {
        [self.favoriteButton setTitle:@"Favorite" forState:UIControlStateNormal];
    }
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
}

-(void)favorite{
    isFavorited = true;
}

-(void)notFavorite{
    isFavorited = false;
}

- (IBAction)favorite:(id)sender {
    if (isFavorited){
        [self deleteMovie];
        [self notFavorite];
        [self.favoriteButton setTitle:@"Favorite" forState:UIControlStateNormal];
    } else {
        [self saveMovie];
        [self favorite];
        [self.favoriteButton setTitle:@"Delete from favorites" forState:UIControlStateNormal];
    }
}

-(void) deleteMovie{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Movies" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title like %@",self.movie.title];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [context deleteObject:managedObject];
    }
}

-(void) saveMovie{
    NSManagedObject *entityObj = [NSEntityDescription insertNewObjectForEntityForName:@"Movies" inManagedObjectContext:context];
    [self.movie storeAtributes:entityObj];
    [appDelegate saveContext];
}

-(void)draw{
    [self showMovieInformation];
    [self.favoriteButton.layer setCornerRadius:5];
    [self.favoriteButton.layer masksToBounds];
    [self.favoriteButton.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.favoriteButton.layer setShadowOpacity:0.5];
    [self.favoriteButton.layer setShadowRadius:5];
    [self BlurEfect];
    [self.topView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.topView.layer setShadowOpacity:0.5];
    [self.topView.layer setShadowRadius:5];
    [self drawRating];
    
}

-(void)drawRating{
    float rating = [self.movie.imdbRating floatValue];
    [self.star1 setHidden:false];
    [self.star2 setHidden:true];
    [self.star3 setHidden:true];
    [self.star4 setHidden:true];
    [self.star5 setHidden:true];
    if (rating > 2.0){
        [self.star2 setHidden:false];
    }
    if (rating > 4.0){
        [self.star3 setHidden:false];
    }
    if(rating >6.0){
        [self.star4 setHidden:false];
    }
    if(rating > 8.0){
        [self.star5 setHidden:false];
    }
}

-(void)showMovieInformation{
    NSData *imageData = [[NSData alloc] initWithData:self.movie.posterImage];
    self.background.image = [UIImage imageWithData:imageData];
    self.poster.image = [UIImage imageWithData:imageData];
    self.movietitle.text = self.movie.title;
    self.date.text = self.movie.released;
    self.timestamp.text = self.movie.runtime;
    self.plot.text = self.movie.plot;
    self.genre.text = self.movie.genre;
    self.awards.text = self.movie.awards;
    self.production.text = self.movie.production;
    self.director.text = self.movie.director;
}

-(void)BlurEfect{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.background.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.background addSubview:blurEffectView];;
}


@end
