//
//  ViewController.m
//  isHipster
//
//  Created by Kirill on 10.01.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *dayNames;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSArray *convertedDay;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.updateButton.layer.cornerRadius = 4;
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
       [self.locationManager startUpdatingLocation];
   
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self namesOfDays];
    int i = 1;
    for (UILabel *label in self.dayLabels) {
        label.text = [NSString stringWithFormat:@"%@", [self.dayNames objectAtIndex:i]];
        i++;
    }
    
    

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)namesOfDays {
    NSMutableArray *namesOfDays = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        int interval = i*60*60*24;
        NSDate * todayDate = [NSDate dateWithTimeIntervalSinceNow:interval];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *dayName = [dateFormatter stringFromDate: todayDate];
        [namesOfDays addObject:dayName];
    }
    self.dayNames = namesOfDays;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)weatherQuery {
    NSString *urlString = [[NSString alloc]init];
    
    urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&cnt=7&mode=json&appid=f326fca549538d8435711b4931cba468", self.latitude, self.longitude];
    
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:urlString]];
    
    NSError *error;
    NSMutableDictionary *time = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
    
    
    
    NSArray *list = time[@"list"];
    NSMutableDictionary *temperature = [[NSMutableDictionary alloc] init];
    NSMutableArray *allTemp = [NSMutableArray array];
    for (NSDictionary *course in list) {
        
        [temperature setObject:course forKey:@"temp"];
        // NSLog(@"Temperatures: %@,", course[@"temp"]);
        [allTemp addObject:course[@"temp"]];
    }
  NSLog(@"%@", allTemp);
    
    
    NSMutableArray *dayTemp = [NSMutableArray array];
    for (NSDictionary *course in allTemp) {
        
        [temperature setObject:course forKey:@"day"];
        // NSLog(@"Temperatures: %@,", course[@"temp"]);
        [dayTemp addObject:course[@"day"]];
    }
    
    NSMutableArray *convertedDayArray = [NSMutableArray array];
    for (NSString* obj in dayTemp) {
        CGFloat celvinTemp = [obj floatValue];
        CGFloat celsiumTemp = celvinTemp - 273;
        [convertedDayArray addObject:[NSString stringWithFormat:@"%1.f", celsiumTemp]];
    }
    NSLog(@"%@", convertedDayArray);
    self.convertedDay = convertedDayArray;
    NSDictionary *city = time[@"city"];

    NSString *cityName = city[@"name"];
    NSLog(@"%@", cityName);
    self.cityLabel.text = cityName;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    
        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    
 [self.locationManager stopUpdatingLocation];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)update:(id)sender {
    [self weatherQuery];
    
    int tempCounter = 1;
    if ([[self.convertedDay objectAtIndex:0] floatValue] > 0) {
        self.todayTemp.text = [NSString stringWithFormat:@"+%@°С", [self.convertedDay objectAtIndex:0]];
    } else {
        self.todayTemp.text = [NSString stringWithFormat:@"%@°С", [self.convertedDay objectAtIndex:0]];
    }
    
    for (UILabel *label in self.tempLabels) {
        if ([[self.convertedDay objectAtIndex:tempCounter] floatValue] > 0) {
            label.text = [NSString stringWithFormat:@"+%@°С", [self.convertedDay objectAtIndex:tempCounter]];
        } else {
            label.text = [NSString stringWithFormat:@"%@°С", [self.convertedDay objectAtIndex:tempCounter]];
        }
        tempCounter++;
    }
}
@end
