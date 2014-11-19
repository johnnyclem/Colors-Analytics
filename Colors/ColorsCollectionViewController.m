//
//  ColorsCollectionViewController.m
//  Colors
//
//  Created by John Clem on 11/19/14.
//  Copyright (c) 2014 Analytics Pros. All rights reserved.
//

#import "ColorsCollectionViewController.h"
#import "UIColor+HexString.h"

@interface ColorsCollectionViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) UIColor *selectedColor;

@end

@implementation ColorsCollectionViewController

static NSString * const reuseIdentifier = @"ColorCell";
static NSString * const headerIdentifier = @"ColorsHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    _colors = [self colorsFromPlistNamed:@"Colors"];
}

- (NSArray *)colorsFromPlistNamed:(NSString *)plistName {
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *root = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *colorsArray = root[@"colors"];
    NSMutableArray *colors = [NSMutableArray array];
    
    for (NSDictionary *colorDict in colorsArray) {
        NSString *colorName = colorDict[@"name"];
        NSString *colorHash = colorDict[@"hash"];
        UIColor *color = [UIColor colorFromHexString:colorHash];
        color.accessibilityLabel = colorName;
        [colors addObject:color];
    }
    
    return colors;
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = _colors[indexPath.row];
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedColor = _colors[indexPath.row];
    NSLog(@"Selected %@", _selectedColor);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Keep This Color?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NewColorSelected" object:nil userInfo:@{@"color": _selectedColor}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(alert.view.frame.size.width - 160.0, 10.0, 36.0, 36.0)];
    colorView.backgroundColor = _selectedColor;
    [alert.view addSubview:colorView];

    [self presentViewController:alert animated:YES completion:nil];

}

@end
