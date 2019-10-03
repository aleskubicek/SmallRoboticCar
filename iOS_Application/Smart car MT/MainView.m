//
//  MainView.m
//  Smart car MT
//
//  Created by Aleš Kubiček on 04.07.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (void)drawRect:(CGRect)rect {
    //Header
    CALayer *header = [CALayer layer];
    [self.layer addSublayer:header];
    header.frame = CGRectMake(0.0, 0.0, 768.0, 127.0);
    header.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:54.0/255.0 blue:60.0/255.0 alpha:1.0].CGColor;
    
    CALayer *header_line = [CALayer layer];
    [self.layer addSublayer:header_line];
    header_line.frame = CGRectMake(0.0, 127.0, 768.0, 10.0);
    header_line.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:32.0/255.0 blue:36.0/255.0 alpha:1.0].CGColor;
    
    UILabel *headerText_small = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 50.0, 768.0, 27.0)];
    [self addSubview:headerText_small];
    headerText_small.text = @"Smart robotic car";
    headerText_small.font = [UIFont systemFontOfSize:27.0];
    headerText_small.textAlignment = NSTextAlignmentCenter;
    headerText_small.textColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    
    UILabel *headerTest_big = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 72.0, 768.0, 38.0)];
    [self addSubview:headerTest_big];
    headerTest_big.text = @"Monitoring tool";
    headerTest_big.font = [UIFont systemFontOfSize:31.5];
    headerTest_big.textAlignment = NSTextAlignmentCenter;
    headerTest_big.textColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    //__________________________________________________________
    
    //Footer
    CALayer *footer = [CALayer layer];
    [self.layer addSublayer:footer];
    footer.frame = CGRectMake(0.0, 993.0, 768.0, 31.0);
    footer.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:38.0/255.0 blue:47.0/255.0 alpha:1.0].CGColor;
    
    BTlogo = [[UIImageView alloc] initWithFrame:CGRectMake(14.0, 997.0, 12.0, 23.0)];
    [self addSubview:BTlogo];
    BTlogo.image = [UIImage imageNamed:@"BTlogo.png"];
    BTlogo.image = [BTlogo.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    BTlogo.tintColor = [UIColor colorWithRed:146.0/255.0 green:0.0/255.0 blue:8.0/255.0 alpha:1.0];
    //    BTlogo.tintColor = [UIColor colorWithRed:230.0/255.0 green:182.0/255.0 blue:78.0/255.0 alpha:1.0]; - greenMode
    
    BLEstate = [[UILabel alloc] initWithFrame:CGRectMake(36.0, 997.0, 300.0, 23.0)];
    [self addSubview:BLEstate];
    BLEstate.text = @"Disconnected";
    BLEstate.font = [UIFont systemFontOfSize:16.0];
    BLEstate.textAlignment = NSTextAlignmentLeft;
    BLEstate.textColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0];
    
    UIButton *toggleSideNC = [UIButton buttonWithType:UIButtonTypeSystem];
    toggleSideNC.frame = CGRectMake(575.0, 993.0, 178.0, 31.0);
    toggleSideNC.tintColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0];
    [toggleSideNC setTitle:@"Voice commands setting" forState:UIControlStateNormal];
    [toggleSideNC addTarget:self action:@selector(toggleSideNC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:toggleSideNC];
    //__________________________________________________________
    
    //Robot Outline
    UIImageView *Robot_outline = [[UIImageView alloc] initWithFrame:CGRectMake(188.0, 323.0, 391.0, 441.0)];
    [self addSubview:Robot_outline];
    Robot_outline.image = [UIImage imageNamed:@"Robot_outline.png"];
    //__________________________________________________________
    
    //Robot Control
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(193.0, 479.0, 71.0, 158.0);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"LButton_off.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:(@selector(LeftButtonPressedDown:)) forControlEvents:UIControlEventTouchDown];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"LButton_on.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:(@selector(LeftButtonReleased:)) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(503.0, 479.0, 71.0, 158.0);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"RButton_off.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:(@selector(RightButtonPressedDown:)) forControlEvents:UIControlEventTouchDown];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"RButton_on.png"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:(@selector(RightButtonReleased:)) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.frame = CGRectMake(357.0, 428.0, 53.0, 55.0);
    [upButton setBackgroundImage:[UIImage imageNamed:@"UPButton_off.png"] forState:UIControlStateNormal];
    [upButton addTarget:self action:(@selector(UpButtonPressedDown:)) forControlEvents:UIControlEventTouchDown];
    [upButton setBackgroundImage:[UIImage imageNamed:@"UPButton_on.png"] forState:UIControlStateHighlighted];
    [upButton addTarget:self action:(@selector(UpButtonReleased:)) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:upButton];
    
    UIButton *dwButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dwButton.frame = CGRectMake(357.0, 633.0, 53.0, 55.0);
    [dwButton setBackgroundImage:[UIImage imageNamed:@"DWButton_off.png"] forState:UIControlStateNormal];
    [dwButton addTarget:self action:(@selector(DwButtonPressedDown:)) forControlEvents:UIControlEventTouchDown];
    [dwButton setBackgroundImage:[UIImage imageNamed:@"DWButton_on.png"] forState:UIControlStateHighlighted];
    [dwButton addTarget:self action:(@selector(DwButtonReleased:)) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dwButton];
    //__________________________________________________________
    
    //Follow Sensor
    UIImageView *FLSensor = [[UIImageView alloc] initWithFrame:CGRectMake(289.0, 507.0, 188.0, 66.0)];
    FLSensor.image = [UIImage imageNamed:@"FollowSensor.png"];
    [self addSubview:FLSensor];
    
    CGRect outlineRect = CGRectMake(0.0, 0.0, 28.0, 28.0);
    CGRect fillRect = CGRectMake(0.0, 0.0, 20.0, 20.0);
    
    CAShapeLayer *CircleSensorOutline_1 = [CAShapeLayer layer];
    CircleSensorOutline_1.bounds = outlineRect;
    CircleSensorOutline_1.position = CGPointMake(305.0, 598.0);
    UIBezierPath *CSO_1_circle = [UIBezierPath bezierPathWithOvalInRect:CircleSensorOutline_1.bounds];
    CircleSensorOutline_1.path = CSO_1_circle.CGPath;
    CircleSensorOutline_1.fillColor = [UIColor clearColor].CGColor;
    CircleSensorOutline_1.strokeColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    CircleSensorOutline_1.lineWidth = 4.0;
    [self.layer addSublayer:CircleSensorOutline_1];
    
    CircleSensor_1 = [CAShapeLayer layer];
    CircleSensor_1.bounds = fillRect;
    CircleSensor_1.position = CGPointMake(305.0, 598.0);
    UIBezierPath *CS_1 = [UIBezierPath bezierPathWithOvalInRect:CircleSensor_1.bounds];
    CircleSensor_1.path = CS_1.CGPath;
    CircleSensor_1.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:CircleSensor_1];
    
    CAShapeLayer *CircleSensorOutline_2 = [CAShapeLayer layer];
    CircleSensorOutline_2.bounds = outlineRect;
    CircleSensorOutline_2.position = CGPointMake(363.0, 598.0);
    UIBezierPath *CSO_2_circle = [UIBezierPath bezierPathWithOvalInRect:CircleSensorOutline_2.bounds];
    CircleSensorOutline_2.path = CSO_2_circle.CGPath;
    CircleSensorOutline_2.fillColor = [UIColor clearColor].CGColor;
    CircleSensorOutline_2.strokeColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    CircleSensorOutline_2.lineWidth = 4.0;
    [self.layer addSublayer:CircleSensorOutline_2];
    
    CircleSensor_2 = [CAShapeLayer layer];
    CircleSensor_2.bounds = fillRect;
    CircleSensor_2.position = CGPointMake(363.0, 598.0);
    UIBezierPath *CS_2 = [UIBezierPath bezierPathWithOvalInRect:CircleSensor_2.bounds];
    CircleSensor_2.path = CS_2.CGPath;
    CircleSensor_2.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:CircleSensor_2];
    
    CAShapeLayer *CircleSensorOutline_3 = [CAShapeLayer layer];
    CircleSensorOutline_3.bounds = outlineRect;
    CircleSensorOutline_3.position = CGPointMake(405.0, 598.0);
    UIBezierPath *CSO_3_circle = [UIBezierPath bezierPathWithOvalInRect:CircleSensorOutline_3.bounds];
    CircleSensorOutline_3.path = CSO_3_circle.CGPath;
    CircleSensorOutline_3.fillColor = [UIColor clearColor].CGColor;
    CircleSensorOutline_3.strokeColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    CircleSensorOutline_3.lineWidth = 4.0;
    [self.layer addSublayer:CircleSensorOutline_3];
    
    CircleSensor_3 = [CAShapeLayer layer];
    CircleSensor_3.bounds = fillRect;
    CircleSensor_3.position = CGPointMake(405.0, 598.0);
    UIBezierPath *CS_3 = [UIBezierPath bezierPathWithOvalInRect:CircleSensor_3.bounds];
    CircleSensor_3.path = CS_3.CGPath;
    CircleSensor_3.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:CircleSensor_3];
    
    CAShapeLayer *CircleSensorOutline_4 = [CAShapeLayer layer];
    CircleSensorOutline_4.bounds = outlineRect;
    CircleSensorOutline_4.position = CGPointMake(462.0, 598.0);
    UIBezierPath *CSO_4_circle = [UIBezierPath bezierPathWithOvalInRect:CircleSensorOutline_4.bounds];
    CircleSensorOutline_4.path = CSO_4_circle.CGPath;
    CircleSensorOutline_4.fillColor = [UIColor clearColor].CGColor;
    CircleSensorOutline_4.strokeColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    CircleSensorOutline_4.lineWidth = 4.0;
    [self.layer addSublayer:CircleSensorOutline_4];
    
    CircleSensor_4 = [CAShapeLayer layer];
    CircleSensor_4.bounds = fillRect;
    CircleSensor_4.position = CGPointMake(462.0, 598.0);
    UIBezierPath *CS_4 = [UIBezierPath bezierPathWithOvalInRect:CircleSensor_4.bounds];
    CircleSensor_4.path = CS_4.CGPath;
    CircleSensor_4.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:CircleSensor_4];
    //__________________________________________________________
    
    //Light Sensor
    LightSensor_left = [[UIImageView alloc] initWithFrame:CGRectMake(324.0, 383.0, 29.0, 52.0)];
    [self addSubview:LightSensor_left];
    LightSensor_left.image = [UIImage imageNamed:@"LSensor_off.png"];
    
    LightSensor_right = [[UIImageView alloc] initWithFrame:CGRectMake(414.0, 383.0, 29.0, 52.0)];
    [self addSubview:LightSensor_right];
    LightSensor_right.image = [UIImage imageNamed:@"LSensor_off.png"];
    //__________________________________________________________
    
    //Ultrasonic Sensor
    Signal_line1 = [[UIImageView alloc] initWithFrame:CGRectMake(323.0, 261.0, 130.0, 47.0)];
    [self addSubview:Signal_line1];
    Signal_line1.image = [UIImage imageNamed:@"Signal_line1.png"];
    Signal_line1.image = [Signal_line1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    Signal_line1.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    
    Signal_line2 = [[UIImageView alloc] initWithFrame:CGRectMake(286.0, 214.0, 203.0, 57.0)];
    [self addSubview:Signal_line2];
    Signal_line2.image = [UIImage imageNamed:@"Signal_line2.png"];
    Signal_line2.image = [Signal_line2.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    Signal_line2.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    
    Signal_line3 = [[UIImageView alloc] initWithFrame:CGRectMake(250.0, 164.0, 273.0, 71.0)];
    [self addSubview:Signal_line3];
    Signal_line3.image = [UIImage imageNamed:@"Signal_line3.png"];
    Signal_line3.image = [Signal_line3.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    Signal_line3.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    
    USSensor_distance = [[UILabel alloc] initWithFrame:CGRectMake(505.0, 231.0, 113.0, 54.0)];
    [self addSubview:USSensor_distance];
    USSensor_distance.text = @"25";
    USSensor_distance.font = [UIFont systemFontOfSize:60.0];
    USSensor_distance.textColor = [UIColor colorWithRed:203.0/255.0 green:38.0/255.0 blue:47.0/255.0 alpha:1.0];
    USSensor_distance.textAlignment = NSTextAlignmentRight;
    
    UILabel *USSensor_unit = [[UILabel alloc] initWithFrame:CGRectMake(600.0, 239.0, 54.0, 30.0)];
    [self addSubview:USSensor_unit];
    USSensor_unit.text = @"cm";
    USSensor_unit.font = [UIFont systemFontOfSize:33.0];
    USSensor_unit.transform = CGAffineTransformMakeRotation(- M_PI_2);
    USSensor_unit.textColor = [UIColor colorWithRed:203.0/255.0 green:38.0/255.0 blue:47.0/255.0 alpha:1.0];
    
    UILabel *USSensor_title = [[UILabel alloc] initWithFrame:CGRectMake(658.0, 240.0, 86.0, 17.0)];
    [self addSubview:USSensor_title];
    USSensor_title.text = @"Ultrasonic";
    USSensor_title.font = [UIFont systemFontOfSize:18.0];
    USSensor_title.textColor = [UIColor colorWithRed:14.0/255.0 green:54.0/255.0 blue:87.0/255.0 alpha:1.0];
    
    UILabel *USSensor_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(658.0, 255.0, 86.0, 20.0)];
    [self addSubview:USSensor_subtitle];
    USSensor_subtitle.text = @"sensor";
    USSensor_subtitle.font = [UIFont systemFontOfSize:27.0];
    USSensor_subtitle.textColor = [UIColor colorWithRed:14.0/255.0 green:54.0/255.0 blue:87.0/255.0 alpha:1.0];
    //__________________________________________________________
    
    //Humidity & Temperature Sensor
    UIImageView *Humidity_icon = [[UIImageView alloc] initWithFrame:CGRectMake(36.0, 832.0, 89.0, 61.0)];
    [self addSubview:Humidity_icon];
    Humidity_icon.image = [UIImage imageNamed:@"HSensor.png"];
    
    Humidity_value = [[UILabel alloc] initWithFrame:CGRectMake(134.0, 848.0, 70.0, 29.0)];
    [self addSubview:Humidity_value];
    Humidity_value.text = @"5";
    Humidity_value.font = [UIFont systemFontOfSize:39.35];
    Humidity_value.textColor = [UIColor colorWithRed:2.0/255.0 green:130.0/255.0 blue:191.0/255.0 alpha:1.0];
    Humidity_value.textAlignment = NSTextAlignmentRight;
    
    UILabel *Humidity_unit = [[UILabel alloc] initWithFrame:CGRectMake(204.0, 848.0, 50.0, 29.0)];
    [self addSubview:Humidity_unit];
    Humidity_unit.text = @"%";
    Humidity_unit.font = [UIFont systemFontOfSize:39.35];
    Humidity_unit.textColor = [UIColor colorWithRed:2.0/255.0 green:130.0/255.0 blue:191.0/255.0 alpha:1.0];
    Humidity_unit.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *Temperature_icon = [[UIImageView alloc] initWithFrame:CGRectMake(36.0, 908.0, 89.0, 61.0)];
    [self addSubview:Temperature_icon];
    Temperature_icon.image = [UIImage imageNamed:@"TSensor.png"];
    
    Temperature_value = [[UILabel alloc] initWithFrame:CGRectMake(134.0, 923.0, 70.0, 29.0)];
    [self addSubview:Temperature_value];
    Temperature_value.text = @"25";
    Temperature_value.font = [UIFont systemFontOfSize:39.35];
    Temperature_value.textColor = [UIColor colorWithRed:223.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:1.0];
    Temperature_value.textAlignment = NSTextAlignmentRight;
    
    UILabel *Temperature_unit = [[UILabel alloc] initWithFrame:CGRectMake(204.0, 923.0, 50.0, 29.0)];
    [self addSubview:Temperature_unit];
    Temperature_unit.text = @"°C";
    Temperature_unit.font = [UIFont systemFontOfSize:38.0];
    Temperature_unit.textColor = [UIColor colorWithRed:223.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:1.0];
    Temperature_unit.textAlignment = NSTextAlignmentLeft;
    //__________________________________________________________
    
    //Slider
    self.Configuration_slider  = [[UISlider alloc] initWithFrame:CGRectMake(209.0, 785.0, 350.0, 10.0)];
    [self addSubview:self.Configuration_slider];
    self.Configuration_slider.minimumValue = 0.0;
    self.Configuration_slider.maximumValue = 100.0;
    self.Configuration_slider.value = 50.0;
    self.Configuration_slider.minimumTrackTintColor = [UIColor colorWithRed:14.0/255.0 green:54.0/255.0 blue:87.0/255.0 alpha:1.0];
    self.Configuration_slider.maximumTrackTintColor = [UIColor colorWithRed:14.0/255.0 green:54.0/255.0 blue:87.0/255.0 alpha:1.0];
    self.Configuration_slider.thumbTintColor = [UIColor colorWithRed:14.0/255.0 green:54.0/255.0 blue:87.0/255.0 alpha:1.0];
    [self.Configuration_slider addTarget:self action:@selector(CSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    //__________________________________________________________
    
    //VoiceControl Button
    Voice_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:Voice_btn];
    Voice_btn.frame = CGRectMake(604.0, 848.0, 108.0, 109.0);
    Voice_btn.clipsToBounds = YES;
    [Voice_btn setImage:[UIImage imageNamed:@"VC_button.png"] forState:UIControlStateNormal];
    [Voice_btn addTarget:self action:@selector(VoiceControl_activate:) forControlEvents:UIControlEventTouchDown];
    
    Voice_circle = [CAShapeLayer layer];
    [self.layer addSublayer:Voice_circle];
    Voice_circle.bounds = CGRectMake(0.0, 0.0, 119.0, 120.0);
    Voice_circle.position = CGPointMake(658.0, 902.5);
    UIBezierPath *VC_path = [UIBezierPath bezierPathWithOvalInRect:Voice_circle.bounds];
    Voice_circle.path = VC_path.CGPath;
    Voice_circle.fillColor = [UIColor clearColor].CGColor;
    Voice_circle.strokeColor = [UIColor colorWithRed:227.0/255.0 green:124.0/255.0 blue:62.0/255.0 alpha:1.0].CGColor;
    Voice_circle.lineWidth = 3.0;
    //__________________________________________________________
        
    //Behavior left corner
    UIImageView *Behavior_lines = [[UIImageView alloc] initWithFrame:CGRectMake(36.0, 197.0, 125.0, 125.0)];
    [self addSubview:Behavior_lines];
    Behavior_lines.image = [UIImage imageNamed:@"Beh_lines.png"];
    
    Behavior_car = [[UIImageView alloc] initWithFrame:CGRectMake(55.5, 208.0, 85.0, 95.0)];
    [self addSubview:Behavior_car];
    Behavior_car.image = [UIImage imageNamed:@"Beh_car.png"];
    //__________________________________________________________

}


//Main UI methods - senders etc.
- (void)toggleSideNC:(id)sender {
    [self.delegate toggleSideNC];
}

- (void)VoiceControl_activate:(id)sender {
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        Voice_circle.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(1.08, 1.08));
        Voice_circle.lineWidth = 5.0;
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        Voice_btn.transform = CGAffineTransformMakeScale(1.03, 1.03);
    } completion:nil];
    [self.delegate VoiceControl_activate];
    [self VoiceControl_popover];
    
}

