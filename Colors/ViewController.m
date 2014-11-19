//
//  ViewController.m
//  Colors
//
//  Created by John Clem on 11/19/14.
//  Copyright (c) 2014 Analytics Pros. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *colorNameLabel;
@property (nonatomic, weak) IBOutlet UIButton *selectColorbutton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"NewColorSelected" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        UIColor *selectedColor = [note userInfo][@"color"];
        self.view.backgroundColor = selectedColor;
        self.colorNameLabel.text = selectedColor.accessibilityLabel;
        [self.selectColorbutton setTitle:@"Replace Color" forState:UIControlStateApplication];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
