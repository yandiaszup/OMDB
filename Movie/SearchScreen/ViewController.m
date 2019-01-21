//
//  ViewController.m
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 14/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "SearchMovieRequest.h"
#import "MovieDetailViewController.h"
#import "MinPosterCollectionViewCell.h"
#import "StoredFavoritesController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) Movie *movie;
@property (strong, nonatomic) NSMutableArray *movieList;
@property (strong, nonatomic) NSMutableArray *movieIDList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieList = [[NSMutableArray alloc] init];
    self.movieIDList = [[NSMutableArray alloc] init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *urlstring = self.searchBar.text;
    [[SearchMovieRequest instance] setData];
    self.movieList = [[SearchMovieRequest instance] searchMovie:urlstring];
    self.movieIDList = [[SearchMovieRequest instance] searchPosterURL:urlstring];
    if([self.movieList count] > 0 && [self.movieIDList count] > 0){
        [self.collectionView reloadData];
        [self.view endEditing:true];
    }
    else {
        NSLog(@"POPUP FAILED");
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MinPosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"minPoster" forIndexPath:indexPath];
    
    NSString *moviePosterUrl = _movieIDList[indexPath.row];
    NSURL *posterUrl = [NSURL URLWithString:moviePosterUrl];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:posterUrl];
    if (imageData != nil){
        cell.posterImage.image = [UIImage imageWithData:imageData];
    } else {
        
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard * storyboard = self.storyboard;
    MovieDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MovieDetail"];
    vc.movie = [[SearchMovieRequest instance] searchMovieByID:_movieList[indexPath.row]];
    
    NSArray *results = [[StoredFavoritesController instance] favoriteMovies];
    NSArray *results1 = [[NSArray alloc] initWithArray:[results valueForKey:@"title"]];
    
    if([results1 containsObject:vc.movie.title]){
        [vc favorite];
    } else {
        [vc notFavorite];
    }    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.movieList count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    if(offsetY > contentHeight - scrollView.frame.size.height){
        [self loadMoreCells];
    }
}

-(void)loadMoreCells{
    NSString *urlstring = self.searchBar.text;
    NSMutableArray *nextMovies = [[SearchMovieRequest instance] searchMovie:urlstring];
    NSMutableArray *nextmoviesposter= [[SearchMovieRequest instance] searchPosterURL:urlstring];
    [self.movieList addObjectsFromArray:nextMovies];
    [self.movieIDList addObjectsFromArray:nextmoviesposter];
    [self.collectionView reloadData];
}


@end
