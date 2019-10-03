//
//  MainViewController.m
//  Smart car MT
//
//  Created by Aleš Kubiček on 07.06.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)loadView {
    [super loadView];
    //UI init
    MainUI = [[MainView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:MainUI];
    MainUI.delegate = self;
    MainUI.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:210.0/255.0 blue:221.0/255.0 alpha:1.0];
    //__________________________________________________________
    
    //NVC init
    displayVC = [[NVC_DisplayCmds alloc] init];
    addVC = [[NVC_AddNewCmd alloc] init];
    addVC.delegate = self;
    sideNC = [[UINavigationController alloc] initWithRootViewController:displayVC];
    sideNC.view.frame = CGRectMake(769.0, 137.0, 263.0, 856.0);
    sideNC.navigationBar.translucent = NO;
    sideNC.navigationBar.barTintColor = [UIColor colorWithRed:203.0/255.0 green:38.0/255.0 blue:47.0/255.0 alpha:1.0];
    sideNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    sideNC.navigationBar.tintColor = [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1.0];
    [self.view addSubview:sideNC.view];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addNewVoiceCommand:)];
    displayVC.navigationItem.rightBarButtonItem = addButton;
    displayVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    displayVC.navigationItem.backBarButtonItem.title = @"Back";
    //__________________________________________________________
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Bluetooth init
    self.iPad = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    serviceUUID = [CBUUID UUIDWithString:@"FFE0"];
    characteristicUUID = [CBUUID UUIDWithString:@"FFE1"];
    //__________________________________________________________
    
    //Sound init
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"siri_sound01" withExtension:@"mp3"];
    Siri_begin = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    //__________________________________________________________
    
    //VoiceControll init
    commands = [[NSMutableArray alloc] initWithArray:self.loadCommands];
    BTkeys = [[NSMutableArray alloc] initWithArray:self.loadBTKeys];
    responses = [[NSMutableArray alloc] initWithArray:self.loadResponses];
    //__________________________________________________________
}

//Bluetooth
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            break;
            
        case CBCentralManagerStatePoweredOn:
            [MainUI ChangeBluetoothState:@"Scanning" withLogoColor:[UIColor colorWithRed:255.0/255.0 green:96.0/255.0 blue:0.0/255.0 alpha:1.0]];
            [self scanForPeripherals];
            break;
            
        case CBCentralManagerStateResetting:
            [MainUI ChangeBluetoothState:@"Resetting" withLogoColor:[UIColor colorWithRed:255.0/255.0 green:96.0/255.0 blue:0.0/255.0 alpha:1.0]];
            break;
            
        case CBCentralManagerStateUnauthorized:
            [MainUI ChangeBluetoothState:@"Unauthorized" withLogoColor:[UIColor colorWithRed:255.0/255.0 green:96.0/255.0 blue:0.0/255.0 alpha:1.0]];
            break;
            
        case CBCentralManagerStateUnknown:
            [MainUI ChangeBluetoothState:@"Unknown state" withLogoColor:[UIColor colorWithRed:255.0/255.0 green:96.0/255.0 blue:0.0/255.0 alpha:1.0]];
            break;
            
        case CBCentralManagerStateUnsupported:
            [MainUI ChangeBluetoothState:@"Unsupported state" withLogoColor:[UIColor colorWithRed:255.0/255.0 green:96.0/255.0 blue:0.0/255.0 alpha:1.0]];
            break;
            
        default:
            break;
    }
}

- (void)scanForPeripherals {
    [self.iPad scanForPeripheralsWithServices:[NSArray arrayWithObject:serviceUUID] options:nil];
}

- (void)centralManager:(CBCentralManager *)central
        didDiscoverPeripheral:(CBPeripheral *)peripheral
        advertisementData:(NSDictionary *)advertisementData
        RSSI:(NSNumber *)RSSI {
    [self.iPad connectPeripheral:peripheral options:nil];
    self.HM10_module = peripheral;
}

- (void)centralManager:(CBCentralManager *)central
        didDisconnectPeripheral:(CBPeripheral *)peripheral
        error:(NSError *)error {
    if (self.HM10_module != peripheral) {
        self.HM10_module = peripheral;
        [self.iPad connectPeripheral:peripheral options:nil];
    }
    [self scanForPeripherals];
}

