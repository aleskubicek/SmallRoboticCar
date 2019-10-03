//
//  NVC_AddNewCmd.m
//  Smart car MT
//
//  Created by Aleš Kubiček on 03.08.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import "NVC_AddNewCmd.h"

@interface NVC_AddNewCmd ()

@end

@implementation NVC_AddNewCmd

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New item";
    addTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    addTableView.delegate = self;
    addTableView.dataSource = self;
    addTableView.delaysContentTouches = NO;
    [self.view addSubview:addTableView];
    
    commandCell = [[UITableViewCell alloc] init];
    commandCell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    commandTField = [[UITextField alloc] initWithFrame:CGRectInset(commandCell.contentView.bounds, 15.0, 0.0)];
    commandTField.placeholder = @"Voice command";
    [commandCell addSubview:commandTField];
    
    BTKeyCell = [[UITableViewCell alloc] init];
    BTKeyCell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    BTKeyTField = [[UITextField alloc] initWithFrame:CGRectInset(BTKeyCell.contentView.bounds, 15.0, 0.0)];
    BTKeyTField.placeholder = @"Bluetooth key";
    [BTKeyCell addSubview:BTKeyTField];
    
    responseCell = [[UITableViewCell alloc] init];
    responseCell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    responseTField = [[UITextField alloc] initWithFrame:CGRectInset(responseCell.contentView.bounds, 15.0, 0.0)];
    responseTField.placeholder = @"Response";
    [responseCell addSubview:responseTField];
    
    buttonCell = [[UITableViewCell  alloc] init];
    saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(0.0, 0.0, self.navigationController.view.frame.size.width, buttonCell.frame.size.height);
    saveButton.tintColor = [UIColor whiteColor];
    [saveButton setTitle:@"Save command" forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed:77.0/255.0 green:196.0/255.0 blue:111.0/255.0 alpha:1.0];
    [saveButton addTarget:self action:@selector(saveCommand:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton addTarget:self action:@selector(highlightSaveButton:) forControlEvents:UIControlEventTouchDown];
    [buttonCell addSubview:saveButton];
    
    alert = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 330.0, self.navigationController.view.frame.size.width, 30.0)];
    alert.font = [UIFont systemFontOfSize:13.0];
    alert.tintColor = [UIColor redColor];
    alert.textAlignment = NSTextAlignmentCenter;
    [addTableView addSubview:alert];
}

//Custom mehtods
- (void)saveCommand:(id)sender {
    saveButton.backgroundColor = [UIColor colorWithRed:77.0/255.0 green:196.0/255.0 blue:111.0/255.0 alpha:1.0];
    if ([commandTField.text isEqual:@""] || [BTKeyTField.text isEqual:@""] || [responseTField.text isEqual:@""]) {
        [self displayLabelAlertWithText:@"Empty field/s"];
    } else {
        [self displayLabelAlertWithText:@""];
        [self.delegate addNewCommand:commandTField.text withBTKey:BTKeyTField.text andResponse:responseTField.text];
        commandTField.text = @"";
        BTKeyTField.text = @"";
        responseTField.text = @"";
    }
}

- (void)highlightSaveButton:(id)sender {
    saveButton.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:183.0/255.0 blue:111.0/255.0 alpha:1.0];
}

- (void)displayLabelAlertWithText:(NSString *)alertText {
    alert.text = alertText;
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    shake.duration = 0.1;
    shake.repeatCount = 2;
    shake.autoreverses = YES;
    shake.fromValue = [NSValue valueWithCGPoint: CGPointMake(alert.center.x - 5, alert.center.y)];
    shake.toValue = [NSValue valueWithCGPoint: CGPointMake(alert.center.x + 5, alert.center.y)];
    [alert.layer addAnimation:shake forKey:@"position"];
}
//__________________________________________________________

//TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 1;
        case 2:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: return commandCell;
                case 1: return BTKeyCell;
            }
        case 1:
            switch (indexPath.row) {
                case 0: return responseCell;
            }
        case 2:
            switch (indexPath.row) {
                case 0: return buttonCell;
            }
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0: return @"Command";
        case 1: return @"Response after completion";
    }
    return nil;
}

//__________________________________________________________

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
