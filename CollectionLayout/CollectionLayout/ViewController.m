//
//  ViewController.m
//  CollectionLayout
//
//  Created by Abe on 2017/8/31.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import "ViewController.h"
#import "CardScrollLayout.h"
#import "CardScrollCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) CardScrollLayout *cardLayout;

@end
static NSString *const cellIdentifier = @"cardCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cardLayout = [[CardScrollLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100) collectionViewLayout:self.cardLayout];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    
    [self.collectionView registerClass:[CardScrollCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.num = indexPath.row;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