- (void)centralManager:(CBCentralManager *)central
        didFailToConnectPeripheral:(CBPeripheral *)peripheral
        error:(NSError *)error {
    [MainUI ChangeBluetoothState:@"Connection failed" withLogoColor:[UIColor colorWithRed:146.0/255.0 green:0.0/255.0 blue:8.0/255.0 alpha:1.0]];
    [self scanForPeripherals];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [MainUI ChangeBluetoothState:[NSString stringWithFormat:@"Connected to%@", peripheral.name] withLogoColor:[UIColor colorWithRed:230.0/255.0 green:182.0/255.0 blue:78.0/255.0 alpha:1.0]];
    [self.iPad stopScan];
    peripheral.delegate = self;
    [peripheral discoverServices:[NSArray arrayWithObject:serviceUUID]];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error)
        return;
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:[NSArray arrayWithObject:characteristicUUID] forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error)
        return;
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:characteristicUUID]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            HM10_characteristic = characteristic;
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    BluetoothDataString = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    if ([BluetoothDataString length] > 1) {
        switchableDataString = [BluetoothDataString substringToIndex:2];
    } else {
        return;
    }
    
    if ([[switchableDataString uppercaseString] isEqual:@"LS"]) {
        @try {
            [MainUI LightSensor:[[NSString stringWithFormat:@"%c", [BluetoothDataString characterAtIndex:2]] intValue] setSensorState:[[NSString stringWithFormat:@"%c", [BluetoothDataString characterAtIndex:3]] intValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"LS exception: %@", exception.reason);
            return;
        }
    } else if ([[switchableDataString uppercaseString] isEqual:@"US"]) {
        @try {
            [MainUI UltrasonicSensorDistance:[[BluetoothDataString substringFromIndex:2] intValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"US exception: %@", exception.reason);
            return;
        }
    
    } else if ([[switchableDataString uppercaseString] isEqual:@"FS"]) {
        @try {
            [MainUI FollowSensor:[[NSString stringWithFormat:@"%c", [BluetoothDataString characterAtIndex:2]] intValue] setSensorState:[[NSString stringWithFormat:@"%c", [BluetoothDataString characterAtIndex:3]] intValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"FS exception: %@", exception.reason);
            return;
        }
    } else if ([[switchableDataString uppercaseString] isEqual:@"TS"]) {
        @try {
            [MainUI TemperatureSensorSetValue:[[BluetoothDataString substringFromIndex:2] intValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"TS exception: %@", exception.reason);
            return;
        }
    } else if ([[switchableDataString uppercaseString] isEqual:@"HS"]) {
        @try {
            [MainUI HumiditySensorSetValue:[[BluetoothDataString substringFromIndex:2] intValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"HS exception: %@", exception.reason);
            return;
        }
    } else if ([[switchableDataString uppercaseString] isEqual:@"DM"]) {
        @try {
            [MainUI CarDirectionMoving:[[BluetoothDataString substringFromIndex:2] intValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"DM exception: %@", exception.reason);
            return;
        }
    }
}

//__________________________________________________________


//Methods - delegate MainView => control UI
- (void)toggleSideNC {
    if (sideNC.view.frame.origin.x > 768.0) {
        [self showSideNC];
    } else {
        [self hideSideNC];
    }
}

- (void)VoiceControl_activate {
    [Siri_begin play];
}

- (void)CSliderValueChanged {
    [self WriteToBluetooth:[NSString stringWithFormat:@"%i", (int)MainUI.Configuration_slider.value]];
}

- (void)LeftButtonPressedDown {
    [self WriteToBluetooth:@"L1"];
}

- (void)LeftButtonReleased {
    [self WriteToBluetooth:@"L2"];
}

- (void)RightButtonPressedDown {
    [self WriteToBluetooth:@"R1"];
}

- (void)RightButtonReleased {
    [self WriteToBluetooth:@"R2"];
}

- (void)UpButtonPressedDown {
    [self WriteToBluetooth:@"U1"];
}

- (void)UpButtonReleased {
    [self WriteToBluetooth:@"U2"];
}

- (void)DwButtonPressedDown {
    [self WriteToBluetooth:@"D1"];
}

- (void)DwButtonReleased {
    [self WriteToBluetooth:@"D2"];
}
//__________________________________________________________

//Custom methods
- (void)WriteToBluetooth:(NSString *)str {
    [self.HM10_module writeValue:[str dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:HM10_characteristic type:CBCharacteristicWriteWithoutResponse];
}

- (void)updateAndSaveCommands:(NSMutableArray *)cmds BTKeys:(NSMutableArray *)Keys andResponses:(NSMutableArray *)resps {
    commands = cmds;
    BTkeys = Keys;
    responses = resps;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cmds forKey:@"commandsArray"];
    [userDefaults setObject:BTkeys forKey:@"BTKeysArray"];
    [userDefaults setObject:resps forKey:@"responsesArray"];
    [userDefaults synchronize];
}

- (NSArray *)loadCommands {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"commandsArray"];
}

- (NSArray *)loadBTKeys {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"BTKeysArray"];
}

- (NSArray *)loadResponses {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"responsesArray"];
}
//__________________________________________________________

//Side Panel with voice control commands
- (void)addNewVoiceCommand:(id)sender {
    [sideNC pushViewController:addVC animated:YES];
}

- (void)addNewCommand:(NSString *)cmd withBTKey:(NSString *)BTKey andResponse:(NSString *)response {
    for (int i = 0; i < commands.count; i++) {
        if ([cmd isEqual:[commands objectAtIndex:i]] || [BTKey isEqual:[BTkeys objectAtIndex:i]]) {
            [addVC displayLabelAlertWithText:@"Duplicated command or BTKey"];
            return;
        }
    }
    [commands addObject:cmd];
    [BTkeys addObject:BTKey];
    [responses addObject:response];
    [self updateAndSaveCommands:commands BTKeys:BTkeys andResponses:responses];
    [displayVC reloadDisplayedCommands:commands BTKeys:BTkeys andResponses:responses];
    [addVC displayLabelAlertWithText:@""];
    [self.view endEditing:YES];
    [sideNC popToRootViewControllerAnimated:YES];
}

- (void)showSideNC {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        sideNC.view.frame = CGRectMake(505.0, 137.0, 263.0, 856.0);
    } completion:nil];
}

- (void)hideSideNC {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        sideNC.view.frame = CGRectMake(769.0, 137.0, 263.0, 856.0);
    } completion:nil];
}
//__________________________________________________________
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
