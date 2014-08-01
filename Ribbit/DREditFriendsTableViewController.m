//
//  DREditFriendsTableViewController.m
//  Ribbit
//
//  Created by Dale Rivera on 7/22/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "DREditFriendsTableViewController.h"
#import <Parse/Parse.h>
#import "MSCellAccessory.h"
@interface DREditFriendsTableViewController ()

@end

@implementation DREditFriendsTableViewController

UIColor *color;

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }else {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];
    self.currentUser = [PFUser currentUser];
    color = [UIColor colorWithRed:0.553 green:0.439 blue:0.718 alpha:1.0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    if([self isFriend:user]){
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:color];
    }else {
        cell.accessoryView = nil;
       }
    cell.textLabel.text = user.username;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    if([self isFriend:user]) {
        cell.accessoryView = nil;
        
        for (PFUser *friend in self.friends) {
            if([friend.objectId isEqualToString:user.objectId]){
                [self.friends removeObject:friend];
                break;
            }
        }
        
        [friendsRelation removeObject:user];
    }else {
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:color];
        [self.friends addObject:user];
        [friendsRelation addObject:user];
    }
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error) {
            NSLog(@"Error:%@ %@", error, [error userInfo]);
        }
    }];

}
#pragma mark - Helper Methods

-(BOOL)isFriend:(PFUser *)user {
    for (PFUser *friend in self.friends) {
        if([friend.objectId isEqualToString:user.objectId]){
            return YES;
        }
    }
    return NO;
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
