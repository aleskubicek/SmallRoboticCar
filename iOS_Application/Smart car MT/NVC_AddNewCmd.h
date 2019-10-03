//
//  NVC_AddNewCmd.h
//  Smart car MT
//
//  Created by Aleš Kubiček on 03.08.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addCommand <NSObject>

- (void)addNewCommand:(NSString *)cmd withBTKey:(NSString *)BTKey andResponse:(NSString *)response;

@end

@interface NVC_AddNewCmd : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *addTableView;
    UITableViewCell *commandCell;
    UITableViewCell *BTKeyCell;
    UITableViewCell *responseCell;
    UITableViewCell *buttonCell;
    UITextField *commandTField;
    UITextField *BTKeyTField;
    UITextField *responseTField;
    UIButton *saveButton;
    UILabel *alert;
}

@property (nonatomic, assign) id <addCommand> delegate;

- (void)displayLabelAlertWithText:(NSString *)alertText;

@end
