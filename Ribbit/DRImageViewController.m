//
//  DRImageViewController.m
//  Ribbit
//
//  Created by Dale Rivera on 7/25/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "DRImageViewController.h"

@interface DRImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DRImageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
    NSString *senderName = [self.message objectForKey:@"senderName"];
    self.navigationItem.title = [NSString stringWithFormat:@"Sent from %@", senderName];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    
}

-(void) timeout {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
