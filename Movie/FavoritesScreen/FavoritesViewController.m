//
//  FavoritesViewController.m
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 17/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import "FavoritesViewController.h"
#import "AppDelegate.h"
#import "MinPosterCollectionViewCell.h"
#import "Movie.h"
#import "MovieDetailViewController.h"
#import "StoredFavoritesController.h"

@interface FavoritesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}
@property (weak, nonatomic) IBOutlet UIView *topHeader;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (strong, nonatomic) NSArray *movie;
@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self draw];
    self.movie = [[NSArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    NSArray *results = [[StoredFavoritesController instance] favoriteMovies];
    self.movie = [[NSArray alloc]initWithArray:results];
    [self.collectionview reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MinPosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"minPoster" forIndexPath:indexPath];
    if ([self.movie count] > 0){
        NSData *imageData = [self.movie[indexPath.row] valueForKey:@"posterImage"];
        cell.posterImage.image = [UIImage imageWithData:imageData];
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard * storyboard = self.storyboard;
    MovieDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MovieDetail"];
    vc.movie = [[Movie alloc] initWithEntity:self.movie[indexPath.row]];
    [vc favorite];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movie.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)draw{
    self.collectionview.contentInset = UIEdgeInsetsMake(self.topHeader.frame.size.height + 10, 0, 0, 0);
    [self.topHeader.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.topHeader.layer setShadowOpacity:0.5];
    [self.topHeader.layer setShadowRadius:5];
    
    [self BlurEfect];
    
}

-(void)BlurEfect{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.topHeader.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.topHeader addSubview:blurEffectView];;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