- (void)VoiceControl_popover {
    UIViewController *VoicePopover_controller = [[UIViewController alloc] init];
    VoicePopover_view = [[UIView alloc] initWithFrame:CGRectMake(585.0, 848.0, 280.0, 104.0)];
    VoicePopover_view.backgroundColor = [UIColor whiteColor];
    
    UILabel *VC_state = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 7.0, 280.0, 25.0)];
    [VoicePopover_view addSubview:VC_state];
    VC_state.text = @"Tell me what to do!";
    VC_state.font = [UIFont systemFontOfSize:15.0];
    VC_state.textAlignment = NSTextAlignmentCenter;
    VC_state.textColor = [UIColor colorWithRed:14.0/255.0 green:54.0/255.0 blue:87.0/255.0 alpha:1.0];
    
    CALayer *VC_line = [CALayer layer];
    [VoicePopover_view.layer addSublayer:VC_line];
    VC_line.frame = CGRectMake(20.0, 32.0, 240.0, 0.8);
    VC_line.backgroundColor = [UIColor colorWithRed:14.0/255.0 green:54.0/255.0 blue:87.0/255.0 alpha:1.0].CGColor;
    
    Voice_command = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 40.0, 260.0, 25.0)];
    [VoicePopover_view addSubview:Voice_command];
    Voice_command.text = @"";
    Voice_command.font = [UIFont boldSystemFontOfSize:14.0];
    Voice_command.textAlignment = NSTextAlignmentCenter;
    Voice_command.textColor = [UIColor redColor];
    
    UIButton *VC_exit = [UIButton buttonWithType:UIButtonTypeSystem];
    [VoicePopover_view addSubview:VC_exit];
    VC_exit.frame = CGRectMake(140.0, 80.0, 141.0, 25.0);
    [VC_exit setTitle:@"Close" forState:UIControlStateNormal];
    [VC_exit addTarget:self action:@selector(VoiceControl_dismissPopover:) forControlEvents:UIControlEventTouchDown];
    VC_exit.layer.borderWidth = 0.8;
    VC_exit.layer.borderColor = [UIColor colorWithRed:114.0/255.0 green:183.0/255.0 blue:250.0/255.0 alpha:1.0].CGColor;
    
    UIButton *VC_recognize = [UIButton buttonWithType:UIButtonTypeSystem];
    [VoicePopover_view addSubview:VC_recognize];
    VC_recognize.frame = CGRectMake(-1.0, 80.0, 142.0, 25.0);
    [VC_recognize setTitle:@"Recognize" forState:UIControlStateNormal];
    [VC_recognize addTarget:self action:@selector(VoiceControl_recognizeSpeech:) forControlEvents:UIControlEventTouchDown];
    VC_recognize.layer.borderWidth = 0.8;
    VC_recognize.layer.borderColor = [UIColor colorWithRed:114.0/255.0 green:183.0/255.0 blue:250.0/255.0 alpha:1.0].CGColor;
    
    VoicePopover_controller.modalInPopover = YES;
    VoicePopover_controller.modalPresentationStyle = UIModalPresentationPageSheet;
    
    VoicePopover_controller.view = VoicePopover_view;
    VoicePopover_controller.preferredContentSize = CGSizeMake(280.0, 104.0);
    Voice_popover = [[UIPopoverController alloc] initWithContentViewController:VoicePopover_controller];
    [Voice_popover presentPopoverFromRect:CGRectMake(585.0, 848.0, 280.0, 104.0) inView:self permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    
}

