//
//  MainViewController.h
//  Smart car MT
//
//  Created by Aleš Kubiček on 07.06.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "MainView.h"
#import "NVC_DisplayCmds.h"
#import "NVC_AddNewCmd.h"

@interface MainViewController : UIViewController <addCommand, MainViewControl, CBCentralManagerDelegate, CBPeripheralDelegate> {
    MainView *MainUI;
    NVC_DisplayCmds *displayVC;
    NVC_AddNewCmd *addVC;
    UINavigationController *sideNC;
    AVAudioPlayer *Siri_begin;
    CBUUID *serviceUUID;
    CBUUID *characteristicUUID;
    CBCharacteristic *HM10_characteristic;
    NSString *BluetoothDataString;
    NSString *switchableDataString;
    NSMutableArray *commands;
    NSMutableArray *BTkeys;
    NSMutableArray *responses;
}

@property (nonatomic, strong) CBCentralManager *iPad;
@property (nonatomic, strong) CBPeripheral *HM10_module;

- (void)updateAndSaveCommands:(NSMutableArray *)cmds BTKeys:(NSMutableArray *)Keys andResponses:(NSMutableArray *)resps;
- (NSArray *)loadCommands;
- (NSArray *)loadBTKeys;
- (NSArray *)loadResponses;

@end
