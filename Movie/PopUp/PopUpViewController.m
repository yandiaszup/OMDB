//
//  PopUpViewController.m
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 22/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import "PopUpViewController.h"
@interface PopUpViewController ()

@property (weak, nonatomic) IBOutlet UIView *PopUpView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation PopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.PopUpView.layer setCornerRadius:3];
    [self.PopUpView.layer setBorderWidth:1];
    [self.PopUpView.layer setBorderColor: [UIColor orangeColor].CGColor];
    [self.button.layer setCornerRadius:3];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.PopUpView.layer setShadowRadius:5.0];
    [self.PopUpView.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.PopUpView.layer setShadowOpacity:0.5];
}
- (IBAction)button:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