- (void)VoiceControl_recognizeSpeech:(id)sender {
    NSLog(@"recognize speech..");
}

- (void)VoiceControl_dismissPopover:(id)sender {
    [Voice_popover dismissPopoverAnimated:YES];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        Voice_btn.transform = CGAffineTransformMakeScale(1.00, 1.00);
    } completion:nil];
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        Voice_circle.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(1.00, 1.00));
        Voice_circle.lineWidth = 3.0;
    } completion:nil];
    
}

- (void)CSliderValueChanged:(id)sender {
    [self.delegate CSliderValueChanged];
}

- (void)LeftButtonPressedDown:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:3];
    } completion:nil];
    [self.delegate LeftButtonPressedDown];
}

- (void)LeftButtonReleased:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:0];
    } completion:nil];
    [self.delegate LeftButtonReleased];
}

- (void)RightButtonPressedDown:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:4];
    } completion:nil];
    [self.delegate RightButtonPressedDown];
}
- (void)RightButtonReleased:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:0];
    } completion:nil];
    [self.delegate RightButtonReleased];
}

- (void)UpButtonPressedDown:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:1];
    } completion:nil];
    [self.delegate UpButtonPressedDown];
}

- (void)UpButtonReleased:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:0];
    } completion:nil];
    [self.delegate UpButtonReleased];
}

