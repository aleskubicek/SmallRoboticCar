//
//  MainView.h
//  Smart car MT
//
//  Created by Aleš Kubiček on 04.07.15.
//  Copyright (c) 2015 Aleš Kubiček. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainViewControl <NSObject>

- (void)toggleSideNC;
- (void)VoiceControl_activate;
- (void)CSliderValueChanged;
- (void)LeftButtonPressedDown;
- (void)LeftButtonReleased;
- (void)RightButtonPressedDown;
- (void)RightButtonReleased;
- (void)UpButtonPressedDown;
- (void)UpButtonReleased;
- (void)DwButtonPressedDown;
- (void)DwButtonReleased;

@end

@interface MainView : UIView {
    UILabel *BLEstate;
    UIImageView *BTlogo;
    CAShapeLayer *CircleSensor_1;
    CAShapeLayer *CircleSensor_2;
    CAShapeLayer *CircleSensor_3;
    CAShapeLayer *CircleSensor_4;
    UIImageView *LightSensor_left;
    UIImageView *LightSensor_right;
    UIImageView *Signal_line1;
    UIImageView *Signal_line2;
    UIImageView *Signal_line3;
    UILabel *USSensor_distance;
    UILabel *Humidity_value;
    UILabel *Temperature_value;
    UIButton *Voice_btn;
    CAShapeLayer *Voice_circle;
    UIImageView *Behavior_car;
    UIPopoverController *Voice_popover;
    UIView *VoicePopover_view;
    UILabel *Voice_command;
}

@property (nonatomic, assign) id <MainViewControl> delegate;
@property (nonatomic, strong) UISlider *Configuration_slider;

- (void)DictatedText:(NSString *)text;
- (void)ChangeBluetoothState:(NSString *)text withLogoColor:(UIColor *)color;
- (void)LightSensor:(int)sensor setSensorState:(int)sensorState;
- (void)UltrasonicSensorDistance:(int)distance;
- (void)FollowSensor:(int)sensor setSensorState:(int)sensorState;
- (void)TemperatureSensorSetValue:(int)temperature;
- (void)HumiditySensorSetValue:(int)humidity;
- (void)CarDirectionMoving:(int)direction;

@end
