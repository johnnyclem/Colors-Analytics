//
//  AppDelegate.h
//  Colors
//
//  Created by John Clem on 11/19/14.
//  Copyright (c) 2014 Analytics Pros. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TAGContainer;
@class TAGManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TAGManager *tagManager;
@property (nonatomic, strong) TAGContainer *container;


@end

