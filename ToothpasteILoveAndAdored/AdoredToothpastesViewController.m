//
//  ViewController.m
//  ToothpasteILoveAndAdored
//
//  Created by Eduardo Alvarado Díaz on 10/16/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import "AdoredToothpastesViewController.h"
#import "ToothpastesTableViewController.h"

@interface AdoredToothpastesViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *adoredToothpastes;
@property (strong, nonatomic) IBOutlet UITableView *adorabeTableView;
@end

@implementation AdoredToothpastesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];
    if (self.adoredToothpastes == nil) {
        self.adoredToothpastes = [[NSMutableArray alloc]init];
    } 
}

-(IBAction)unwindFromToothpastesViewController:(UIStoryboardSegue*)segue{
    ToothpastesTableViewController *viewController = segue.sourceViewController;
    [self.adoredToothpastes addObject:[viewController adoredToothpaste]];
    [self.adorabeTableView reloadData];
    [self save];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adoredToothpastes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];

    cell.textLabel.text = [self.adoredToothpastes objectAtIndex:indexPath.row];

    return cell;
}

-(NSURL *)documentsDicrectory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    return files.firstObject;
}

-(void)load{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *pList = [[self documentsDicrectory] URLByAppendingPathComponent:@"pastes.plist"];
    self.adoredToothpastes = [NSMutableArray arrayWithContentsOfURL:pList];
    NSLog(@"date: %@",[userDefaults objectForKey:@"LastSaved"]);
}

-(void)save{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *pList = [[self documentsDicrectory] URLByAppendingPathComponent:@"pastes.plist"];
    [self.adoredToothpastes writeToURL:pList atomically:YES];

    [userDefaults setObject:[NSDate date] forKey:@"LastSaved"];
    [userDefaults synchronize];
}


@end
