//
//  DRSignUpViewController.m
//  Ribbit
//
//  Created by Dale Rivera on 7/22/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "DRSignUpViewController.h"
#import <Parse/Parse.h>
@interface DRSignUpViewController () 
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
- (IBAction)signUp:(id)sender;
- (IBAction)dismiss:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end

@implementation DRSignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (IBAction)signUp:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(username.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you type a username" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }else if(password.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you type a password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }else if(email.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you type an email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }else {
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        user.email = email;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