- (void)DwButtonPressedDown:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:2];
    } completion:nil];
    [self.delegate DwButtonPressedDown];
}

- (void)DwButtonReleased:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:0];
    } completion:nil];
    [self.delegate DwButtonReleased];
}
//__________________________________________________________


//Custom methods
- (void)BehaviorCarSet:(int)carPositon {
    switch (carPositon) {
        case 1:
            //up
            Behavior_car.frame = CGRectMake(55.0, 190.0, 85.0, 95.0);
            break;
            
        case 2:
            //down
            Behavior_car.frame = CGRectMake(55.0, 226.0, 85.0, 95.0);
            break;
            
        case 3:
            //left
            Behavior_car.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
            
        case 4:
            //right
            Behavior_car.transform = CGAffineTransformMakeRotation(-M_PI_2);
            break;
            
        default:
            Behavior_car.transform = CGAffineTransformMakeRotation(0);
            Behavior_car.frame = CGRectMake(55.0, 208.0, 85.0, 95.0);
            break;
    }
}

- (void)DictatedText:(NSString *)text {
    Voice_command.text = text;
}

- (void)ChangeBluetoothState:(NSString *)text withLogoColor:(UIColor *)color {
    BLEstate.text = text;
    BTlogo.tintColor = color;
}

- (void)LightSensor:(int)sensor setSensorState:(int)sensorState {
    switch (sensor) {
        case 1:
            if (sensorState == 0)
                LightSensor_left.image = [UIImage imageNamed:@"LSensor_off.png"];
            else
                LightSensor_left.image = [UIImage imageNamed:@"LSensor_on.png"];
            break;
            
        case 2:
            if (sensorState == 0)
                LightSensor_right.image = [UIImage imageNamed:@"LSensor_off.png"];
            else
                LightSensor_right.image = [UIImage imageNamed:@"LSensor_on.png"];
            break;
            
        default:
            break;
    }
}

