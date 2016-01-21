//
//  ViewController.h
//  isHipster
//
//  Created by Kirill on 10.01.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *todayTemp;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dayLabels;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *tempLabels;

- (IBAction)update:(id)sender;
@end

