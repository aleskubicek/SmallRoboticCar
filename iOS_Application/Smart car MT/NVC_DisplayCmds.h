//
//  NVC_DisplayCmds.h
//  Smart car MT
//
//  Created by Aleš Kubiček on 03.08.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVC_DisplayCmds : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *displayTableView;
    NSMutableArray *displayCommands;
    NSMutableArray *displayBTKeys;
    NSMutableArray *displayResponses;
}

- (void)reloadDisplayedCommands:(NSMutableArray *)cmds BTKeys:(NSMutableArray *)keys andResponses:(NSMutableArray *)resps;

@end