- (void)UltrasonicSensorDistance:(int)distance {
    USSensor_distance.text = [NSString stringWithFormat:@"%i", distance];
    if (distance < 16) {
        Signal_line1.tintColor = [UIColor colorWithRed:242.0/255.0 green:160.0/255.0 blue:15.0/255.0 alpha:1.0];
        Signal_line2.tintColor = [UIColor colorWithRed:241.0/255.0 green:140.0/255.0 blue:32.0/255.0 alpha:1.0];
        Signal_line3.tintColor = [UIColor colorWithRed:241.0/255.0 green:96.0/255.0 blue:32.0/255.0 alpha:1.0];
    } else if (distance > 15 && distance < 31) {
        Signal_line1.tintColor = [UIColor colorWithRed:242.0/255.0 green:160.0/255.0 blue:15.0/255.0 alpha:1.0];
        Signal_line2.tintColor = [UIColor colorWithRed:241.0/255.0 green:140.0/255.0 blue:32.0/255.0 alpha:1.0];
        Signal_line3.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    } else if (distance > 30 && distance < 51) {
        Signal_line1.tintColor = [UIColor colorWithRed:242.0/255.0 green:160.0/255.0 blue:15.0/255.0 alpha:1.0];
        Signal_line2.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
        Signal_line3.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    } else {
        Signal_line1.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
        Signal_line2.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
        Signal_line3.tintColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
    }
    
}

- (void)FollowSensor:(int)sensor setSensorState:(int)sensorState {
    UIColor *stateColor;
    if (sensorState == 0) {
        stateColor = [UIColor clearColor];
    } else if (sensorState == 1) {
        stateColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0];
    }
    switch (sensor) {
        case 1:
            CircleSensor_1.fillColor = stateColor.CGColor;
            break;
            
        case 2:
            CircleSensor_2.fillColor = stateColor.CGColor;
            break;
            
        case 3:
            CircleSensor_3.fillColor = stateColor.CGColor;
            break;
            
        case 4:
            CircleSensor_4.fillColor = stateColor.CGColor;
            break;
            
        default:
            break;
    }
}

- (void)TemperatureSensorSetValue:(int)temperature {
    Temperature_value.text = [NSString stringWithFormat:@"%i", temperature];
}

- (void)HumiditySensorSetValue:(int)humidity {
    Humidity_value.text = [NSString stringWithFormat:@"%i", humidity];
}

- (void)CarDirectionMoving:(int)direction {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self BehaviorCarSet:direction];
    } completion:nil];
}
//__________________________________________________________

@end
