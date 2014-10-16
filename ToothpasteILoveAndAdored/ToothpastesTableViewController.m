//
//  ToothpastesTableViewController.m
//  ToothpasteILoveAndAdored
//
//  Created by Eduardo Alvarado Díaz on 10/16/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import "ToothpastesTableViewController.h"

@interface ToothpastesTableViewController ()
@property NSArray *toothpastes;

@end

@implementation ToothpastesTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://methylblue.com/MM/toothpastes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.toothpastes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.tableView reloadData];
    }];
}

-(NSString *)adoredToothpaste{
    NSInteger row = self.tableView.indexPathForSelectedRow.row;
    return [self.toothpastes objectAtIndex:row];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.toothpastes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [self.toothpastes objectAtIndex:indexPath.row];
    return cell;
}

@end
