//
//  RandomViewController.h
//  isHipster
//
//  Created by Kirill on 10.01.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *askButton;

- (IBAction)buttonAction:(UIButton *)sender;
- (NSInteger) randomNumber;
@end
