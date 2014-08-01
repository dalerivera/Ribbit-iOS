//
//  DRLoginViewController.m
//  Ribbit
//
//  Created by Dale Rivera on 7/22/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "DRLoginViewController.h"
#import <Parse/Parse.h>
@interface DRLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation DRLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if([UIScreen mainScreen].bounds.size.height == 568) {
//        self.backgroundImageView.image = [UIImage imageNamed:@"loginBackground-568h"];
//    }
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(username.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you type a username" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }else if(password.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you type a password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }else {
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }

        }];
    }
}


@end
