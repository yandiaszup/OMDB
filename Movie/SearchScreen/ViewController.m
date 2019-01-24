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
#import "Reachability.h"
#import "AFNetworking.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    int page;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) Movie *movie;
@property (strong, nonatomic) NSMutableArray *movieList;
@property (strong, nonatomic) NSMutableArray *movieIDList;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *acivityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    [self.acivityIndicator.layer setHidden:(YES)];
    [self.acivityIndicator startAnimating];
}

-(NSString*) buildURL: (NSString *) title {
    page += 1;
    NSString *newTitle = [title stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *apiKey = [NSString stringWithFormat:@"&apikey=56c108cd"];
    NSString *finalURL = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&page=%d%@",newTitle,page,apiKey];
    return finalURL;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.view setUserInteractionEnabled:(YES)];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    page = 0;
    self.movieList = [[NSMutableArray alloc] init];
    self.movieIDList = [[NSMutableArray alloc] init];
    [self.acivityIndicator.layer setHidden:(NO)];
    [self SearchMovies:self.searchBar.text];
    [self SearchMovies:self.searchBar.text];
    [self.view endEditing:TRUE];
}

-(void)SearchMovies: (NSString*) title{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlstring = [self buildURL:title];
    NSURL *URL = [NSURL URLWithString:urlstring];
    
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        for (NSDictionary *movieDict in responseObject[@"Search"]){
            NSLog(@"%@",movieDict);
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:URL];
            [self.movieList addObject:[movieDict valueForKey:@"imdbID"]];
            [self.movieIDList addObject:[movieDict valueForKey:@"Poster"]];
        }
        [self.collectionView reloadData];
        [self.acivityIndicator.layer setHidden:(YES)];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
        UIStoryboard * storyboard = self.storyboard;
        ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PopUp"];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MinPosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"minPoster" forIndexPath:indexPath];
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]!=NotReachable)
    {
        NSString *moviePosterUrl = _movieIDList[indexPath.row];
        NSURL *posterUrl = [NSURL URLWithString:moviePosterUrl];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:posterUrl];
        cell.posterImage.image = [UIImage imageWithData:imageData];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view setUserInteractionEnabled:(NO)];
    UIStoryboard * storyboard = self.storyboard;
    MovieDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MovieDetail"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *stringURL = [NSString stringWithFormat:@"https://www.omdbapi.com/?i=%@&apikey=56c108cd", self.movieList[indexPath.row]];
    NSURL *URL = [NSURL URLWithString: stringURL];
    
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        Movie *moviee = [[Movie alloc] initWithDictionary:responseObject];
        vc.movie = moviee;
        NSArray *results = [[StoredFavoritesController instance] favoriteMovies];
        NSArray *results1 = [[NSArray alloc] initWithArray:[results valueForKey:@"title"]];
        if([results1 containsObject:vc.movie.title]){
            [vc favorite];
        } else {
            [vc notFavorite];
        }
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        UIStoryboard * storyboard = self.storyboard;
        ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PopUp"];
        [self presentViewController:vc animated:YES completion:nil];
    }];
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
        [self SearchMovies:self.searchBar.text];
    }
}


@end
