//
//  ViewController.m
//  Colors
//
//  Created by John Clem on 11/19/14.
//  Copyright (c) 2014 Analytics Pros. All rights reserved.
//

#import "ViewController.h"
#import "TAGDataLayer.h"
#import "TAGManager.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *colorNameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"NewColorSelected" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        UIColor *selectedColor = [note userInfo][@"color"];
        self.view.backgroundColor = selectedColor;
        self.colorNameLabel.text = selectedColor.accessibilityLabel;
        
        TAGDataLayer *dataLayer = [[TAGManager instance] dataLayer];
        NSDictionary *event = @{ @"event": @"color-new-selection"};
        [dataLayer push:event];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    TAGDataLayer *dataLayer = [[TAGManager instance] dataLayer];
    NSDictionary *event = @{ @"event": @"screen", @"screen-name": @"Home Screen"};
    [dataLayer push:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
