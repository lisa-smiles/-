//
//  MainViewController.m
//  Weather
//
//  Created by lisa on 2016/10/21.
//  Copyright © 2016年 wanglifang. All rights reserved.
//

#import "MainViewController.h"
#import "CitiesTableViewController.h"
#import "NetworkingManager.h"
#import "LocationManager.h"
#import "TemperatureData.h"
@interface MainViewController ()

@property (nonatomic, strong) CLLocation *userlocation;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherConditionsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *temperaturesLabel;
@property (weak, nonatomic) IBOutlet UILabel *highAndLowTemp;
@property (nonatomic, strong)CLGeocoder *geocoder;
@property (nonatomic, copy) NSString *urlStr;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self listenNotification];
}
- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [CLGeocoder new];
    }
    return _geocoder;
}
- (void)listenNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeCity:) name:@"DidCityChange" object:nil];
}

- (void)didChangeCity:(NSNotification *)notification {
    NSString *cityName = notification.userInfo[@"CityName"];
    [self.geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks lastObject];
        self.urlStr = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=4&key=cf11c561a51b35e62ccb5c160f07d", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude];
        self.userlocation = placemark.location;
        NSString *cityStr = placemark.addressDictionary[@"City"];
        self.cityNameLabel.text = cityStr;
        NSLog(@"%@", cityStr);
        [self sendRequestToSever];
    }];
}

- (IBAction)clickButtonChangeCity:(id)sender {
    
    CitiesTableViewController *citiesTableVC = [CitiesTableViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:citiesTableVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)getLocation {

    [LocationManager getUserLocation:^(double lat, double lon) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        self.userlocation = location;
        self.urlStr = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=4&key=cf11c561a51b35e62ccb5c160f07d",lat,lon];
        [self sendRequestToSever];
    }];
}

- (void)sendRequestToSever {

    [NetworkingManager sendGetRequestWithUrl:self.urlStr Withparameters:nil WithSuccessBlock:^(id responseObject) {
        
        [self parseAndUpdate:responseObject];
        
    } withFailuerBlock:^(NSError *err) {
        
    }];
}

- (void)parseAndUpdate:(id)responsObject {
    TemperatureData *tempData = [TemperatureData getTemperatureData:responsObject ];
    if (self.userlocation) {
        [self.geocoder reverseGeocodeLocation:self.userlocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (!error) {
                CLPlacemark *placemark = [placemarks firstObject];
                self.cityNameLabel.text = placemark.addressDictionary[@"City"];
            }
        }];
    }
    self.weatherConditionsLabel.text = tempData.weatherDesc;
    self.temperaturesLabel.text = tempData.weatherTemp;
    self.highAndLowTemp.text = [NSString stringWithFormat:@"%@˚/ %@˚", tempData.maxTemp, tempData.minTemp];
    NSURL *url = [NSURL URLWithString:tempData.iconUrlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.weatherImage.image = image;
}

@end
