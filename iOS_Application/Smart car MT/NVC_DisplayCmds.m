//
//  NVC_DisplayCmds.m
//  Smart car MT
//
//  Created by Aleš Kubiček on 03.08.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import "NVC_DisplayCmds.h"
#import "MainViewController.h"

@interface NVC_DisplayCmds () {
    MainViewController *mainVC;
}

@end

@implementation NVC_DisplayCmds

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Commands";
    
    displayTableView = [[UITableView alloc] initWithFrame:self.navigationController.view.bounds style:UITableViewStylePlain];
    displayTableView.delegate = self;
    displayTableView.dataSource = self;
    displayTableView.allowsMultipleSelectionDuringEditing = NO;
    displayTableView.allowsSelection = NO;
    displayTableView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:244.0/255.0 alpha:1.0];
    [self.view addSubview:displayTableView];
    
    mainVC = [[MainViewController alloc] init];
    displayCommands = [[NSMutableArray alloc] initWithArray:mainVC.loadCommands];
    displayBTKeys = [[NSMutableArray alloc] initWithArray:mainVC.loadBTKeys];
    displayResponses = [[NSMutableArray alloc] initWithArray:mainVC.loadResponses];
}

- (void)reloadDisplayedCommands:(NSMutableArray *)cmds BTKeys:(NSMutableArray *)keys andResponses:(NSMutableArray *)resps {
    displayCommands = cmds;
    displayBTKeys = keys;
    displayResponses = resps;
    [displayTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return displayCommands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:244.0/255.0 alpha:1.0];
    
    UIImageView *commandIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 12.0, 20.0)];
    commandIcon.image = [UIImage imageNamed:@"SPIcons_mic.png"];
    [cell addSubview:commandIcon];
    
    UILabel *commandLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 10.0, self.view.frame.size.width-40.0, 20.0)];
    commandLabel.font = [UIFont systemFontOfSize:13.0 weight:1.5];
    commandLabel.text = [displayCommands objectAtIndex:indexPath.row];
    [cell addSubview:commandLabel];
    
    UIImageView *BTKeyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 35.0, 11.0, 20.0)];
    BTKeyIcon.image = [UIImage imageNamed:@"SPIcons_bluetooth.png"];
    [cell addSubview:BTKeyIcon];
    
    UILabel *BTKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 35.0, self.view.frame.size.width-40.0, 20.0)];
    BTKeyLabel.font = [UIFont systemFontOfSize:13.0];
    BTKeyLabel.text = [displayBTKeys objectAtIndex:indexPath.row];
    [cell addSubview:BTKeyLabel];
    
    UIImageView *ResponseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 60.0, 22.0, 20.0)];
    ResponseIcon.image = [UIImage imageNamed:@"SPIcons_speaker.png"];
    [cell addSubview:ResponseIcon];
    
    UILabel *ResponseLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 60.0, self.view.frame.size.width-40.0, 20.0)];
    ResponseLabel.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:13.0];
    ResponseLabel.text = [displayResponses objectAtIndex:indexPath.row];
    [cell addSubview:ResponseLabel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [displayCommands removeObjectAtIndex:indexPath.row];
        [displayBTKeys removeObjectAtIndex:indexPath.row];
        [displayResponses removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [mainVC updateAndSaveCommands:displayCommands BTKeys:displayBTKeys andResponses:displayResponses];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
