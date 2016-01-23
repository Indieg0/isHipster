//
//  RandomViewController.m
//  isHipster
//
//  Created by Kirill on 10.01.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import "RandomViewController.h"

@interface RandomViewController ()

@end

@implementation RandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.imageView.image = [UIImage imageNamed:@"hs.png"];
    self.askButton.layer.cornerRadius = 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)randomNumber {
    NSInteger random = arc4random()%2;
    return random;
}


- (IBAction)buttonAction:(UIButton *)sender {
    NSArray *yesAnswersArray = @[@"Good idea, dude!",
        @"Go dancing, man!",
        @"Everything would be all right! No doubt!",
        @"Yes, it's really great. Keep calm and carry on!"
        
    ];
    
    NSArray *noAnswersArray = @[@"Maybe, you shouldn't do this?",
        @"It's better to stay at home and listen to some indie.",
        @"Guy, it's better not to do that!",
        @"Stop your motion! Turn back your head!"
    ];
    
    NSInteger i = [self randomNumber];
    
    if (i == 0) {
      self.imageView.image = [UIImage imageNamed:@"no.png"];
      self.textLabel.text = [NSString stringWithFormat:@"%@", [noAnswersArray objectAtIndex:arc4random()%4] ];
    }
    
   else if (i == 1) {
        self.imageView.image = [UIImage imageNamed:@"yes.png"];
      self.textLabel.text = [NSString stringWithFormat:@"%@", [yesAnswersArray objectAtIndex:arc4random()%4] ];
    }
    
    
    
}
@end
